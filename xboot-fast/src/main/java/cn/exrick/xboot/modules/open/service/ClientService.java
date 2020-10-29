package cn.exrick.xboot.modules.open.service;

import cn.exrick.xboot.base.XbootBaseService;
import cn.exrick.xboot.common.vo.SearchVo;
import cn.exrick.xboot.modules.open.entity.Client;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

/**
 * 客户端接口
 * @author Exrick
 */
public interface ClientService extends XbootBaseService<Client, String> {

    /**
     * 多条件分页获取
     * @param client
     * @param searchVo
     * @param pageable
     * @return
     */
    Page<Client> findByCondition(Client client, SearchVo searchVo, Pageable pageable);

}