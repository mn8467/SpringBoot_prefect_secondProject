package com.example.test_prefect.service;

import com.example.test_prefect.mapper.SearchDao;
import com.example.test_prefect.model.UserVO;
import com.example.test_prefect.util.PcwkLogger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class SearchService implements PcwkLogger {

    @Autowired
    SearchDao searchEmailDao;

    public int nameCheck(UserVO inVO) {
        int count = 0;
        count = searchEmailDao.nameCheck(inVO);
        return count;
    }

    public int nameTelCheck(UserVO inVO) {
        int count = 0;

        count = searchEmailDao.nameTelCheck(inVO);
        return count;
    }

    public int emailCheck(UserVO inVO) {
        int count = 0;
        count = searchEmailDao.emailCheck(inVO);
        return count;
    }

    public int searchEmailCheck(UserVO inVO) {
        //10:ID 없음
        //20:비번이상
        //30:로그인
        int checkStatus = 0;

        //이름 Check
        int status = searchEmailDao.nameCheck(inVO);

        if(status==0) {
            checkStatus = 10;
            LOG.debug("10 nameCheck checkStatus:"+checkStatus);
            return checkStatus;
        }

        //아름,전화번호 Check
        status = searchEmailDao.nameTelCheck(inVO);
        if(status==0) {
            checkStatus = 20;
            LOG.debug("20 nameTelCheck checkStatus:"+checkStatus);
            return checkStatus;
        }

        checkStatus = 30;//id/비번 정상 로그인
        LOG.debug("30 idPassCheck pass checkStatus:"+checkStatus);
        return checkStatus;
    }

    public UserVO searchEmail(UserVO inVO) {

        if(null != inVO) { //inVO가 null 이 아니라면
            LOG.debug("결과 \n" + inVO);
        }
        return inVO; //outVO값 반환
    }

    public int emailCheckForPassword(UserVO inVO)  {
        //10:ID 없음
        //20:비번이상
        //30:로그인
        int checkStatus = 0;

        //이름 Check
        int status = searchEmailDao.nameCheck(inVO);

        if(status==0) {
            checkStatus = 10;
            LOG.debug("10 nameCheck checkStatus:"+checkStatus);
            return checkStatus;
        }

        //아름,전화번호 Check
        status = searchEmailDao.emailCheck(inVO);
        if(status==0) {
            checkStatus = 20;
            LOG.debug("20 emailCheck checkStatus:"+checkStatus);
            return checkStatus;
        }

        checkStatus = 30;//id/비번 정상 로그인
        LOG.debug("30 idPassCheck pass checkStatus:"+checkStatus);
        return checkStatus;
    }

}
