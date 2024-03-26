package com.example.test_prefect.service;

import com.example.test_prefect.mapper.BoardDao;
import com.example.test_prefect.model.BoardVO;
import com.example.test_prefect.util.PcwkLogger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class BoardService implements PcwkLogger {

    @Autowired
    BoardDao dao;

    public int doUpdate(BoardVO inVO){
        return dao.doUpdate(inVO);
    }

    public int doDelete(BoardVO inVO){
        return dao.doDelete(inVO);
    }

    public BoardVO doSelectOne(BoardVO inVO) throws EmptyResultDataAccessException {
        //1. 단건조회
        //2. 조회count증가
        BoardVO outVO = dao.doSelectOne(inVO);

        if(null != outVO) {
            int updateReadCnt = dao.updateReadCnt(inVO);
            LOG.debug("┌───────────────────────────────────┐");
            LOG.debug("│ updateReadCnt                     │"+updateReadCnt);
            LOG.debug("└───────────────────────────────────┘");
        }
        return outVO;
    }

    public int doSave(BoardVO inVO) {
        return dao.doSave(inVO);
    }

    public List<BoardVO> doRetrieve(BoardVO inVO) {
        return dao.doRetrieve(inVO);
    }

    public int getBoardSeq() {
        return dao.getBoardSeq();
    }

    public int totalBoard()  {
        return dao.totalBoard();
    }

    public List<BoardVO> totalBoardByReadCnt() {
        return dao.totalBoardByReadCnt();
    }
}
