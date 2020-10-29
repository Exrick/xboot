package cn.exrick.xboot.modules.base.dao;

import cn.exrick.xboot.base.XbootBaseDao;
import cn.exrick.xboot.modules.base.entity.Role;

import java.util.List;

/**
 * 角色数据处理层
 * @author Exrickx
 */
public interface RoleDao extends XbootBaseDao<Role, String> {

    /**
     * 获取默认角色
     * @param defaultRole
     * @return
     */
    List<Role> findByDefaultRole(Boolean defaultRole);
}
