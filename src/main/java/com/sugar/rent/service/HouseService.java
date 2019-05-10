package com.sugar.rent.service;

import com.sugar.rent.entity.House;

import java.util.List;

public interface HouseService {

    // 获取房源列表
    List<House> getHouseList(String city);
}
