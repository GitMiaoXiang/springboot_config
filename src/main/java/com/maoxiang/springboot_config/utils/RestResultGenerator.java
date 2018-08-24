package com.maoxiang.springboot_config.utils;

import com.alibaba.fastjson.JSON;
import com.maoxiang.springboot_config.constenum.ResponseEnum;
import lombok.extern.slf4j.Slf4j;

/**
 * @author ShangGuanMingPeng
 * date: 2018/8/24 14:55
 * Description: 统一的返回格式
 */
@Slf4j
public class RestResultGenerator {


    /**
     *生成响应成功(带正文)的结果
     * @param data
     * @return ResultData
     */
    public static <T> ResultData<T> successResult(T data, ResponseEnum responseErrorEnum){
        ResultData<T> result = new ResultData<>();
        result.setResponseMessage(responseErrorEnum);
        result.setData(data);
        log.debug("======================》》ResultData:{}", JSON.toJSONString(result));
        return result;
    }

    /**
     * 生成响应失败(带errorCode)的结果
     * @param responseErrorEnum 失败信息
     * @return ResultData
     */
    public static ResultData errorResult(ResponseEnum responseErrorEnum) {
        ResultData result = new ResultData();
        result.setResponseMessage(responseErrorEnum);
        log.debug("======================》》ResultData:{}", JSON.toJSONString(result));
        return result;
    }
}
