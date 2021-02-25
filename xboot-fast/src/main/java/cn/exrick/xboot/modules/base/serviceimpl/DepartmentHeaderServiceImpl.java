package cn.exrick.xboot.modules.base.serviceimpl;

import cn.exrick.xboot.modules.base.dao.DepartmentHeaderDao;
import cn.exrick.xboot.modules.base.dao.UserDao;
import cn.exrick.xboot.modules.base.entity.DepartmentHeader;
import cn.exrick.xboot.modules.base.entity.User;
import cn.exrick.xboot.modules.base.service.DepartmentHeaderService;
import cn.exrick.xboot.modules.base.vo.UserVo;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

/**
 * 部门负责人接口实现
 * @author Exrick
 */
@Slf4j
@Service
@Transactional
public class DepartmentHeaderServiceImpl implements DepartmentHeaderService {

    @Autowired
    private DepartmentHeaderDao departmentHeaderDao;

    @Autowired
    private UserDao userDao;

    @Override
    public DepartmentHeaderDao getRepository() {
        return departmentHeaderDao;
    }


    @Override
    public List<UserVo> findHeaderByDepartmentId(String departmentId, Integer type) {

        List<UserVo> list = new ArrayList<>();
        List<DepartmentHeader> headers = departmentHeaderDao.findByDepartmentIdAndType(departmentId, type);
        headers.forEach(e -> {
            User u = userDao.getOne(e.getUserId());
            if (u != null) {
                list.add(new UserVo().setId(u.getId()).setUsername(u.getUsername()).setNickname(u.getNickname()));
            }
        });
        return list;
    }

    @Override
    public List<DepartmentHeader> findByDepartmentIdIn(List<String> departmentIds) {

        return departmentHeaderDao.findByDepartmentIdIn(departmentIds);
    }

    @Override
    public void deleteByDepartmentId(String departmentId) {

        departmentHeaderDao.deleteByDepartmentId(departmentId);
    }

    @Override
    public void deleteByUserId(String userId) {

        departmentHeaderDao.deleteByUserId(userId);
    }

    @Override
    public Boolean isDepartmentHeader(String userId, String departmentId) {

        List<DepartmentHeader> headers = departmentHeaderDao.findByUserIdAndDepartmentId(userId, departmentId);
        if (headers != null && !headers.isEmpty()) {
            return true;
        }
        return false;
    }
}