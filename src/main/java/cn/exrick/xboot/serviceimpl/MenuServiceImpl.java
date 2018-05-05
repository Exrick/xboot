package cn.exrick.xboot.serviceimpl;

import cn.exrick.xboot.dao.MenuDao;
import cn.exrick.xboot.entity.Menu;
import cn.exrick.xboot.service.MenuService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * 菜单接口实现
 * @author Exrickx
 */
@Slf4j
@Service
@Transactional
public class MenuServiceImpl implements MenuService {

    @Autowired
    private MenuDao menuDao;

    @Override
    public MenuDao getRepository() {
        return menuDao;
    }

    @Override
    public List<Menu> findByParent(Boolean parent) {

        return menuDao.findByParent(parent);
    }

    @Override
    public List<Menu> findByParentId(String parentId) {

        return menuDao.findByParentId(parentId);
    }
}
