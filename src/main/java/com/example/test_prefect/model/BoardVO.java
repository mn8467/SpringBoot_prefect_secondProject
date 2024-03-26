package com.example.test_prefect.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor // default 생성자
@AllArgsConstructor // 모든인자 생성자
public class BoardVO extends DTO {
    private int seq;// 순번
    private String divNum;// 게시구분
    private String title;// 제목
    private String contents;// 내용
    private int readCnt;// 조회수
    private String regDt;// 등록일
    private String regId;// 등록자
    private String modDt;// 수정일
    private String modId;// 수정자
    private String uuid;
    private int totalBoard;
    @Override
    public String toString() {
        return "BoardVO [seq=" + seq + ", div=" + divNum + ", title=" + title + ", contents=" + contents + ", readCnt="
                + readCnt + ", regDt=" + regDt + ", regId=" + regId + ", modDt=" + modDt + ", modId=" + modId
                + ", uuid=" + uuid + ", toString()=" + super.toString() + "]";
    }

}
