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
    public List<House> getHouseListAtBj() {

        List<House> list = houseDao.findHousesListAtBj();
        return list;
    }

    @Override
    public List<House> getHouseListAtCd() {

        List<House> list = houseDao.findHousesListAtCd();
        return list;
    }

    @Override
    public List<House> getHouseListAtCq() {

        List<House> list = houseDao.findHousesListAtCq();
        return list;
    }

    @Override
    public List<House> getHouseListAtCs() {

        List<House> list = houseDao.findHousesListAtCs();
        return list;
    }

    @Override
    public List<House> getHouseListAtGz() {

        List<House> list = houseDao.findHousesListAtGz();
        return list;
    }

    @Override
    public List<House> getHouseListAtHf() {

        List<House> list = houseDao.findHousesListAtHf();
        return list;
    }

    @Override
    public List<House> getHouseListAtHz() {

        List<House> list = houseDao.findHousesListAtHz();
        return list;
    }

    @Override
    public List<House> getHouseListAtNj() {

        List<House> list = houseDao.findHousesListAtNj();
        return list;
    }

    @Override
    public List<House> getHouseListAtQd() {

        List<House> list = houseDao.findHousesListAtQd();
        return list;
    }

    @Override
    public List<House> getHouseListAtSh() {

        List<House> list = houseDao.findHousesListAtSh();
        return list;
    }

    @Override
    public List<House> getHouseListAtSz() {

        List<House> list = houseDao.findHousesListAtSz();
        return list;
    }

    @Override
    public List<House> getHouseListAtTj() {

        List<House> list = houseDao.findHousesListAtTj();
        return list;
    }

    @Override
    public List<House> getHouseListAtWh() {

        List<House> list = houseDao.findHousesListAtWh();
        return list;
    }

    @Override
    public List<House> getHouseListAtXa() {

        List<House> list = houseDao.findHousesListAtXa();
        return list;
    }

    @Override
    public List<House> getHouseListAtXm() {

        List<House> list = houseDao.findHousesListAtXm();
        return list;
    }
}
