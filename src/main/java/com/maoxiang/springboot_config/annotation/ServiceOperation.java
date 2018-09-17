package com.maoxiang.springboot_config.annotation;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
 * @author ShangGuanMingPeng
 * date: 2018/9/17 15:43
 * Description: 自定义注解，用于方法上，用此注解用于方法上会输出日志
 */
@Target(ElementType.METHOD) //@Target 声明这是一个自定义注解类，ElementType.METHOD 表明此注解可声明在方法上
@Retention(RetentionPolicy.RUNTIME) //@Retention 声明注解保留期限，RetentionPolicy.RUNTIME 表明此注解可保留至运行时，可以通过反射获取注解信息
public @interface ServiceOperation {
    String value() default "";
}
