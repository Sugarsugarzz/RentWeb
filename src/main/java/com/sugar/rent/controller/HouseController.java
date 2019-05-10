package com.sugar.rent.controller;


import com.sugar.rent.entity.House;
import com.sugar.rent.service.HouseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
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

        List<House> list = houseService.getHouseListAtBj();

        model.addAttribute("houses", list);

        return "list.jsp";
    }

    /***
     * 访问 主页
     * @return
     */
    @RequestMapping("/main")
    public String main(ModelMap model) {

        List<House> listBj = houseService.getHouseListAtBj();
        List<House> listCd = houseService.getHouseListAtCd();
        List<House> listCq = houseService.getHouseListAtCq();
        List<House> listCs = houseService.getHouseListAtCs();
        List<House> listGz = houseService.getHouseListAtGz();
        List<House> listHf = houseService.getHouseListAtHf();
        List<House> listHz = houseService.getHouseListAtHz();
        List<House> listNj = houseService.getHouseListAtNj();
        List<House> listQd = houseService.getHouseListAtQd();
        List<House> listSh = houseService.getHouseListAtSh();
        List<House> listSz = houseService.getHouseListAtSz();
        List<House> listTj = houseService.getHouseListAtTj();
        List<House> listWh = houseService.getHouseListAtWh();
        List<House> listXa = houseService.getHouseListAtXa();
        List<House> listXm = houseService.getHouseListAtXm();


        model.addAttribute("housesBj", listBj);
        model.addAttribute("housesCd", listCd);
        model.addAttribute("housesCq", listCq);
        model.addAttribute("housesCs", listCs);
        model.addAttribute("housesGz", listGz);
        model.addAttribute("housesHf", listHf);
        model.addAttribute("housesHz", listHz);
        model.addAttribute("housesNj", listNj);
        model.addAttribute("housesQd", listQd);
        model.addAttribute("housesSh", listSh);
        model.addAttribute("housesSz", listSz);
        model.addAttribute("housesTj", listTj);
        model.addAttribute("housesWh", listWh);
        model.addAttribute("housesXa", listXa);
        model.addAttribute("housesXm", listXm);

        return "main.jsp";
    }
}
