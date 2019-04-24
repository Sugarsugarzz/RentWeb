package com.sugar.rent.service;


import com.sugar.rent.dao.UserDao;
import com.sugar.rent.entity.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class UserServiceImpl implements UserService{

    @Autowired
    private UserDao userDao;

    // 检验登录账号是否存在
    @Override
    public User checkLogin(String username, String password) {

        User user = userDao.findByUsername(username);

        if (user != null && user.getPassword().equals(password)) {
            return user;
        }

        return null;
    }

    // 注册时用户查重
    @Override
    public User checkExistence(String username) {

        return userDao.findByUsername(username);
    }

    // 注册
    @Override
    public int register(User user) {

        return userDao.registerByUsernameAndPassword(user.getUsername(), user.getPassword());
    }
}
