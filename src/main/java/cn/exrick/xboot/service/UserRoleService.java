package cn.exrick.xboot.service;


import cn.exrick.xboot.base.XbootBaseService;
import cn.exrick.xboot.dao.RoleDao;
import cn.exrick.xboot.entity.Role;
import cn.exrick.xboot.entity.UserRole;
import org.springframework.cache.annotation.CacheConfig;
import org.springframework.cache.annotation.Cacheable;

import java.util.List;

/**
 * 用户角色接口
 * @author Exrickx
 */
//@CacheConfig(cacheNames = "userRole")
public interface UserRoleService extends XbootBaseService<UserRole,String> {

    /**
     * 通过用户id获取
     * @param userId
     * @return
     */
//    @Cacheable(key = "#userId")
    List<String> findByUserId(String userId);
}
