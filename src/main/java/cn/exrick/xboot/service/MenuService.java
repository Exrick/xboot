package cn.exrick.xboot.service;


import cn.exrick.xboot.base.XbootBaseService;
import cn.exrick.xboot.entity.Menu;

import java.util.List;

/**
 * 菜单接口
 * @author Exrickx
 */
public interface MenuService extends XbootBaseService<Menu,String> {

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
