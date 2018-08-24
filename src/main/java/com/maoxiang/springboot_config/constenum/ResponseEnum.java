package com.maoxiang.springboot_config.constenum;

/**
 * @author ShangGuanMingPeng
 * date: 2018/8/24 14:53
 * Description: 
 */
public enum ResponseEnum {

    SYSTEM_EXCEPTION(0,"系统异常"),
    SUCCESS(1,"请求成功"),
    FAILED(2,"请求失败"),
    BUSINESS_EXCEPTION(3,"业务异常");

    private int code;

    private String message;

    ResponseEnum(int code, String message) {
        this.code = code;
        this.message = message;
    }

    public int getCode() {
        return code;
    }

    public String getMessage() {
        return message;
    }
}
