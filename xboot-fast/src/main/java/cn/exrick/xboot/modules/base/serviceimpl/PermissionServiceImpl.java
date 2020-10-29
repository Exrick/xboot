package cn.exrick.xboot.modules.base.serviceimpl;

import cn.exrick.xboot.modules.base.dao.PermissionDao;
import cn.exrick.xboot.modules.base.entity.Permission;
import cn.exrick.xboot.modules.base.service.PermissionService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * 权限接口实现
 * @author Exrick
 */
@Slf4j
@Service
@Transactional
public class PermissionServiceImpl implements PermissionService {

    @Autowired
    private PermissionDao permissionDao;

    @Override
    public PermissionDao getRepository() {
        return permissionDao;
    }

    @Override
    public List<Permission> findByParentIdOrderBySortOrder(String parentId) {

        return permissionDao.findByParentIdOrderBySortOrder(parentId);
    }

    @Override
    public List<Permission> findByTypeAndStatusOrderBySortOrder(Integer type, Integer status) {

        return permissionDao.findByTypeAndStatusOrderBySortOrder(type, status);
    }

    @Override
    public List<Permission> findByTitle(String title) {

        return permissionDao.findByTitle(title);
    }

    @Override
    public List<Permission> findByTitleLikeOrderBySortOrder(String title) {

        return permissionDao.findByTitleLikeOrderBySortOrder(title);
    }
}