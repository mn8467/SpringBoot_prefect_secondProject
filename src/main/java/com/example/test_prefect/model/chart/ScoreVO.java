package com.example.test_prefect.model.chart;

import com.example.test_prefect.model.DTO;

import lombok.Data;

@Data
public class ScoreVO extends DTO {
	private String subjectCode;
	private int score;
	private String trainee; // 이름을 조건으로 점수를 가져오기 위함
	private String email;

}
