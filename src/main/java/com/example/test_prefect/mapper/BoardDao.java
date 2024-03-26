package com.example.test_prefect.mapper;

import com.example.test_prefect.model.BoardVO;
import com.example.test_prefect.util.PcwkLogger;
import com.example.test_prefect.util.WorkDiv;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.stereotype.Repository;

import java.util.List;

@Mapper
public interface BoardDao extends WorkDiv<BoardVO>, PcwkLogger {
    int doSave(BoardVO inVO);

    int doUpdate(BoardVO inVO);

    int doDelete(BoardVO inVO);

    BoardVO doSelectOne(BoardVO inVO) throws EmptyResultDataAccessException;

    List<BoardVO> doRetrieve(BoardVO inVO);

    int getBoardSeq();

    int doDeleteAll(BoardVO inVO);

    int updateReadCnt(BoardVO inVO);

    int totalBoard();

    List<BoardVO> totalBoardByReadCnt();
}
