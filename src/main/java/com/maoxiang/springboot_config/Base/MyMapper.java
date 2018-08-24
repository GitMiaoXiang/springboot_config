package com.maoxiang.springboot_config.Base;

import tk.mybatis.mapper.common.Mapper;
import tk.mybatis.mapper.common.MySqlMapper;

/**
 * @author ShangGuanMingPeng
 * date: 2018/8/24 14:54
 * Description: 通用mapper,该接口不能被扫描到
 */
public interface MyMapper<T> extends Mapper<T>, MySqlMapper<T> {
}
