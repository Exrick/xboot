package cn.exrick.xboot.modules.base.dao;

import cn.exrick.xboot.base.XbootBaseDao;
import cn.exrick.xboot.modules.base.entity.UserRole;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

/**
 * 用户角色数据处理层
 * @author Exrickx
 */
public interface UserRoleDao extends XbootBaseDao<UserRole, String> {

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
    @Modifying
    @Query("delete from UserRole u where u.userId = ?1")
    void deleteByUserId(String userId);
}
