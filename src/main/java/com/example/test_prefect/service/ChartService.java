package com.example.test_prefect.service;

import com.example.test_prefect.mapper.ChartDao;
import com.example.test_prefect.model.chart.AtdVO;
import com.example.test_prefect.model.chart.EduVO;
import com.example.test_prefect.model.chart.RatioVO;
import com.example.test_prefect.model.chart.ScoreVO;
import com.example.test_prefect.util.PcwkLogger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ChartService implements PcwkLogger {

    @Autowired
    private ChartDao chartDao;

    public List<ScoreVO> getWorkChartInfo(ScoreVO searchVO){

        List<ScoreVO> scoreList = chartDao.getWorkChartInfo(searchVO);

        return scoreList;
    }

    public List<EduVO> mainChartInfo(EduVO eduVO)  {

        List<EduVO> eduRatio = chartDao.mainChartInfo(eduVO);

        return eduRatio;
    }

    public List<RatioVO> donutChartInfo(RatioVO ratioVO) {

        List<RatioVO> Ratio = chartDao.donutChartInfo(ratioVO);

        return Ratio;
    }

    public List<AtdVO> countChartInfo(AtdVO atdVO) {

        List<AtdVO> attend = chartDao.countChartInfo(atdVO);

        return attend;
    }

}
