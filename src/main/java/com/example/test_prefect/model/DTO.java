package com.example.test_prefect.model;

import lombok.Data;

@Data
public class DTO {
    private long no;      //글번호
    private long totalCnt;//총글수
    private long pageSize;//페이지 사이즈:10,20,30,50,100
    private long pageNo;  //페이지 번호:1,2,3...
    private long replyCnt;


    private String searchDiv;//검색구분
    private String searchWord;//검색어

    public DTO() {}



    public String getSearchDiv() {
        return searchDiv;
    }



    public void setSearchDiv(String searchDiv) {
        this.searchDiv = searchDiv;
    }



    public String getSearchWord() {
        return searchWord;
    }



    public void setSearchWord(String searchWord) {
        this.searchWord = searchWord;
    }



    public long getNo() {
        return no;
    }

    public long getPageSize() {
        return pageSize;
    }

    public void setPageSize(long pageSize) {
        this.pageSize = pageSize;
    }

    public long getPageNo() {
        return pageNo;
    }

    public void setPageNo(long pageNo) {
        this.pageNo = pageNo;
    }

    public void setNo(long no) {
        this.no = no;
    }

    public long getTotalCnt() {
        return totalCnt;
    }

    public void setTotalCnt(long totalCnt) {
        this.totalCnt = totalCnt;
    }

    public long getreplyCnt() {
        return replyCnt;
    }

    public void setreplyCnt(long replyCnt) {
        this.replyCnt = replyCnt;
    }



    @Override
    public String toString() {
        return "DTO [no=" + no + ", totalCnt=" + totalCnt + ", pageSize=" + pageSize + ", pageNo=" + pageNo
                + ", replyCnt=" + replyCnt + ", searchDiv=" + searchDiv + ", searchWord=" + searchWord + "]";
    }

}
