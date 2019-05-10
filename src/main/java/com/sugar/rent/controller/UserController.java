package com.sugar.rent.controller;

import com.sugar.rent.entity.User;
import com.sugar.rent.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import java.util.HashMap;
import java.util.Map;

@Controller
@SessionAttributes("user")
public class UserController {

    private final UserService userService;

    @Autowired
    public UserController(UserService userService) {
        this.userService = userService;
    }

    /***
     * 访问 首页
     * @return
     */
    @RequestMapping("/home")
    public String hello(){
        return "home.jsp";
    }


    /***
     * 登录 处理
     * @param user
     * @param model
     * @return
     */
    @RequestMapping("/checkLogin")
    public @ResponseBody
    Map<String, String> checkLogin(@RequestBody User user, Model model) {

        // 待转换成Json格式的响应Map
        Map<String, String> map = new HashMap<>();
        // 查询该用户是否存在
        user = userService.checkLogin(user.getUsername(), user.getPassword());
        // 成功与否的标志
        String flag;
        if (user == null) {
            flag = "failure";
        } else {
            // 把user对象加入Session
            model.addAttribute("user", user);
            flag = "success";
        }
        //将flag放入map
        map.put("flag", flag);
        return map;
    }

    /***
     * 注册 用户名查重
     * @param user
     * @return
     */
    @RequestMapping("/checkExistence")
    public @ResponseBody
    Map<String, String> checkExistence(@RequestBody User user) {

        Map<String, String> map = new HashMap<>();

        String flag;

        User us = userService.checkExistence(user.getUsername());
        if (us == null) {
            flag = "false";
        } else {
            flag = "true";
        }

        map.put("flag", flag);
        return map;
    }

    /***
     * 注册 处理
     * @param user
     * @param model
     * @return
     */
    @RequestMapping("/doRegister")
    public @ResponseBody
    Map<String, String> doRegister(@RequestBody User user, Model model) {

        Map<String, String> map = new HashMap<>();

        String flag;

        if (userService.register(user) > 0) {
            user = userService.checkExistence(user.getUsername());
            model.addAttribute("user", user);

            flag = "success";
        } else {
            flag = "failure";
        }

        map.put("flag", flag);
        return map;
    }

    /***
     * 统计房源总数
     * @return
     */
    @RequestMapping("/count")
    public String count() { return "count.jsp"; }


}
