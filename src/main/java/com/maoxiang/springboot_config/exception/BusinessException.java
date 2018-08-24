package com.maoxiang.springboot_config.exception;

import com.maoxiang.springboot_config.constenum.ExceptionEnum;

/**
 * @author ShangGuanMingPeng
 * date: 2018/8/24 14:52
 * Description: 业务异常处理
 */
public class BusinessException extends RuntimeException{

    private static final long serialVersionUID = 1L;

    private Integer code;  //错误码

    public BusinessException() {}

    public BusinessException(ExceptionEnum exceptionEnum) {
        super(exceptionEnum.getMessage());
        this.code = exceptionEnum.getCode();
    }

    public Integer getCode() {
        return code;
    }

    public void setCode(Integer code) {
        this.code = code;
    }
}
