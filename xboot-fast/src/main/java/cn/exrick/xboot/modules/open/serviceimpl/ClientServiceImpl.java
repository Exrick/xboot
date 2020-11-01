package cn.exrick.xboot.modules.open.serviceimpl;

import cn.exrick.xboot.common.redis.RedisTemplateHelper;
import cn.exrick.xboot.common.vo.SearchVo;
import cn.exrick.xboot.modules.open.dao.ClientDao;
import cn.exrick.xboot.modules.open.entity.Client;
import cn.exrick.xboot.modules.open.service.ClientService;
import cn.hutool.core.date.DateUtil;
import cn.hutool.core.util.StrUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheConfig;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
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
import java.util.concurrent.TimeUnit;

/**
 * 客户端接口实现
 * @author Exrick
 */
@Slf4j
@Service
@Transactional
@CacheConfig(cacheNames = "client")
public class ClientServiceImpl implements ClientService {

    @Autowired
    private ClientDao clientDao;

    @Autowired
    private RedisTemplateHelper redisTemplate;

    @Override
    public ClientDao getRepository() {
        return clientDao;
    }

    @Override
    @Cacheable(key = "#id")
    public Client get(String id) {

        // 避免缓存穿透
        String result = redisTemplate.get("client::" + id);
        if ("null".equals(result)) {
            return null;
        }
        Client client = clientDao.findById(id).orElse(null);
        if (client == null) {
            redisTemplate.set("client::" + id, "null", 5L, TimeUnit.MINUTES);
        }
        return client;
    }

    @Override
    @CacheEvict(key = "#client.id")
    public Client update(Client client) {

        return clientDao.saveAndFlush(client);
    }

    @Override
    @CacheEvict(key = "#id")
    public void delete(String id) {

        clientDao.deleteById(id);
    }

    @Override
    public Page<Client> findByCondition(Client client, SearchVo searchVo, Pageable pageable) {

        return clientDao.findAll(new Specification<Client>() {
            @Nullable
            @Override
            public Predicate toPredicate(Root<Client> root, CriteriaQuery<?> cq, CriteriaBuilder cb) {

                Path<String> nameField = root.get("name");
                Path<String> homeUriField = root.get("homeUri");
                Path<Date> createTimeField = root.get("createTime");

                List<Predicate> list = new ArrayList<>();

                //模糊搜素
                if (StrUtil.isNotBlank(client.getName())) {
                    list.add(cb.like(nameField, '%' + client.getName() + '%'));
                }
                if (StrUtil.isNotBlank(client.getHomeUri())) {
                    list.add(cb.like(homeUriField, '%' + client.getHomeUri() + '%'));
                }

                //创建时间
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

}