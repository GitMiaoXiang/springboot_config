package com.maoxiang.springboot_config.mapper;

import com.maoxiang.springboot_config.Base.MyMapper;
import com.maoxiang.springboot_config.entity.User;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.SelectProvider;
import org.springframework.stereotype.Repository;


/**
 * @author ShangGuanMingPeng
 * date: 2018/8/24 14:53
 * Description: 
 */
@Mapper
@Repository
public interface UserMapper extends MyMapper<User> {

    //数据库字段与实体类不一致时，可以配置映射
//    @Results({
//            @Result(property = "userId", column = "USER_ID"),
//            @Result(property = "username", column = "USERNAME"),
//            @Result(property = "password", column = "PASSWORD"),
//            @Result(property = "mobileNum", column = "PHONE_NUM")
//    })
    @Select("SELECT * FROM blog_user WHERE id = #{id}")
    User queryUser(int id);

    /**
     * 延伸：无论什么方式,如果涉及多个参数,则必须加上@Param注解,否则无法使用EL表达式获取参数。
     */
    @Select("SELECT * FROM blog_user WHERE name = #{username} AND pwd = #{password};")
    User login(@Param("username") String username, @Param("password") String password);

    /**
     * 复杂sql
     */
    @SelectProvider(type = UserSqlProvider.class,method = "queryByTelAndName")
    User queryByTelAndName(@Param("username") String username, @Param("password") String password);

    /**
     * 1.用于获取结果集的映射关系
     */
//    public static String getResultsStr(Class origin) {
//        StringBuilder stringBuilder = new StringBuilder();
//        stringBuilder.append("@Results({\n");
//        for (Field field : origin.getDeclaredFields()) {
//            String property = field.getName();
//            //映射关系：对象属性(驼峰)->数据库字段(下划线)
//            String column = new PropertyNamingStrategy.SnakeCaseStrategy().translate(field.getName()).toUpperCase();
//            stringBuilder.append(String.format("@Result(property = \"%s\", column = \"%s\"),\n", property, column));
//        }
//        stringBuilder.append("})");
//        return stringBuilder.toString();
//    }
}
