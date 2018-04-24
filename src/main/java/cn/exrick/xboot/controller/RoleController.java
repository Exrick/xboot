package cn.exrick.xboot.controller;

import cn.exrick.xboot.base.XbootBaseController;
import cn.exrick.xboot.common.constant.CommonConstant;
import cn.exrick.xboot.common.utils.JasyptUtil;
import cn.exrick.xboot.common.utils.ResultUtil;
import cn.exrick.xboot.common.vo.Result;
import cn.exrick.xboot.entity.Role;
import cn.exrick.xboot.entity.User;
import cn.exrick.xboot.service.RoleService;
import cn.exrick.xboot.service.UserService;
import cn.hutool.core.util.StrUtil;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheConfig;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;


/**
 * 拥有ROLE_ADMIN角色的用户可以访问
 * @author Exrickx
 */
@Slf4j
@RestController
@Api(description = "角色管理接口")
@RequestMapping("/role")
@PreAuthorize("hasRole('ADMIN')")
public class RoleController extends XbootBaseController<Role, String> {

    @Autowired
    private RoleService roleService;

    @Override
    public RoleService getService() {
        return roleService;
    }

}
