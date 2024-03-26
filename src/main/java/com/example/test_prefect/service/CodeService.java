package com.example.test_prefect.service;

import com.example.test_prefect.mapper.CodeDao;
import com.example.test_prefect.model.CodeVO;
import com.example.test_prefect.util.PcwkLogger;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;


@Service
public class CodeService {

    @Autowired
    CodeDao dao;

    public List<CodeVO> doRetrieve(Map<String, Object> map) {
        return dao.doRetrieve(map);
    }

}
