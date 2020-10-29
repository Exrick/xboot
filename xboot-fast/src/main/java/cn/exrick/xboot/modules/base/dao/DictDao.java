package cn.exrick.xboot.modules.base.dao;

import cn.exrick.xboot.base.XbootBaseDao;
import cn.exrick.xboot.modules.base.entity.Dict;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

/**
 * 字典数据处理层
 * @author Exrick
 */
public interface DictDao extends XbootBaseDao<Dict, String> {

    /**
     * 排序获取全部
     * @return
     */
    @Query(value = "select d from Dict d order by d.sortOrder")
    List<Dict> findAllOrderBySortOrder();

    /**
     * 通过type获取
     * @param type
     * @return
     */
    Dict findByType(String type);

    /**
     * 模糊搜索
     * @param key
     * @return
     */
    @Query(value = "select d from Dict d where d.title like %:key% or d.type like %:key% order by d.sortOrder")
    List<Dict> findByTitleOrTypeLike(@Param("key") String key);
}