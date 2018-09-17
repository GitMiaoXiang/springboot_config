package com.maoxiang.springboot_config.service;

import com.github.pagehelper.PageInfo;

import java.util.List;

public interface IBaseService<T> {

    /**
     * 根据id主键查询
     *
     * @param id
     * @return
     */
    T queryById(Long id);

    /**
     * 查询所有数据
     *
     * @return
     */
    List<T> queryAll();

    /**
     * 根据条件查询一条数据，如果查询到多条则抛出异常
     *
     * @param record
     * @return
     */
    T queryOne(T record);

    /**
     * 根据条件查询列表
     *
     * @param record
     * @return
     */
    List<T> queryListByWhere(T record);

    /**
     * 分页查询
     *
     * @param page
     * @param rows
     * @param record
     * @return
     */
    PageInfo<T> queryPageListByWhere(Integer page, Integer rows, T record);

    /**
     * 添加信息
     *
     * @param t
     * @return 返回成功条数
     */
     Integer save(T t);

    /**
     * 添加信息（使用不为空字段）
     *
     * @param t
     * @return 返回成功条数
     */
     Integer saveSelective(T t);

    /**
     * 修改信息
     *
     * @param t
     * @return 返回成功条数
     */
     Integer update(T t);

    /**
     * 修改信息（使用不为空字段）
     *
     * @param t
     * @return 返回成功条数
     */
     Integer updateSelective(T t);


    /**
     * 根据主键id删除
     *
     * @param id
     * @return 返回成功条数
     */
     Integer deleteById(Integer id);

    /**
     * 批量删除
     *
     * @param values
     * @param property
     * @param clazz
     * @return
     */
     Integer deleteByIds(List<Object> values, String property, Class<T> clazz);

    /**
     * 根据自定义条件删除
     *
     * @param record
     * @return
     */
     Integer deleteByWhere(T record);

}
