package com.example.test_prefect.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import com.example.test_prefect.model.chart.ScoreVO;
import com.example.test_prefect.service.ChartService;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class MyPageChartController {
	final Logger LOG = LogManager.getLogger(getClass());

	@Autowired
	ChartService chartService;
	
	@RequestMapping(value="user/aaa.do", method = RequestMethod.POST,produces = "application/json;charset=UTF-8")
	@ResponseBody// HTTP 요청 부분의 body부분이 그대로 브라우저에 전달된다.
	public Map<String, Object> mpChart(ScoreVO scoreVO, Model model, HttpSession httpsession) throws Exception {
		//Map으로 보내서 Json으로 받는다
		
		String email = (String) httpsession.getAttribute("email"); //세션에서 email 받아오기
		model.addAttribute("email",email);
		LOG.debug("email :"+ email);
	
		Map<String, Object> resultMap = new HashMap<>();
		
		List<ScoreVO> resultList = chartService.getWorkChartInfo(scoreVO);	
		resultMap.put("resultList", resultList);
		
		
		return resultMap;
		
	}

}
