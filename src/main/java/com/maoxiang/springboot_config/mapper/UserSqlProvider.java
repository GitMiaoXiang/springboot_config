package com.maoxiang.springboot_config.mapper;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.jdbc.SQL;

public class UserSqlProvider {

    public String queryByTelAndName(@Param("username") String username, @Param("password") String password){
        return new SQL(){{
            SELECT("*");
            FROM("blog_user");
            if(username!=null && password != null){
                WHERE("name = #{username} and pwd = #{password}");
            }else if(username!=null && password == null){
                WHERE("name = {username}");
            }else{
                WHERE("pwd = #{password}");
            }
        }}.toString();
    }
}
