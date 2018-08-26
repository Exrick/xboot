package cn.exrick.xboot.dao;

import cn.exrick.xboot.base.XbootBaseDao;
import cn.exrick.xboot.entity.Department;

import java.util.List;

/**
 * 部门数据处理层
 * @author Exrick
 */
public interface DepartmentDao extends XbootBaseDao<Department,String> {

    /**
     * 通过父id获取 升序
     * @param parentId
     * @return
     */
    List<Department> findByParentIdOrderBySortOrder(String parentId);

    /**
     * 通过父id和状态获取 升序
     * @param parentId
     * @param status
     * @return
     */
    List<Department> findByParentIdAndStatusOrderBySortOrder(String parentId, Integer status);
}