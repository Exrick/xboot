package cn.exrick.xboot.dao;

import cn.exrick.xboot.base.XbootBaseDao;
import cn.exrick.xboot.entity.Role;
import cn.exrick.xboot.entity.UserRole;
import org.hibernate.query.NativeQuery;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

/**
 * 用户角色数据处理层
 * @author Exrickx
 */
public interface UserRoleDao extends XbootBaseDao<UserRole,String> {

    /**
     * 通过用户id获取
     * @param userId
     * @return
     */
    @Query(value = "select name roleName from t_user_role ur LEFT JOIN t_role r ON ur.role_id = r.id WHERE user_Id = :userId", nativeQuery = true)
    List<String> findByUserId(@Param("userId") String userId);
}
