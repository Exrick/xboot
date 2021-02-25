package cn.exrick.xboot.modules.base.service;

import cn.exrick.xboot.base.XbootBaseService;
import cn.exrick.xboot.modules.base.entity.DepartmentHeader;
import cn.exrick.xboot.modules.base.vo.UserVo;

import java.util.List;

/**
 * 部门负责人接口
 * @author Exrick
 */
public interface DepartmentHeaderService extends XbootBaseService<DepartmentHeader, String> {

    /**
     * 通过部门和负责人类型获取
     * @param departmentId
     * @param type
     * @return
     */
    List<UserVo> findHeaderByDepartmentId(String departmentId, Integer type);

    /**
     * 通过部门获取
     * @param departmentIds
     * @return
     */
    List<DepartmentHeader> findByDepartmentIdIn(List<String> departmentIds);

    /**
     * 通过部门id删除
     * @param departmentId
     */
    void deleteByDepartmentId(String departmentId);

    /**
     * 通过userId删除
     * @param userId
     */
    void deleteByUserId(String userId);

    /**
     * 是否为部门负责人
     * @param userId
     * @param departmentId
     * @return
     */
    Boolean isDepartmentHeader(String userId, String departmentId);
}