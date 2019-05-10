package com.sugar.rent.controller;


import com.sugar.rent.entity.House;
import com.sugar.rent.service.HouseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
public class HouseController {


    private final HouseService houseService;

    @Autowired
    public HouseController(HouseService houseService) {
        this.houseService = houseService;
    }


    @RequestMapping("/list")
    public String list(Model model) {

        String city = "厦门";

        List<House> list = houseService.getHouseList(city);

        model.addAttribute("houses", list);

        return "list.jsp";
    }

    /***
     * 访问 主页
     * @return
     */
    @RequestMapping("/main")
    public String main(Model model) {

        String city = "厦门";

        List<House> list = houseService.getHouseList(city);

        model.addAttribute("houses", list);

        return "main.jsp";
    }
}
