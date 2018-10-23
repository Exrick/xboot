package cn.exrick.xboot.common.utils;

import cn.exrick.xboot.modules.base.entity.User;
import cn.exrick.xboot.modules.base.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Component;

/**
 * @author Exrickx
 */
@Component
public class SecurityUtil {

    @Autowired
    private UserService userService;

    /**
     * 获取当前登录用户
     * @return
     */
    public User getCurrUser(){

        UserDetails user = (UserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        return userService.findByUsername(user.getUsername());
    }
}
