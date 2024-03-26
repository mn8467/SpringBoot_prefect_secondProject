package com.example.test_prefect.service;

import com.example.test_prefect.mapper.UserDao;
import com.example.test_prefect.model.UserVO;
import com.example.test_prefect.util.PcwkLogger;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserService implements PcwkLogger {

    final Logger LOG = LogManager.getLogger(getClass());

    @Autowired
    private UserDao userDao;

    public List<UserVO> getAll(UserVO inVO) {
        return userDao.getAll(inVO);
    }

    public int doUpdate(UserVO inVO) {
        return userDao.doUpdate(inVO);
    }

    public int doUpdatePassword(UserVO inVO) {
        return userDao.doUpdatePassword(inVO);
    }

    public int getCount(UserVO inVO) {
        return userDao.getCount(inVO);
    }

    public int doDelete(UserVO inVO) {
        return userDao.doDelete(inVO);
    }

    public UserVO doSelectOne(UserVO inVO) throws EmptyResultDataAccessException {
        return userDao.doSelectOne(inVO);
    }

    public List<UserVO> doRetrieve(UserVO inVO) {
        return userDao.doRetrieve(inVO);
    }

    public int doSave(UserVO inVO) {
        return userDao.doSave(inVO);
    }

    public int emailDuplicateCheck(UserVO inVO) {
        return userDao.emailDuplicateCheck(inVO);
    }

    public int totalUsers() {
        return userDao.totalUsers();
    }

    public int doPauseUser(UserVO inVO) {
        return userDao.doPauseUser(inVO);
    }

}
