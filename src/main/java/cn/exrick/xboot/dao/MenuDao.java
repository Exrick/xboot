package cn.exrick.xboot.dao;

import cn.exrick.xboot.base.XbootBaseDao;
import cn.exrick.xboot.entity.Menu;

import java.util.List;

/**
 * 菜单数据处理层
 * @author Exrickx
 */
public interface MenuDao extends XbootBaseDao<Menu,String> {

    /**
     * 获取一级菜单
     * @param parent
     * @return
     */
    List<Menu> findByParent(Boolean parent);

    /**
     * 通过parendId查找
     * @param parentId
     * @return
     */
    List<Menu> findByParentId(String parentId);
}
