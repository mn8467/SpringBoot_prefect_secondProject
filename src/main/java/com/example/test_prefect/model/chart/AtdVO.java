package com.example.test_prefect.model.chart;

import com.example.test_prefect.model.DTO;
import lombok.Data;

@Data
public class AtdVO extends DTO {
	private String email;  // 세션에서 받아온 교수 이메일
	private String dateCalId;
	private String cntTrainee;

}
