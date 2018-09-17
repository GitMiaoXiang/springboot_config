package com.maoxiang.springboot_config.service.aop;

import com.maoxiang.springboot_config.annotation.ServiceOperation;
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
 * Description: service日志输出
 */
@Aspect
@Component
@Slf4j
public class LogServiceAop {

    @Autowired
    private HttpServletRequest request;

//    @Pointcut(“execution(* com.xjj.web.controller..*(..)) and @annotation(org.springframework.web.bind.annotation.RequestMapping)”)
    @Pointcut(value = "@annotation(serviceOperation)")
    public void serviceStatistics(ServiceOperation serviceOperation){

    }

    /**
     * 前置通知
     * @param joinPoint
     */
    @Before("serviceStatistics(serviceOperation)")
    public void doBefore(JoinPoint joinPoint,ServiceOperation serviceOperation){
        Map<String, Object> pointInfo = RequestUtil.getJoinPointInfoMap(joinPoint);
        log.info("=========================="+request.getRequestURL().toString()+"接口service日志输出开始==========================");
        log.info("=========================="+request.getRequestURL().toString()+"接口service日志输出开始==========================");
        log.info("=========================="+request.getRequestURL().toString()+"接口service日志输出开始==========================");
        log.info("==========================类入径："+pointInfo.get("classPath").toString());
        log.info("==========================方法名："+pointInfo.get("methodName").toString());
    }

    /**
     * 返回通知
     * @param returnValue
     */
    @AfterReturning(value = "serviceStatistics(serviceOperation)",returning = "returnValue")
    public void doAfterReturning(Object returnValue, ServiceOperation serviceOperation){
        log.info("=========================="+request.getRequestURL().toString()+"接口service日志输出完成==========================");
        log.info("=========================="+request.getRequestURL().toString()+"接口service日志输出完成==========================");
        log.info("=========================="+request.getRequestURL().toString()+"接口service日志输出完成==========================");
    }

    /**
     * 异常通知
     * @param e
     */
    @AfterThrowing(value = "serviceStatistics(serviceOperation)", throwing = "e")
    public void doAfterThrowing(Throwable e,ServiceOperation serviceOperation){
        log.info("=========================="+request.getRequestURL().toString()+"接口返回异常咯==========================");
        log.info("=========================="+request.getRequestURL().toString()+"接口返回异常咯==========================");
        log.info("=========================="+request.getRequestURL().toString()+"接口返回异常咯==========================");
    }

}
