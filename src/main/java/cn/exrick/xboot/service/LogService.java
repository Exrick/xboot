package cn.exrick.xboot.service;


import cn.exrick.xboot.base.XbootBaseService;
import cn.exrick.xboot.common.vo.SearchVo;
import cn.exrick.xboot.entity.Log;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;

/**
 * 日志接口
 * @author Exrickx
 */
public interface LogService extends XbootBaseService<Log,String> {

    /**
     * 日志搜索
     * @param key
     * @param searchVo
     * @param pageable
     * @return
     */
    Page<Log> searchLog(String key, SearchVo searchVo, Pageable pageable);

    /**
     * 删除所有
     */
    void deleteAll();
}
