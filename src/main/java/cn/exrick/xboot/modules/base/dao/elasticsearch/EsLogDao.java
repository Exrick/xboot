package cn.exrick.xboot.modules.base.dao.elasticsearch;

import cn.exrick.xboot.modules.base.entity.elasticsearch.EsLog;
import org.springframework.data.elasticsearch.repository.ElasticsearchRepository;


/**
 * @author Exrickx
 */
public interface EsLogDao extends ElasticsearchRepository<EsLog, String> {

}
