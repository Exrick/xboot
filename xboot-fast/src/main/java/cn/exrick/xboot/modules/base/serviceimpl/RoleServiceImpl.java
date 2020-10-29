package cn.exrick.xboot.modules.base.serviceimpl;

import cn.exrick.xboot.modules.base.dao.RoleDao;
import cn.exrick.xboot.modules.base.entity.Role;
import cn.exrick.xboot.modules.base.service.RoleService;
import cn.hutool.core.util.StrUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.lang.Nullable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.criteria.*;
import java.util.ArrayList;
import java.util.List;

/**
 * 角色接口实现
 * @author Exrickx
 */
@Slf4j
@Service
@Transactional
public class RoleServiceImpl implements RoleService {

    @Autowired
    private RoleDao roleDao;

    @Override
    public RoleDao getRepository() {
        return roleDao;
    }

    @Override
    public List<Role> findByDefaultRole(Boolean defaultRole) {
        return roleDao.findByDefaultRole(defaultRole);
    }

    @Override
    public Page<Role> findByCondition(String key, Pageable pageable) {

        return roleDao.findAll(new Specification<Role>() {
            @Nullable
            @Override
            public Predicate toPredicate(Root<Role> root, CriteriaQuery<?> cq, CriteriaBuilder cb) {

                Path<String> nameField = root.get("name");
                Path<String> descriptionField = root.get("description");

                List<Predicate> list = new ArrayList<>();

                // 模糊搜素
                if (StrUtil.isNotBlank(key)) {
                    Predicate p1 = cb.like(nameField, '%' + key + '%');
                    Predicate p2 = cb.like(descriptionField, '%' + key + '%');
                    list.add(cb.or(p1, p2));
                }

                Predicate[] arr = new Predicate[list.size()];
                cq.where(list.toArray(arr));
                return null;
            }
        }, pageable);
    }
}
