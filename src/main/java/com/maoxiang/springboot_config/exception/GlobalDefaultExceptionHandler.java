package com.maoxiang.springboot_config.exception;

import com.maoxiang.springboot_config.constenum.ResponseEnum;
import com.maoxiang.springboot_config.utils.RestResultGenerator;
import com.maoxiang.springboot_config.utils.ResultData;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import javax.servlet.http.HttpServletRequest;

/**
 * @author ShangGuanMingPeng
 * date: 2018/8/24 14:54
 * Description: 全局异常处理
 */
@RestControllerAdvice
@Slf4j
public class GlobalDefaultExceptionHandler {

    @ExceptionHandler(Exception.class)
    @ResponseBody
    public ResultData defaultExceptionHandler(HttpServletRequest request, Exception e){
        if (e instanceof BusinessException){
            log.info("==================业务异常==================");
            log.info("Exception========={}",e.getStackTrace());
            log.info("Message:=========={}",e.getMessage());
            log.info("==================业务异常==================");
            return RestResultGenerator.errorResult(ResponseEnum.BUSINESS_EXCEPTION);
        }
        return RestResultGenerator.errorResult(ResponseEnum.SYSTEM_EXCEPTION);
    }
}
