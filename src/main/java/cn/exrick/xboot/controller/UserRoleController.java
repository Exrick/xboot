package cn.exrick.xboot.controller;

import cn.exrick.xboot.base.XbootBaseController;
import cn.exrick.xboot.common.utils.ResultUtil;
import cn.exrick.xboot.common.vo.Result;
import cn.exrick.xboot.dao.UserRoleDao;
import cn.exrick.xboot.entity.Role;
import cn.exrick.xboot.entity.UserRole;
import cn.exrick.xboot.service.RoleService;
import cn.exrick.xboot.service.UserRoleService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;


/**
 * 拥有ROLE_ADMIN角色的用户可以访问
 * @author Exrickx
 */
@Slf4j
@RestController
@Api(description = "角色管理接口")
@RequestMapping("/userRole")
@PreAuthorize("hasRole('ADMIN')")
public class UserRoleController extends XbootBaseController<UserRole, String> {

    @Autowired
    private UserRoleService userRoleService;

    @Autowired
    private UserRoleDao userRoleDao;

    @Override
    public UserRoleService getService() {
        return userRoleService;
    }

}
