package cn.exrick.xboot.dao.elasticsearch;

import cn.exrick.xboot.entity.elasticsearch.EsLog;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.elasticsearch.repository.ElasticsearchRepository;

import java.util.List;


/**
 * @author Exrickx
 */
public interface EsLogDao extends ElasticsearchRepository<EsLog, String> {

}
