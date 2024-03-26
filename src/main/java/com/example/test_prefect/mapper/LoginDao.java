package com.example.test_prefect.mapper;

import com.example.test_prefect.model.UserVO;
import com.example.test_prefect.util.WorkDiv;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface LoginDao  extends WorkDiv<UserVO> {
    /**
     * id존재 check
     * @param inVO
     * @return 1(id존재)/0(id없음)
     */
    int idCheck(UserVO inVO); //중복확인

    /**
     * id와 비번 check
     * @param inVO
     * @return 1(id/비번 존재)/0(id/비번 없음)
     */
    int idPassCheck(UserVO inVO); //id와 비밀번호 체크

    /**
     * 데이터 베이스 ID비번 체크
     * @param inVO
     * @return
     */
    int loginCheck(UserVO inVO); //로그인시 체크
    /**
     * 단건조회
     * @param inVO
     * @return UserVO

     */
    UserVO doSelectOne(UserVO inVO);

    String login(String email,String password);

    UserVO getUserEmail(String email);

}
