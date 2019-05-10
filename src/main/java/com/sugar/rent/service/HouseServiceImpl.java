package com.sugar.rent.service;

import com.sugar.rent.dao.HouseDao;
import com.sugar.rent.entity.House;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class HouseServiceImpl implements HouseService {

    @Autowired
    private HouseDao houseDao;


    @Override
    public List<House> getHouseList(String city) {

        List<House> list = houseDao.findHousesListByCity(city);
        return list;
    }
}
