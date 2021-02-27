package cn.exrick.xboot.modules.base.controller.manage;

import cn.exrick.xboot.common.constant.CommonConstant;
import cn.exrick.xboot.common.exception.XbootException;
import cn.exrick.xboot.common.redis.RedisTemplateHelper;
import cn.exrick.xboot.common.utils.CommonUtil;
import cn.exrick.xboot.common.utils.ResultUtil;
import cn.exrick.xboot.common.utils.SecurityUtil;
import cn.exrick.xboot.common.vo.Result;
import cn.exrick.xboot.config.security.permission.MySecurityMetadataSource;
import cn.exrick.xboot.modules.base.entity.Permission;
import cn.exrick.xboot.modules.base.entity.RolePermission;
import cn.exrick.xboot.modules.base.entity.User;
import cn.exrick.xboot.modules.base.service.PermissionService;
import cn.exrick.xboot.modules.base.service.RolePermissionService;
import cn.exrick.xboot.modules.base.service.mybatis.IPermissionService;
import cn.exrick.xboot.modules.base.utils.VoUtil;
import cn.exrick.xboot.modules.base.vo.MenuVo;
import cn.hutool.core.util.StrUtil;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheConfig;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import java.util.Comparator;
import java.util.List;
import java.util.concurrent.TimeUnit;
import java.util.stream.Collectors;

/**
 * @author Exrick
 */
@Slf4j
@RestController
@Api(tags = "菜单权限管理接口")
@RequestMapping("/xboot/permission")
@CacheConfig(cacheNames = "permission")
@Transactional
public class PermissionController {

    @Autowired
    private PermissionService permissionService;

    @Autowired
    private RolePermissionService rolePermissionService;

    @Autowired
    private IPermissionService iPermissionService;

    @Autowired
    private RedisTemplateHelper redisTemplate;

    @Autowired
    private SecurityUtil securityUtil;

    @Autowired
    private MySecurityMetadataSource mySecurityMetadataSource;

    @RequestMapping(value = "/getMenuList", method = RequestMethod.GET)
    @ApiOperation(value = "获取用户页面菜单数据")
    public Result<List<MenuVo>> getAllMenuList() {

        List<MenuVo> menuList;
        // 读取缓存
        User u = securityUtil.getCurrUser();
        String key = "permission::userMenuList:" + u.getId();
        String v = redisTemplate.get(key);
        if (StrUtil.isNotBlank(v)) {
            menuList = new Gson().fromJson(v, new TypeToken<List<MenuVo>>() {
            }.getType());
            return new ResultUtil<List<MenuVo>>().setData(menuList);
        }

        // 用户所有权限 已排序去重
        List<Permission> list = iPermissionService.findByUserId(u.getId());

        // 筛选0级页面
        menuList = list.stream().filter(p -> CommonConstant.PERMISSION_NAV.equals(p.getType()))
                .sorted(Comparator.comparing(Permission::getSortOrder))
                .map(VoUtil::permissionToMenuVo).collect(Collectors.toList());
        getMenuByRecursion(menuList, list);

        // 缓存
        redisTemplate.set(key, new Gson().toJson(menuList), 15L, TimeUnit.DAYS);
        return new ResultUtil<List<MenuVo>>().setData(menuList);
    }

    private void getMenuByRecursion(List<MenuVo> curr, List<Permission> list) {

        curr.forEach(e -> {
            if (CommonConstant.LEVEL_TWO.equals(e.getLevel())) {
                List<String> buttonPermissions = list.stream()
                        .filter(p -> (e.getId()).equals(p.getParentId()) && CommonConstant.PERMISSION_OPERATION.equals(p.getType()))
                        .sorted(Comparator.comparing(Permission::getSortOrder))
                        .map(Permission::getButtonType).collect(Collectors.toList());
                e.setPermTypes(buttonPermissions);
            } else {
                List<MenuVo> children = list.stream()
                        .filter(p -> (e.getId()).equals(p.getParentId()) && CommonConstant.PERMISSION_PAGE.equals(p.getType()))
                        .sorted(Comparator.comparing(Permission::getSortOrder))
                        .map(VoUtil::permissionToMenuVo).collect(Collectors.toList());
                e.setChildren(children);
                if (e.getLevel() < 3) {
                    getMenuByRecursion(children, list);
                }
            }
        });
    }

    @RequestMapping(value = "/getAllList", method = RequestMethod.GET)
    @ApiOperation(value = "获取权限菜单树")
    @Cacheable(key = "'allList'")
    public Result<List<Permission>> getAllList() {

        List<Permission> list = permissionService.getAll();
        // 0级
        List<Permission> list0 = list.stream().filter(e -> (CommonConstant.LEVEL_ZERO).equals(e.getLevel()))
                .sorted(Comparator.comparing(Permission::getSortOrder)).collect(Collectors.toList());
        getAllByRecursion(list0, list);
        return new ResultUtil<List<Permission>>().setData(list0);
    }

    private void getAllByRecursion(List<Permission> curr, List<Permission> list) {

        curr.forEach(e -> {
            List<Permission> children = list.stream().filter(p -> (e.getId()).equals(p.getParentId()))
                    .sorted(Comparator.comparing(Permission::getSortOrder)).collect(Collectors.toList());
            e.setChildren(children);
            setInfo(e);
            if (e.getLevel() < 3) {
                getAllByRecursion(children, list);
            }
        });
    }

    @RequestMapping(value = "/getByParentId/{parentId}", method = RequestMethod.GET)
    @ApiOperation(value = "通过id获取")
    @Cacheable(key = "#parentId")
    public Result<List<Permission>> getByParentId(@PathVariable String parentId) {

        List<Permission> list = permissionService.findByParentIdOrderBySortOrder(parentId);
        list.forEach(e -> setInfo(e));
        return ResultUtil.data(list);
    }

    @RequestMapping(value = "/add", method = RequestMethod.POST)
    @ApiOperation(value = "添加")
    @CacheEvict(key = "'menuList'")
    public Result<Permission> add(Permission permission) {

        if (permission.getId().equals(permission.getParentId())) {
            return ResultUtil.error("上级节点不能为自己");
        }
        // 判断拦截请求的操作权限按钮名是否已存在
        if (CommonConstant.PERMISSION_OPERATION.equals(permission.getType())) {
            List<Permission> list = permissionService.findByTitle(permission.getTitle());
            if (list != null && list.size() > 0) {
                return new ResultUtil<Permission>().setErrorMsg("名称已存在");
            }
        }
        // 如果不是添加的一级 判断设置上级为父节点标识
        if (!CommonConstant.PARENT_ID.equals(permission.getParentId())) {
            Permission parent = permissionService.get(permission.getParentId());
            if (parent.getIsParent() == null || !parent.getIsParent()) {
                parent.setIsParent(true);
                permissionService.update(parent);
            }
        }
        Permission u = permissionService.save(permission);
        // 重新加载权限
        mySecurityMetadataSource.loadResourceDefine();
        // 手动删除缓存
        redisTemplate.deleteByPattern("permission:*");
        return new ResultUtil<Permission>().setData(u);
    }

    @RequestMapping(value = "/edit", method = RequestMethod.POST)
    @ApiOperation(value = "编辑")
    public Result<Permission> edit(Permission permission) {

        if (permission.getId().equals(permission.getParentId())) {
            return ResultUtil.error("上级节点不能为自己");
        }
        // 判断拦截请求的操作权限按钮名是否已存在
        if (CommonConstant.PERMISSION_OPERATION.equals(permission.getType())) {
            // 若名称修改
            Permission p = permissionService.get(permission.getId());
            if (!p.getTitle().equals(permission.getTitle())) {
                List<Permission> list = permissionService.findByTitle(permission.getTitle());
                if (list != null && list.size() > 0) {
                    return ResultUtil.error("名称已存在");
                }
            }
        }
        Permission old = permissionService.get(permission.getId());
        String oldParentId = old.getParentId();
        Permission u = permissionService.update(permission);
        // 如果该节点不是一级节点 且修改了级别 判断上级还有无子节点
        if (!CommonConstant.PARENT_ID.equals(oldParentId) && !oldParentId.equals(permission.getParentId())) {
            Permission parent = permissionService.get(oldParentId);
            List<Permission> children = permissionService.findByParentIdOrderBySortOrder(parent.getId());
            if (parent != null && (children == null || children.isEmpty())) {
                parent.setIsParent(false);
                permissionService.update(parent);
            }
        }
        // 重新加载权限
        mySecurityMetadataSource.loadResourceDefine();
        // 手动批量删除缓存
        redisTemplate.deleteByPattern("user:*");
        redisTemplate.deleteByPattern("permission:*");
        return ResultUtil.data(u);
    }

    @RequestMapping(value = "/delByIds", method = RequestMethod.POST)
    @ApiOperation(value = "批量通过id删除")
    @CacheEvict(key = "'menuList'")
    public Result<Object> delByIds(@RequestParam String[] ids) {

        for (String id : ids) {
            deleteRecursion(id, ids);
        }
        // 重新加载权限
        mySecurityMetadataSource.loadResourceDefine();
        // 手动删除缓存
        redisTemplate.deleteByPattern("permission:*");
        return ResultUtil.success("批量通过id删除数据成功");
    }

    public void deleteRecursion(String id, String[] ids) {

        List<RolePermission> list = rolePermissionService.findByPermissionId(id);
        if (list != null && list.size() > 0) {
            throw new XbootException("删除失败，包含正被用户使用关联的菜单");
        }
        // 获得其父节点
        Permission p = permissionService.get(id);
        Permission parent = null;
        if (p != null && StrUtil.isNotBlank(p.getParentId())) {
            parent = permissionService.get(p.getParentId());
        }
        permissionService.delete(id);
        // 判断父节点是否还有子节点
        if (parent != null) {
            List<Permission> children = permissionService.findByParentIdOrderBySortOrder(parent.getId());
            if (children == null || children.isEmpty()) {
                parent.setIsParent(false);
                permissionService.update(parent);
            }
        }
        // 递归删除
        List<Permission> permissions = permissionService.findByParentIdOrderBySortOrder(id);
        for (Permission pe : permissions) {
            if (!CommonUtil.judgeIds(pe.getId(), ids)) {
                deleteRecursion(pe.getId(), ids);
            }
        }
    }

    @RequestMapping(value = "/search", method = RequestMethod.GET)
    @ApiOperation(value = "搜索菜单")
    public Result<List<Permission>> searchPermissionList(@RequestParam String title) {

        List<Permission> list = permissionService.findByTitleLikeOrderBySortOrder("%" + title + "%");
        list.forEach(e -> setInfo(e));
        return new ResultUtil<List<Permission>>().setData(list);
    }

    public void setInfo(Permission permission) {

        if (!CommonConstant.PARENT_ID.equals(permission.getParentId())) {
            Permission parent = permissionService.get(permission.getParentId());
            permission.setParentTitle(parent.getTitle());
        } else {
            permission.setParentTitle("一级菜单");
        }
    }
}
