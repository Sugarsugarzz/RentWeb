package com.sugar.rent.service;

import com.sugar.rent.entity.House;

import java.util.List;

public interface HouseService {

    // 获取对应城市房源列表
    List<House> getHouseListAtBj();
    List<House> getHouseListAtCd();
    List<House> getHouseListAtCq();
    List<House> getHouseListAtCs();
    List<House> getHouseListAtGz();
    List<House> getHouseListAtHf();
    List<House> getHouseListAtHz();
    List<House> getHouseListAtNj();
    List<House> getHouseListAtQd();
    List<House> getHouseListAtSh();
    List<House> getHouseListAtSz();
    List<House> getHouseListAtTj();
    List<House> getHouseListAtWh();
    List<House> getHouseListAtXa();
    List<House> getHouseListAtXm();

    // 统计房源总数
    int getListCount();

    // 收藏房源
    int collectHouse(String user_id, String house_id, String city);

}
