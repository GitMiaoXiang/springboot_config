package com.maoxiang.springboot_config.utils;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.maoxiang.springboot_config.constenum.ResponseEnum;

/**
 * @author ShangGuanMingPeng
 * date: 2018/8/24 14:55
 * Description: 统一响应体,@Data该注解相当于同时加上以下注解@Setter @Getter,@ToString,@EqualsAndHashCode
 * Include.Include.ALWAYS （Default / 都参与序列化）
 * Include.NON_DEFAULT（当Value 为默认值的时候不参与，如Int a; 当 a=0 的时候不参与）
 * Include.NON_EMPTY（当Value 为“” 或者null 不输出）
 */
@JsonInclude(JsonInclude.Include.NON_EMPTY)
public class ResultData<T> {

    private int code;

    private String message;

    private T data;

    public int getCode() {
        return code;
    }

    public String getMessage() {
        return message;
    }

    public T getData() {
        return data;
    }

    public void setData(T data) {
        this.data = data;
    }

    public void setResponseMessage(ResponseEnum responseMessage) {
        this.code = responseMessage.getCode();
        this.message = responseMessage.getMessage();
    }
}
