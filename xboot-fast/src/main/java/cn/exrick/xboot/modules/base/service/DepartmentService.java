package cn.exrick.xboot.modules.base.service;

import cn.exrick.xboot.base.XbootBaseService;
import cn.exrick.xboot.modules.base.entity.Department;

import java.util.List;

/**
 * 部门接口
 * @author Exrick
 */
public interface DepartmentService extends XbootBaseService<Department, String> {

    /**
     * 通过父id获取 升序
     * @param parentId
     * @param openDataFilter 是否开启数据权限
     * @return
     */
    List<Department> findByParentIdOrderBySortOrder(String parentId, Boolean openDataFilter);

    /**
     * 通过父id和状态获取
     * @param parentId
     * @param status
     * @return
     */
    List<Department> findByParentIdAndStatusOrderBySortOrder(String parentId, Integer status);

    /**
     * 部门名模糊搜索 升序
     * @param title
     * @param openDataFilter 是否开启数据权限
     * @return
     */
    List<Department> findByTitleLikeOrderBySortOrder(String title, Boolean openDataFilter);
}