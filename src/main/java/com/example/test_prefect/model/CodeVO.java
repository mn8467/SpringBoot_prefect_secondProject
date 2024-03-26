package com.example.test_prefect.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor // default 생성자
@AllArgsConstructor // 모든인자 생성자
public class CodeVO extends DTO {
    private String mstCode;  //마스터 코드
    private String detCode;  //상세코드
    private String mstName;  //마스터 명
    private String detName;  //상세코드명
    private int seq       ;  //순번
    private String useYn  ;  //사용여부
    private String regDt  ;  //등록일
    private String regDd  ;  //등록자
    private String modDt  ;  //수정일
    private String modId  ;  //수정자
}
