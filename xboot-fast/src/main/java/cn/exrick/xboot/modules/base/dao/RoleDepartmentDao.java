package cn.exrick.xboot.modules.base.dao;

import cn.exrick.xboot.base.XbootBaseDao;
import cn.exrick.xboot.modules.base.entity.RoleDepartment;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

/**
 * 角色部门数据处理层
 * @author Exrick
 */
public interface RoleDepartmentDao extends XbootBaseDao<RoleDepartment, String> {

    /**
     * 通过roleId获取
     * @param roleId
     * @return
     */
    List<RoleDepartment> findByRoleId(String roleId);

    /**
     * 通过角色id删除
     * @param roleId
     */
    @Modifying
    @Query("delete from RoleDepartment r where r.roleId = ?1")
    void deleteByRoleId(String roleId);

    /**
     * 通过角色id删除
     * @param departmentId
     */
    @Modifying
    @Query("delete from RoleDepartment r where r.departmentId = ?1")
    void deleteByDepartmentId(String departmentId);
}