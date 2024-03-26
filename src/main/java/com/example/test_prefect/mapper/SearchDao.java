package com.example.test_prefect.mapper;

import com.example.test_prefect.model.UserVO;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface SearchDao {
    /**
     * 이름 확인
     * @param inVO
     * @return 1(이름 있음)/0(이름 없음)
     */
    int nameCheck(UserVO inVO) ;

    /**
     * 전화번호 확인
     * @param inVO
     * @return 1(이름,전화번호 있음)/0(이름,전화번호 없음)
     */
    int nameTelCheck(UserVO inVO) ;

    /**
     * 이메일 확인
     * @param inVO
     * @return 1(email 있음)/0(email 없음)
     */
    int emailCheck(UserVO inVO) ;

    /**
     * 데이터 베이스 이름,전화번호 체크
     * @param inVO
     * @return
     */
    int searchEmailCheck(UserVO inVO) ;


    /**
     * 단건조회
     * @param inVO
     * @return UserVO
     */
    UserVO searchEmail(UserVO inVO) ;

    /**
     * 이메일 확인
     * @param inVO
     * @return
     */
    int emailCheckForPassword(UserVO inVO);

}
