package cn.exrick.xboot.dao;

import cn.exrick.xboot.base.XbootBaseDao;
import cn.exrick.xboot.entity.User;
import io.swagger.models.auth.In;

import java.util.List;

/**
 * 用户数据处理层
 * @author Exrickx
 */
public interface UserDao extends XbootBaseDao<User,String> {

    /**
     * 通过用户名和状态获取用户
     * @param username
     * @param status
     * @return
     */
    List<User> findByUsernameAndStatus(String username, Integer status);

    /**
     * 通过状态和类型获取用户
     * @param status
     * @param type
     * @return
     */
    List<User> findByStatusAndType(Integer status, Integer type);

    /**
     * 通过部门id获取
     * @param departmentId
     * @return
     */
    List<User> findByDepartmentId(String departmentId);
}
