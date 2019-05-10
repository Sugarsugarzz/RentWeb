package com.sugar.rent.dao;

import com.sugar.rent.entity.House;

import java.util.List;

public interface HouseDao {


    // 根据城市查找房源列表
    List<House> findHousesListByCity(String city);
}
