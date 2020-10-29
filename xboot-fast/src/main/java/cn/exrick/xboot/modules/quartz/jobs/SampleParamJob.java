package cn.exrick.xboot.modules.quartz.jobs;

import cn.hutool.core.date.DateUtil;
import lombok.extern.slf4j.Slf4j;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

/**
 * 示例带参定时任务
 * @author Exrickx
 */
@Slf4j
public class SampleParamJob implements Job {

    /**
     * 若参数变量名修改 QuartzJobController中也需对应修改
     */
    private String parameter;

    public void setParameter(String parameter) {
        this.parameter = parameter;
    }

    @Override
    public void execute(JobExecutionContext jobExecutionContext) throws JobExecutionException {

        log.info(String.format("Hello %s! 欢迎使用XBoot前后端分离开发平台!作者:Exrick 时间:" + DateUtil.now(), this.parameter));
    }
}
