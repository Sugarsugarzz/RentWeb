package com.sugar.rent.controller;


import com.sugar.rent.entity.House;
import com.sugar.rent.service.HouseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import java.util.List;


@Controller
@SessionAttributes("user")
public class HouseController {


    private final HouseService houseService;

    @Autowired
    public HouseController(HouseService houseService) {
        this.houseService = houseService;
    }


    @RequestMapping("/list")
    public String list(Model model) {

        List<House> list = houseService.getHouseListAtBj();

        model.addAttribute("houses", list);

        return "list.jsp";
    }

    @RequestMapping("/listChange")
    public @ResponseBody
    List<House> checkLogin(@RequestParam("city") String city) {

        List<House> list = houseService.getHouseListAtGz();


        return list;
    }

    /***
     * 访问 主页
     * @return
     */
    @RequestMapping("/main")
    public String main(@RequestParam("city") String city, ModelMap model) {

        List<House> list;

        int count = houseService.getListCount();
        model.addAttribute("count", count);

        switch (city) {

            case "bj":
                list = houseService.getHouseListAtBj();
                model.addAttribute("houses", list);
                model.addAttribute("city", "北京市");
                break;

            case "sh":
                list = houseService.getHouseListAtSh();
                model.addAttribute("houses", list);
                model.addAttribute("city", "上海市");
                break;

            case "gz":
                list = houseService.getHouseListAtGz();
                model.addAttribute("houses", list);
                model.addAttribute("city", "广州市");
                break;

            case "sz":
                list = houseService.getHouseListAtSz();
                model.addAttribute("houses", list);
                model.addAttribute("city", "深圳市");
                break;

            case "hz":
                list = houseService.getHouseListAtHz();
                model.addAttribute("houses", list);
                model.addAttribute("city", "杭州市");
                break;

            case "cd":
                list = houseService.getHouseListAtCd();
                model.addAttribute("houses", list);
                model.addAttribute("city", "成都市");
                break;

            case "cq":
                list = houseService.getHouseListAtCq();
                model.addAttribute("houses", list);
                model.addAttribute("city", "重庆市");
                break;

            case "cs":
                list = houseService.getHouseListAtCs();
                model.addAttribute("houses", list);
                model.addAttribute("city", "长沙市");
                break;

            case "hf":
                list = houseService.getHouseListAtHf();
                model.addAttribute("houses", list);
                model.addAttribute("city", "合肥市");
                break;

            case "nj":
                list = houseService.getHouseListAtNj();
                model.addAttribute("houses", list);
                model.addAttribute("city", "南京市");
                break;

            case "tj":
                list = houseService.getHouseListAtTj();
                model.addAttribute("houses", list);
                model.addAttribute("city", "天津市");
                break;

            case "qd":
                list = houseService.getHouseListAtQd();
                model.addAttribute("houses", list);
                model.addAttribute("city", "青岛市");
                break;

            case "wh":
                list = houseService.getHouseListAtWh();
                model.addAttribute("houses", list);
                model.addAttribute("city", "武汉市");
                break;

            case "xa":
                list = houseService.getHouseListAtXa();
                model.addAttribute("houses", list);
                model.addAttribute("city", "西安市");
                break;

            case "xm":
                list = houseService.getHouseListAtXm();
                model.addAttribute("houses", list);
                model.addAttribute("city", "厦门市");
                break;

        }


        return "main.jsp";
    }
}
