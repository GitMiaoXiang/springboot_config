package com.maoxiang.springboot_config.aop;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.serializer.SerializerFeature;
import com.maoxiang.springboot_config.utils.DateUtils;
import com.maoxiang.springboot_config.utils.RequestUtil;
import lombok.extern.slf4j.Slf4j;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpServletRequest;
import java.util.Map;

/**
 * @author ShangGuanMingPeng
 * date: 2018/9/17 14:08
 * Description: 接口日志日志输出文件
 */
@Aspect
@Component
@Slf4j
public class LogControllerAop {

    @Autowired
    private HttpServletRequest request;

    private long startTime;

    private long returnTime;

//    @Pointcut(“execution(* com.xjj.web.controller..*(..)) and @annotation(org.springframework.web.bind.annotation.RequestMapping)”)
    @Pointcut(value = "execution(* com.maoxiang.springboot_config.controller..*(..))")
    public void serviceStatistics(){

    }

    /**
     * 前置通知
     * @param joinPoint
     */
    @Before("serviceStatistics()")
    public void doBefore(JoinPoint joinPoint){
        Map<String, Object> pointInfo = RequestUtil.getJoinPointInfoMap(joinPoint);
        startTime = System.currentTimeMillis();
        log.info("==========================开始啦==========================");
        log.info("==========================开始啦==========================");
        log.info("==========================开始啦==========================");
        log.info("==========================请求地址："+request.getRequestURL().toString());
        log.info("==========================开始时间："+ DateUtils.getDateToString(startTime));
        log.info("==========================请求参数："+pointInfo.get("paramMap"));
        log.info("==========================Ip地址："+RequestUtil.getRequestIp(request));
        log.info("==========================类入径："+pointInfo.get("classPath").toString());
        log.info("==========================方法名："+pointInfo.get("methodName").toString());
        log.info("==========================请求方式："+request.getMethod());
        log.info("==========================请求类型："+RequestUtil.getRequestType(request));
        log.info("==========================请求接口唯一Session标识："+request.getSession().getId());
    }

    /**
     * 返回通知
     * @param returnValue
     */
    @AfterReturning(value = "serviceStatistics()",returning = "returnValue")
    public void doAfterReturning(Object returnValue){
        returnTime = System.currentTimeMillis();
        log.info("==========================返回时间："+DateUtils.getDateToString(returnTime));
        log.info("==========================接口请求总共时间："+DateUtils.subtractTime(startTime,returnTime));
        log.info("==========================返回数据："+ JSON.toJSONString(returnValue, SerializerFeature.DisableCircularReferenceDetect,SerializerFeature.WriteMapNullValue));
        log.info("==========================正常结束啦==========================");
        log.info("==========================正常结束啦==========================");
        log.info("==========================正常结束啦==========================");
    }

    /**
     * 异常通知
     * @param e
     */
    @AfterThrowing(value = "serviceStatistics()", throwing = "e")
    public void doAfterThrowing(Throwable e){
        long happenTime = System.currentTimeMillis();
        log.info("==========================异常产生时间："+DateUtils.getDateToString(happenTime));
        log.info("==========================异常返回数据："+JSON.toJSONString(e,SerializerFeature.DisableCircularReferenceDetect,SerializerFeature.WriteMapNullValue));
        log.info("==========================异常信息："+e.getMessage());
        log.info("==========================返回异常咯==========================");
        log.info("==========================返回异常咯==========================");
        log.info("==========================返回异常咯==========================");
    }

}
