package com.example.test_prefect.mapper;

import com.example.test_prefect.model.UserVO;
import com.example.test_prefect.util.PcwkLogger;
import com.example.test_prefect.util.WorkDiv;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.stereotype.Repository;

import java.util.List;

@Mapper
public interface UserDao extends WorkDiv<UserVO> , PcwkLogger {

    int doSave(UserVO inVO);

    int doUpdate(UserVO inVO);

    int doDelete(UserVO inVO);

    UserVO doSelectOne(UserVO inVO) throws EmptyResultDataAccessException;

    List<UserVO> getAll(UserVO inVO);

    int getCount(UserVO inVO);

    int emailDuplicateCheck(UserVO inVO);

    int doUpdatePassword(UserVO inVO);

    int totalUsers();

    int doPauseUser(UserVO inVO);
}
