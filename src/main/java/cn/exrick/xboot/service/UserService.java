package cn.exrick.xboot.service;


import cn.exrick.xboot.base.XbootBaseService;
import cn.exrick.xboot.entity.User;
import org.springframework.cache.annotation.CacheConfig;
import org.springframework.cache.annotation.Cacheable;

import java.util.List;

/**
 * 用户接口
 * @author Exrickx
 */
@CacheConfig(cacheNames = "user")
public interface UserService extends XbootBaseService<User,String> {

    /**
     * 通过用户名获取用户
     * @param username
     * @return
     */
    @Cacheable(key = "#username")
    User findByUsername(String username);

    /**
     * 通过状态和类型获取用户
     * @param status
     * @param type
     * @return
     */
    List<User> findByStatusAndType(Integer status, Integer type);
}
