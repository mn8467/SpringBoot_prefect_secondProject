package com.example.test_prefect.service;

import com.example.test_prefect.mapper.LoginDao;
import com.example.test_prefect.model.UserVO;
import com.example.test_prefect.util.PcwkLogger;
import com.example.test_prefect.util.ShaUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class LoginService implements PcwkLogger {
    @Autowired
    LoginDao loginDao;

    public UserVO doSelectOne(UserVO inVO) {
        return loginDao.doSelectOne(inVO);
    }

    public int loginCheck(UserVO inVO)  {
        // 10:ID 없음
        // 20:비번이상
        // 30:로그인
        int checkStatus = 0;
        // idCheck
        int status = loginDao.idCheck(inVO);

        if (status == 0) {
            checkStatus = 10;
            LOG.debug("10 idCheck checkStatus:" + checkStatus);
            return checkStatus;
        }													 // 비밀번호 검사		2024/3/4
        UserVO user = loginDao.getUserEmail(inVO.getEmail());                // 입력된 아이디에 대한 정보들 user객체에 저장
        LOG.debug("inVO.getPassword():" + inVO.getPassword()); 	             // View에 입력된 비밀번호 값
        LOG.debug("user.getSalt():" + user.getSalt());                       // 저장된 salt 값
        String hexPw = ShaUtil.hash(inVO.getPassword() + user.getSalt());    // 입력된 비밀번호와 저장되어있던 솔트값을 가져와 ShaUtil에 정의된 hash(String input) 메서드로 해시
        LOG.debug("hexPw :"+ hexPw);
        LOG.debug("user.getPassword():"+user.getPassword());
        if (hexPw.contentEquals(user.getPassword())) {						 // DB에 저장된 해시비밀번호와 입력받은 비밀번호 + 솔트 값을 해시한 것과 같은지 비교
            status = 1;														 // 같으면 status = 1 을 반환
        } else {
            status = 0;
        }
        if (status == 0) {   												 // 1반환이 안되었을때 checkStatus에 20이 대입되어서 password를 확인하라는 메시지가 뜬다
            checkStatus = 20;
            LOG.debug("20 idPassCheck checkStatus:" + checkStatus);
            return checkStatus;
        }
        checkStatus = 30;													 // 위에서 status가 1이 반환되면 if문을 통과하여 checkStatus에 30이 대입되면 정상으로 로그인이 성공된다.
        LOG.debug("30 idPassCheck pass checkStatus:" + checkStatus);
        return checkStatus;
    }

 /*   public String login(String email, String password) {   //이건 만들어 두고 안쓴 것 2024/3/4
        UserVO user = loginDao.getUserEmail(email);
        LOG.debug(password);
        LOG.debug(user.getSalt());
        String hexPw = ShaUtil.hash(password + user.getSalt());
        LOG.debug(user.getPassword());
        LOG.debug(hexPw);
        if (hexPw.equals(user.getPassword())) { //
            return user.getEmail();
        }
        return null;

    }*/
}
