package cn.exrick.xboot.serviceimpl;

import cn.exrick.xboot.common.constant.CommonConstant;
import cn.exrick.xboot.dao.UserDao;
import cn.exrick.xboot.dao.UserRoleDao;
import cn.exrick.xboot.entity.User;
import cn.exrick.xboot.entity.UserRole;
import cn.exrick.xboot.service.RoleService;
import cn.exrick.xboot.service.UserService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 用户接口实现
 * @author Exrickx
 */
@Slf4j
@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserDao userDao;

    @Autowired
    private UserRoleDao userRoleDao;

    @Override
    public UserDao getRepository() {
        return userDao;
    }

    @Override
    public User findByUsername(String username) {
        
        List<User> list=userDao.findByUsernameAndStatus(username, CommonConstant.USER_STATUS_NORMAL);
        if(list!=null&&list.size()>0){
            User user = list.get(0);
            List<String> userNameList = userRoleDao.findByUserId(user.getId());
            user.setRoleNames(userNameList);
            return user;
        }
        return null;
    }

    @Override
    public List<User> findByStatusAndType(Integer status, Integer type) {
        return userDao.findByStatusAndType(status, type);
    }
}
