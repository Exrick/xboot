package cn.exrick.xboot.base.controller.manage;

import cn.exrick.xboot.core.common.constant.CommonConstant;
import cn.exrick.xboot.core.common.redis.RedisTemplateHelper;
import cn.exrick.xboot.core.common.utils.PageUtil;
import cn.exrick.xboot.core.common.utils.ResultUtil;
import cn.exrick.xboot.core.common.vo.PageVo;
import cn.exrick.xboot.core.common.vo.Result;
import cn.exrick.xboot.core.service.RoleDepartmentService;
import cn.exrick.xboot.core.service.RolePermissionService;
import cn.exrick.xboot.core.service.RoleService;
import cn.exrick.xboot.core.service.UserRoleService;
import cn.exrick.xboot.core.entity.Role;
import cn.exrick.xboot.core.entity.RoleDepartment;
import cn.exrick.xboot.core.entity.RolePermission;
import cn.exrick.xboot.core.entity.UserRole;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import java.util.Arrays;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;


/**
 * @author Exrickx
 */
@Slf4j
@RestController
@Api(description = "角色管理接口")
@RequestMapping("/xboot/role")
@Transactional
public class RoleController {

    @Autowired
    private RoleService roleService;

    @Autowired
    private UserRoleService userRoleService;

    @Autowired
    private RolePermissionService rolePermissionService;

    @Autowired
    private RoleDepartmentService roleDepartmentService;

    @Autowired
    private StringRedisTemplate redisTemplate;

    @Autowired
    private RedisTemplateHelper redisTemplateHelper;

    @RequestMapping(value = "/getAllList", method = RequestMethod.GET)
    @ApiOperation(value = "获取全部角色")
    public Result<Object> roleGetAll(){

        List<Role> list = roleService.getAll();
        return ResultUtil.data(list);
    }

    @RequestMapping(value = "/getAllByPage", method = RequestMethod.GET)
    @ApiOperation(value = "分页获取角色")
    public Result<Page<Role>> getRoleByPage(PageVo page){

        Page<Role> list = roleService.findAll(PageUtil.initPage(page));
        for(Role role : list.getContent()){
            // 角色拥有权限
            List<RolePermission> permissions = rolePermissionService.findByRoleId(role.getId());
            role.setPermissions(permissions);
            // 角色拥有数据权限
            List<RoleDepartment> departments = roleDepartmentService.findByRoleId(role.getId());
            role.setDepartments(departments);
        }
        return new ResultUtil<Page<Role>>().setData(list);
    }

    @RequestMapping(value = "/setDefault", method = RequestMethod.POST)
    @ApiOperation(value = "设置或取消默认角色")
    public Result<Object> setDefault(@RequestParam String id,
                                     @RequestParam Boolean isDefault){

        Role role = roleService.get(id);
        if(role==null){
            return ResultUtil.error("角色不存在");
        }
        role.setDefaultRole(isDefault);
        roleService.update(role);
        return ResultUtil.success("设置成功");
    }

    @RequestMapping(value = "/editRolePerm", method = RequestMethod.POST)
    @ApiOperation(value = "编辑角色分配菜单权限")
    public Result<Object> editRolePerm(@RequestParam String roleId,
                                       @RequestParam(required = false) String[] permIds){

        // 删除其关联权限
        rolePermissionService.deleteByRoleId(roleId);
        // 批量分配新权限
        if(permIds!=null){
            List<RolePermission> list = Arrays.asList(permIds).stream().map(e -> {
                return new RolePermission().setRoleId(roleId).setPermissionId(e);
            }).collect(Collectors.toList());
            rolePermissionService.saveOrUpdateAll(list);
        }
        // 手动批量删除缓存
        Set<String> keysUser = redisTemplateHelper.keys("user:" + "*");
        redisTemplate.delete(keysUser);
        Set<String> keysUserRole = redisTemplateHelper.keys("userRole:" + "*");
        redisTemplate.delete(keysUserRole);
        Set<String> keysUserMenu = redisTemplateHelper.keys("permission::userMenuList:*");
        redisTemplate.delete(keysUserMenu);
        return ResultUtil.data(null);
    }

    @RequestMapping(value = "/editRoleDep", method = RequestMethod.POST)
    @ApiOperation(value = "编辑角色分配数据权限")
    public Result<Object> editRoleDep(@RequestParam String roleId,
                                      @RequestParam Integer dataType,
                                      @RequestParam(required = false) String[] depIds){

        Role r = roleService.get(roleId);
        r.setDataType(dataType);
        roleService.update(r);
        if(CommonConstant.DATA_TYPE_CUSTOM.equals(dataType)){
            // 删除其关联数据权限
            roleDepartmentService.deleteByRoleId(roleId);
            // 批量分配新数据权限
            if(depIds!=null){
                List<RoleDepartment> list = Arrays.asList(depIds).stream().map(e -> {
                    return new RoleDepartment().setRoleId(roleId).setDepartmentId(e);
                }).collect(Collectors.toList());
                roleDepartmentService.saveOrUpdateAll(list);
            }
        }
        // 手动删除相关缓存
        Set<String> keys = redisTemplateHelper.keys("department:" + "*");
        redisTemplate.delete(keys);
        Set<String> keysUserRole = redisTemplateHelper.keys("userRole:" + "*");
        redisTemplate.delete(keysUserRole);

        return ResultUtil.data(null);
    }

    @RequestMapping(value = "/save", method = RequestMethod.POST)
    @ApiOperation(value = "保存数据")
    public Result<Role> save(Role role){

        Role r = roleService.save(role);
        return new ResultUtil<Role>().setData(r);
    }

    @RequestMapping(value = "/edit", method = RequestMethod.POST)
    @ApiOperation(value = "更新数据")
    public Result<Role> edit(Role entity){

        Role r = roleService.update(entity);
        //手动批量删除缓存
        Set<String> keysUser = redisTemplateHelper.keys("user:" + "*");
        redisTemplate.delete(keysUser);
        Set<String> keysUserRole = redisTemplateHelper.keys("userRole:" + "*");
        redisTemplate.delete(keysUserRole);
        return new ResultUtil<Role>().setData(r);
    }

    @RequestMapping(value = "/delByIds", method = RequestMethod.POST)
    @ApiOperation(value = "批量通过ids删除")
    public Result<Object> delByIds(@RequestParam String[] ids){

        for(String id:ids){
            List<UserRole> list = userRoleService.findByRoleId(id);
            if(list!=null&&list.size()>0){
                return ResultUtil.error("删除失败，包含正被用户使用关联的角色");
            }
        }
        for(String id:ids){
            roleService.delete(id);
            //删除关联菜单权限
            rolePermissionService.deleteByRoleId(id);
            //删除关联数据权限
            roleDepartmentService.deleteByRoleId(id);
        }
        return ResultUtil.success("批量通过id删除数据成功");
    }
}
