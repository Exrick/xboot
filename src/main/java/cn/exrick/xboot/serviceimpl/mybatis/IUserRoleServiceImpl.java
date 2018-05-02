package cn.exrick.xboot.serviceimpl.mybatis;

import cn.exrick.xboot.dao.mapper.UserRoleMapper;
import cn.exrick.xboot.entity.Role;
import cn.exrick.xboot.entity.UserRole;
import cn.exrick.xboot.service.mybatis.IUserRoleService;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author Exrickx
 */
@Service
public class IUserRoleServiceImpl extends ServiceImpl<UserRoleMapper, UserRole> implements IUserRoleService {

    @Autowired
    private UserRoleMapper userRoleMapper;

    @Override
    public List<Role> findByUserId(String userId) {

        return userRoleMapper.findByUserId(userId);
    }
}
