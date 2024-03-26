package com.example.test_prefect.model.chart;


import com.example.test_prefect.model.DTO;
import lombok.Data;

@Data
public class RatioVO extends DTO {
	private String gender; // 세션에서 받아온 이메일
	private String genderCount;
}
