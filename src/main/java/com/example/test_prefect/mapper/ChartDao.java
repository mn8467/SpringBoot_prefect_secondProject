package com.example.test_prefect.mapper;

import com.example.test_prefect.model.*;
import com.example.test_prefect.model.chart.AtdVO;
import com.example.test_prefect.model.chart.EduVO;
import com.example.test_prefect.model.chart.RatioVO;
import com.example.test_prefect.model.chart.ScoreVO;
import com.example.test_prefect.util.WorkDiv;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface ChartDao extends WorkDiv<SubjectVO> {
public List<ScoreVO> getWorkChartInfo(ScoreVO scoreVO) ;
public List<EduVO> mainChartInfo(EduVO eduVO);
public List<RatioVO> donutChartInfo(RatioVO ratioVO);
public List<AtdVO> countChartInfo(AtdVO atdVO);
        }

