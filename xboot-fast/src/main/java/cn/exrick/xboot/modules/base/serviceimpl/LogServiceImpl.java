package cn.exrick.xboot.modules.base.serviceimpl;

import cn.exrick.xboot.common.vo.SearchVo;
import cn.exrick.xboot.modules.base.dao.LogDao;
import cn.exrick.xboot.modules.base.entity.Log;
import cn.exrick.xboot.modules.base.service.LogService;
import cn.hutool.core.date.DateUtil;
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
import java.util.Date;
import java.util.List;

/**
 * 日志接口实现
 * @author Exrickx
 */
@Slf4j
@Service
@Transactional
public class LogServiceImpl implements LogService {

    @Autowired
    private LogDao logDao;

    @Override
    public LogDao getRepository() {
        return logDao;
    }

    @Override
    public Page<Log> findByConfition(Integer type, String key, SearchVo searchVo, Pageable pageable) {

        return logDao.findAll(new Specification<Log>() {
            @Nullable
            @Override
            public Predicate toPredicate(Root<Log> root, CriteriaQuery<?> cq, CriteriaBuilder cb) {

                Path<String> nameField = root.get("name");
                Path<String> requestUrlField = root.get("requestUrl");
                Path<String> requestTypeField = root.get("requestType");
                Path<String> requestParamField = root.get("requestParam");
                Path<String> usernameField = root.get("username");
                Path<String> ipField = root.get("ip");
                Path<String> ipInfoField = root.get("ipInfo");
                Path<String> deviceField = root.get("device");
                Path<Integer> logTypeField = root.get("logType");
                Path<Date> createTimeField = root.get("createTime");

                List<Predicate> list = new ArrayList<>();

                // 类型
                if (type != null) {
                    list.add(cb.equal(logTypeField, type));
                }

                // 模糊搜素
                if (StrUtil.isNotBlank(key)) {
                    Predicate p1 = cb.like(requestUrlField, '%' + key + '%');
                    Predicate p2 = cb.like(requestTypeField, '%' + key + '%');
                    Predicate p3 = cb.like(requestParamField, '%' + key + '%');
                    Predicate p4 = cb.like(usernameField, '%' + key + '%');
                    Predicate p5 = cb.like(ipField, '%' + key + '%');
                    Predicate p6 = cb.like(ipInfoField, '%' + key + '%');
                    Predicate p7 = cb.like(nameField, '%' + key + '%');
                    Predicate p8 = cb.like(deviceField, '%' + key + '%');
                    list.add(cb.or(p1, p2, p3, p4, p5, p6, p7, p8));
                }

                // 创建时间
                if (StrUtil.isNotBlank(searchVo.getStartDate()) && StrUtil.isNotBlank(searchVo.getEndDate())) {
                    Date start = DateUtil.parse(searchVo.getStartDate());
                    Date end = DateUtil.parse(searchVo.getEndDate());
                    list.add(cb.between(createTimeField, start, DateUtil.endOfDay(end)));
                }

                Predicate[] arr = new Predicate[list.size()];
                cq.where(list.toArray(arr));
                return null;
            }
        }, pageable);
    }

    @Override
    public void deleteAll() {

        logDao.deleteAll();
    }
}
