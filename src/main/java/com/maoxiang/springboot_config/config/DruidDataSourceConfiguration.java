package com.maoxiang.springboot_config.config;


import com.alibaba.druid.pool.DruidDataSource;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;

import javax.sql.DataSource;

/**
 * @author ShangGuanMingPeng
 * date: 2018/8/24 14:53
 * Description: Druid连接池配置
 */
@Configuration
public class DruidDataSourceConfiguration {

    @Bean
    @Primary
    @ConfigurationProperties(prefix = "spring.datasource")
    public DataSource druildDataSource(){
        DruidDataSource dataSource = new DruidDataSource();
        return dataSource;
    }
}
