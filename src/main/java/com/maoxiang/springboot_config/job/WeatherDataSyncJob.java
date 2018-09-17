package com.maoxiang.springboot_config.job;

import lombok.extern.slf4j.Slf4j;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.springframework.scheduling.quartz.QuartzJobBean;

/**
 * @author ShangGuanMingPeng
 * date: 2018/8/31 17:43
 * Description: 天气查询Job
 */
@Slf4j
public class WeatherDataSyncJob extends QuartzJobBean {
    @Override
    protected void executeInternal(JobExecutionContext jobExecutionContext) throws JobExecutionException {
//        log.info("任务执行！");
    }
}
