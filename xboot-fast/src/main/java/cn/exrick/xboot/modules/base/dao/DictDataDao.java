package cn.exrick.xboot.modules.base.dao;

import cn.exrick.xboot.base.XbootBaseDao;
import cn.exrick.xboot.modules.base.entity.DictData;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

/**
 * 字典数据数据处理层
 * @author Exrick
 */
public interface DictDataDao extends XbootBaseDao<DictData, String> {

    /**
     * 通过dictId和状态获取
     * @param dictId
     * @param status
     * @return
     */
    List<DictData> findByDictIdAndStatusOrderBySortOrder(String dictId, Integer status);

    /**
     * 通过dictId删除
     * @param dictId
     */
    @Modifying
    @Query("delete from DictData d where d.dictId = ?1")
    void deleteByDictId(String dictId);
}