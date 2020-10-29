package cn.exrick.xboot.core.serviceimpl;

import cn.exrick.xboot.core.dao.UserDao;
import cn.exrick.xboot.core.dao.UserRoleDao;
import cn.exrick.xboot.core.entity.UserRole;
import cn.exrick.xboot.core.service.UserRoleService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * 用户角色接口实现
 * @author Exrickx
 */
@Slf4j
@Service
@Transactional
public class UserRoleServiceImpl implements UserRoleService {

    @Autowired
    private UserRoleDao userRoleDao;

    @Autowired
    private UserDao userDao;

    @Override
    public UserRoleDao getRepository() {
        return userRoleDao;
    }

    @Override
    public List<UserRole> findByRoleId(String roleId) {
        return userRoleDao.findByRoleId(roleId);
    }

    @Override
    public void deleteByUserId(String userId) {
        userRoleDao.deleteByUserId(userId);
    }
}
