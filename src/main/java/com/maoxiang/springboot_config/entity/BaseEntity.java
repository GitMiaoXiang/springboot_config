package com.maoxiang.springboot_config.entity;

import lombok.Data;

import javax.persistence.Column;
import javax.persistence.Transient;
import java.util.Date;

/**
 * @author ShangGuanMingPeng
 * date: 2018/8/24 14:54
 * Description: 公共的实体类
 */
@Data
public class BaseEntity {

    @Column(name = "createdate")
    private Date createDate;

    @Transient
    private Date updateDate;
}
