package com.example.test_prefect.service;

import com.example.test_prefect.mapper.LicensesDao;
import com.example.test_prefect.model.LicensesVO;
import com.example.test_prefect.model.UserVO;
import com.example.test_prefect.util.PcwkLogger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class LicensesService implements PcwkLogger {

    @Autowired
    LicensesDao dao;

    public int doUpdate(LicensesVO inVO){
        return dao.doUpdate(inVO);
    }

    public int doDelete(LicensesVO inVO){
        return dao.doDelete(inVO);
    }

    public LicensesVO doSelectOne(LicensesVO inVO){
        return dao.doSelectOne(inVO);
    }

    public int doSave(LicensesVO inVO) {
        return dao.doSave(inVO);
    }

    public List<LicensesVO> doRetrieve(LicensesVO inVO) {
        return dao.doRetrieve(inVO);
    }

    public int getLicensesSeq() {

        return dao.getLicensesSeq();
    }

    public List<LicensesVO> getLicensesName()  {

        return dao.getLicensesName();
    }

    public List<LicensesVO> getUserLicenses(UserVO inVO) {

        return dao.getUserLicenses(inVO);
    }

}

