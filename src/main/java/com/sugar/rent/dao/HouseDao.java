package com.sugar.rent.dao;

import com.sugar.rent.entity.House;

import java.util.List;

public interface HouseDao {


    // 根据城市查找房源列表
    List<House> findHousesListAtBj();
    List<House> findHousesListAtCd();
    List<House> findHousesListAtCq();
    List<House> findHousesListAtCs();
    List<House> findHousesListAtGz();
    List<House> findHousesListAtHf();
    List<House> findHousesListAtHz();
    List<House> findHousesListAtNj();
    List<House> findHousesListAtQd();
    List<House> findHousesListAtSh();
    List<House> findHousesListAtSz();
    List<House> findHousesListAtTj();
    List<House> findHousesListAtWh();
    List<House> findHousesListAtXa();
    List<House> findHousesListAtXm();

    // 统计房源总数
    int countList();

}
