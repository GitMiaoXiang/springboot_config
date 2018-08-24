package com.maoxiang.springboot_config.constenum;

/**
 * @author ShangGuanMingPeng
 * date: 2018/8/24 14:52
 * Description:
 */
public enum ExceptionEnum {
    
    BUSINESSEXCEPTION(3,"业务异常");

    private int code;

    private String message;

    ExceptionEnum(int code, String message) {
        this.code = code;
        this.message = message;
    }

    public int getCode() {
        return code;
    }

    public String getMessage() {
        return message;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public void setMessage(String message) {
        this.message = message;
    }
}
