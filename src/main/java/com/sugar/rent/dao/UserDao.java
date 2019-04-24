package com.sugar.rent.dao;

import com.sugar.rent.entity.User;
import org.apache.ibatis.annotations.Param;

public interface UserDao {

    // 查找用户名和密码
    User findByUsername(String username);

    // 注册用户和密码
    int registerByUsernameAndPassword(@Param("username") String username, @Param("password") String password);

}