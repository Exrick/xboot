package cn.exrick.xboot.controller.manage;

import cn.exrick.xboot.base.XbootBaseController;
import cn.exrick.xboot.common.utils.ResultUtil;
import cn.exrick.xboot.common.vo.Result;
import cn.exrick.xboot.entity.Menu;
import cn.exrick.xboot.entity.Role;
import cn.exrick.xboot.entity.UserRole;
import cn.exrick.xboot.service.MenuService;
import cn.exrick.xboot.service.RoleService;
import cn.exrick.xboot.service.UserRoleService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheConfig;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Set;


/**
 * 拥有ROLE_ADMIN角色的用户可以访问
 * @author Exrickx
 */
@Slf4j
@RestController
@Api(description = "菜单管理接口")
@RequestMapping("/menu")
@CacheConfig(cacheNames = "menu")
public class MenuController{

    @Autowired
    private MenuService menuService;

    @RequestMapping(value = "/getAllList",method = RequestMethod.GET)
    @ApiOperation(value = "获取数据")
    @Cacheable(key = "'list'")
    public Result<List<Menu>> getAllList(){

        List<Menu> list = menuService.findByParent(true);
        for(Menu menu : list){
            List<Menu> children = menuService.findByParentId(menu.getId());
            menu.setChildren(children);
        }
        return new ResultUtil<List<Menu>>().setData(list);
    }

    @PreAuthorize("hasRole('ADMIN')")
    @RequestMapping(value = "/add",method = RequestMethod.POST)
    @ApiOperation(value = "添加")
    @CacheEvict(key = "'list'")
    public Result<Menu> add(@ModelAttribute Menu menu){

        Menu u = menuService.save(menu);
        return new ResultUtil<Menu>().setData(u);
    }

    @PreAuthorize("hasRole('ADMIN')")
    @RequestMapping(value = "/edit",method = RequestMethod.POST)
    @ApiOperation(value = "编辑")
    @CacheEvict(key = "'list'")
    public Result<Menu> edit(@ModelAttribute Menu menu){

        Menu u = menuService.update(menu);
        return new ResultUtil<Menu>().setData(u);
    }

    @PreAuthorize("hasRole('ADMIN')")
    @RequestMapping(value = "/delByIds",method = RequestMethod.DELETE)
    @ApiOperation(value = "批量通过id删除")
    @CacheEvict(key = "'list'")
    public Result<Object> delByIds(@RequestParam String[] ids){

        for(String id:ids){
            menuService.delete(id);
        }
        return new ResultUtil<Object>().setSuccessMsg("批量通过id删除数据成功");
    }
}
