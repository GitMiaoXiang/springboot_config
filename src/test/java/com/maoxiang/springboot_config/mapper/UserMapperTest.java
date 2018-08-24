package com.maoxiang.springboot_config.mapper;

import com.maoxiang.springboot_config.entity.User;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import java.util.Date;
import java.util.List;

// 获取启动类，加载配置，确定装载 Spring 程序的装载方法，它回去寻找 主配置启动类（被 @SpringBootApplication 注解的）
@SpringBootTest
// 让 JUnit 运行 Spring 的测试环境， 获得 Spring 环境的上下文的支持
@RunWith(SpringRunner.class)
public class UserMapperTest {

    @Autowired
    private UserMapper userMapper;

    @Test
    public void queryUser() {
        User user = userMapper.queryUser(2);
        System.out.println(user.toString());
    }

    @Test
    public void login() {
        User login = userMapper.login("14796635306", "123");
        System.out.println(login);
    }

    @Test
    public void queryByTelAndName() {
        User user = userMapper.queryByTelAndName("14796635306", "123");
        System.out.println(user.toString());
    }

    @Test
    public void insert(){
        User user = new User();
        user.setAvatar("11");
        user.setCreateDate(new Date());
        user.setMailbox("11");
        user.setName("11");
        user.setPwd("11");
        user.setStatus("1");
        user.setTel("11");
        int i = userMapper.insertSelective(user);
        System.out.println(i);
    }

    @Test
    public void queryAll(){
        List<User> users = userMapper.selectAll();
        System.out.println(users.toString());
    }
}