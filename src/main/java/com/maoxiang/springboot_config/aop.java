package com.maoxiang.springboot_config;

import org.apache.tomcat.util.http.RequestUtil;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpServletRequest;

@Aspect
@Component
public class aop {

    @Autowired
    private HttpServletRequest request;

//    @Pointcut(“execution(* com.xjj.web.controller..*(..)) and @annotation(org.springframework.web.bind.annotation.RequestMapping)”)
    @Pointcut(value = "execution(* com.maoxiang.springboot_config.controller..*(..))")
    public void serviceStatistics(){

    }

    @Before("serviceStatistics()")
    public void doBefore(JoinPoint joinPoint){
        RequestUtil.getJoin
    }


}
