package com.maoxiang.springboot_config.Base;

import lombok.Data;

@Data
public class HttpResult {

    // 响应的状态码
    private int code;

    // 响应的响应体
    private String body;

    public HttpResult(int statusCode, String body) {
        this.code = statusCode;
        this.body = body;
    }
}
