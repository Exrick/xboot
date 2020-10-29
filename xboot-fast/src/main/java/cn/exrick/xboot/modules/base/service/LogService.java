package cn.exrick.xboot.modules.base.service;


import cn.exrick.xboot.base.XbootBaseService;
import cn.exrick.xboot.common.vo.SearchVo;
import cn.exrick.xboot.modules.base.entity.Log;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

/**
 * 日志接口
 * @author Exrickx
 */
public interface LogService extends XbootBaseService<Log, String> {

    /**
     * 分页搜索获取日志
     * @param type
     * @param key
     * @param searchVo
     * @param pageable
     * @return
     */
    Page<Log> findByConfition(Integer type, String key, SearchVo searchVo, Pageable pageable);

    /**
     * 删除所有
     */
    void deleteAll();
}
