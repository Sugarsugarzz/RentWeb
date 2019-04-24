package com.sugar.rent.service;

import com.sugar.rent.entity.User;

public interface UserService {

    // 检查该登录账号是否存在
    User checkLogin(String username, String password);

    // 检查该注册账号是否存在
    User checkExistence(String username);

    // 注册
    int register(User user);

}
