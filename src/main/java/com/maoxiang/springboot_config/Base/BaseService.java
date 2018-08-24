package com.maoxiang.springboot_config.Base;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import tk.mybatis.mapper.entity.Example;

import java.util.Date;
import java.util.List;

/**
 * @author ShangGuanMingPeng
 * date: 2018/8/24 14:51
 * Description: 公共的Service
 */
public class BaseService<T extends BaseEntity> implements IBaseService<T>{

    @Autowired
    private MyMapper<T> mapper;

    // public abstract Mapper<T> getMapper();

    /**
     * 根据id主键查询
     *
     * @param id
     * @return
     */
    public T queryById(Long id) {
        return mapper.selectByPrimaryKey(id);
    }

    /**
     * 查询所有数据
     *
     * @return
     */
    public List<T> queryAll() {
        return mapper.select(null);
    }

    /**
     * 根据条件查询一条数据，如果查询到多条则抛出异常
     *
     * @param record
     * @return
     */
    public T queryOne(T record) {
        return mapper.selectOne(record);
    }

    /**
     * 根据条件查询列表
     *
     * @param record
     * @return
     */
    public List<T> queryListByWhere(T record) {
        return mapper.select(record);
    }

    /**
     * 分页查询
     *
     * @param page
     * @param rows
     * @param record
     * @return
     */
    public PageInfo<T> queryPageListByWhere(Integer page, Integer rows, T record) {

        // 设置分页条件
        PageHelper.startPage(page, rows);
        // 根据条件查询
        List<T> list = mapper.select(record);
        // 返回分页信息
        return new PageInfo<T>(list);
    }

    /**
     * 添加信息
     *
     * @param t
     * @return 返回成功条数
     */
    public Integer save(T t) {
        // 设置创建时间和更新时间
        t.setCreateDate(new Date());
        t.setUpdateDate(t.getCreateDate());
        return mapper.insert(t);
    }

    /**
     * 添加信息（使用不为空字段）
     *
     * @param t
     * @return 返回成功条数
     */
    public Integer saveSelective(T t) {
        // 设置创建时间和更新时间
        t.setCreateDate(new Date());
        t.setUpdateDate(t.getCreateDate());
        return mapper.insertSelective(t);
    }

    /**
     * 修改信息
     *
     * @param t
     * @return 返回成功条数
     */
    public Integer update(T t) {
        // 设置更新时间
        t.setUpdateDate(new Date());
        return mapper.updateByPrimaryKey(t);
    }

    /**
     * 修改信息（使用不为空字段）
     *
     * @param t
     * @return 返回成功条数
     */
    public Integer updateSelective(T t) {
        // 设置更新试讲
        t.setUpdateDate(new Date());
        // 设置创建时间字段为空，强制永远不被跟新
        t.setCreateDate(null);
        return mapper.updateByPrimaryKeySelective(t);
    }

    /**
     * 根据主键id删除
     *
     * @param id
     * @return 返回成功条数
     */
    public Integer deleteById(Integer id) {
        return mapper.deleteByPrimaryKey(id);
    }

    /**
     * 批量删除
     *
     * @param values
     * @param property
     * @param clazz
     * @return
     */
    public Integer deleteByIds(List<Object> values, String property, Class<T> clazz) {
        Example example = new Example(clazz);
        example.createCriteria().andIn(property, values);
        return mapper.deleteByExample(example);
    }

    /**
     * 根据自定义条件删除
     *
     * @param record
     * @return
     */
    public Integer deleteByWhere(T record) {
        return mapper.delete(record);
    }

}
