package com.example.test_prefect.util;


import org.springframework.dao.EmptyResultDataAccessException;

import java.util.List;

/**
 * 모든 DAO 인터페이스는 WorkDiv를 상속받으세요.
 * @author user
 * @param <T>
 */
public interface WorkDiv<T> {
    /**
     * 수정
     * @param inVO
     * @return 1(성공)/0(실패)
     */
    int doUpdate(T inVO) ;

    /**
     * 삭제
     * @param inVO
     * @return 1(성공)/0(실패)
     */
    int doDelete(T inVO) ;

    /**
     * 단건 조회
     * @param inVO
     * @return T
     * @throws EmptyResultDataAccessException
     */
    T doSelectOne(T inVO) throws EmptyResultDataAccessException;

    /**
     * 저장
     * @param inVO
     * @return 1(성공)/0(실패)
     */
    int doSave(T inVO) ;

    /**
     * 목록조회
     * @param inVO
     * @return List<T>
     */
    List<T> doRetrieve(T inVO) ;
}

