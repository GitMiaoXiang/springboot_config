package com.maoxiang.springboot_config.controller;

import com.alibaba.fastjson.JSON;
import com.maoxiang.springboot_config.constenum.ResponseEnum;
import com.maoxiang.springboot_config.entity.User;
import com.maoxiang.springboot_config.service.IUserService;
import com.maoxiang.springboot_config.utils.RestResultGenerator;
import com.maoxiang.springboot_config.utils.ResultData;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/**
 * @author ShangGuanMingPeng
 * date: 2018/8/24 14:58
 * Description:
 */
@RestController
@RequestMapping("/user")
@Slf4j
public class UserController {


    @Autowired
    private IUserService userService;

    @GetMapping
    public ResultData<List<User>> queryUser(){
        log.info("=================进Controller了================");
        List<User> users = userService.queryAll();
        ResultData resultData = RestResultGenerator.successResult(users, ResponseEnum.SUCCESS);
        log.info("=================返回的数据:"+ JSON.toJSONString(resultData)+"=====================");
        return resultData;
    }
}
