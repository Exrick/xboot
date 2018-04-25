package cn.exrick.xboot.serviceimpl.mybatis;

import cn.exrick.xboot.dao.mapper.UserMapper;
import cn.exrick.xboot.entity.User;
import cn.exrick.xboot.service.mybatis.IUserService;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

/**
 * @author Exrickx
 */
@Service
public class IUserServiceImpl extends ServiceImpl<UserMapper, User> implements IUserService {

}
