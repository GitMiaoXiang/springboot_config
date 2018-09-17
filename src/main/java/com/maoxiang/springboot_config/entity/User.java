package com.maoxiang.springboot_config.entity;

import lombok.Data;

import javax.persistence.Id;
import javax.persistence.Table;

/**
 * @author ShangGuanMingPeng
 * date: 2018/8/24 14:54
 * Description:
 */
@Data
@Table(name = "blog_user")
public class User extends BaseEntity {

    @Id
    private int id;

    private String name;

    private String pwd;

    private String avatar;

    private String status;

    private String tel;

    private String mailbox;

}
