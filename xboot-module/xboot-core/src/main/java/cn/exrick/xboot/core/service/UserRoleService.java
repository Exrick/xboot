package cn.exrick.xboot.core.service;


import cn.exrick.xboot.core.base.XbootBaseService;
import cn.exrick.xboot.core.entity.UserRole;

import java.util.List;

/**
 * 用户角色接口
 * @author Exrickx
 */
public interface UserRoleService extends XbootBaseService<UserRole, String> {

    /**
     * 通过roleId查找
     * @param roleId
     * @return
     */
    List<UserRole> findByRoleId(String roleId);

    /**
     * 删除用户角色
     * @param userId
     */
    void deleteByUserId(String userId);
}
