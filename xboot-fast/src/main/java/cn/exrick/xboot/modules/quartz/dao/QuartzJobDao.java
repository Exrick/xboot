package cn.exrick.xboot.modules.quartz.dao;

import cn.exrick.xboot.base.XbootBaseDao;
import cn.exrick.xboot.modules.quartz.entity.QuartzJob;

import java.util.List;

/**
 * 定时任务数据处理层
 * @author Exrick
 */
public interface QuartzJobDao extends XbootBaseDao<QuartzJob, String> {

    /**
     * 通过类名获取
     * @param jobClassName
     * @return
     */
    List<QuartzJob> findByJobClassName(String jobClassName);
}