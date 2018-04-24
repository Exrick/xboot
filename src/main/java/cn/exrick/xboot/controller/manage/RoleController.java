package cn.exrick.xboot.controller.manage;

import cn.exrick.xboot.base.XbootBaseController;
import cn.exrick.xboot.entity.Role;
import cn.exrick.xboot.service.RoleService;
import io.swagger.annotations.Api;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
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
