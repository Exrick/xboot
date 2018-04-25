package cn.exrick.xboot.service.elasticsearch;

import cn.exrick.xboot.entity.elasticsearch.EsLog;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;

/**
 * @author Exrickx
 */
public interface LogService {

    /**
     * 添加日志
     * @param esLog
     * @return
     */
    EsLog saveLog(EsLog esLog);

    /**
     * 通过id删除日志
     */
    void deleteLog(String id);

    /**
     * 分页获取全部日志
     * @param pageable
     * @return
     */
    Page<EsLog> getLogList(Pageable pageable);

    /**
     * 分页搜索获取日志
     * @param key
     * @param pageable
     * @return
     */
    Page<EsLog> searchLog(String key, Pageable pageable);
}
