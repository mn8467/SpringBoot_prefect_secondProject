package com.example.test_prefect.mapper;

import com.example.test_prefect.model.LicensesVO;
import com.example.test_prefect.model.UserVO;
import com.example.test_prefect.util.PcwkLogger;
import com.example.test_prefect.util.WorkDiv;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface LicensesDao extends WorkDiv<LicensesVO>, PcwkLogger {
     int getLicensesSeq();

     List<LicensesVO> getLicensesName();

     List<LicensesVO> getUserLicenses(UserVO inVO);

}
