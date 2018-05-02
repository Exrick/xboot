package cn.exrick.xboot.serviceimpl;

import cn.exrick.xboot.dao.RoleDao;
import cn.exrick.xboot.dao.UserRoleDao;
import cn.exrick.xboot.entity.UserRole;
import cn.exrick.xboot.service.UserRoleService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 用户角色接口实现
 * @author Exrickx
 */
@Slf4j
@Service
public class UserRoleServiceImpl implements UserRoleService {

    @Autowired
    private UserRoleDao userRoleDao;

    @Override
    public UserRoleDao getRepository() {
        return userRoleDao;
    }
}
