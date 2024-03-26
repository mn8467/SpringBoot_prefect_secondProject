package com.example.test_prefect.model;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.UUID;

/**
 *
 * @author user
 *
 */
public class StringUtil {

    public final static long BOTTOM_COUNT =10;//PC화면용

    /**
     *
     * @param maxNum : 총글수
     * @param currentPageNo : 페이지번호
     * @param rowPerPage : 페이지 사이즈 ->10/20/30/50/100
     * @param bottomCount: 10/5
     * @param url        : 서버호출 URL
     * @param scriptName : 자바스크립트 함수명
     * @return
     */
    public static String renderingPager(long maxNum, long currentPageNo, long rowPerPage, long bottomCount, String url, String scriptName ) {
        StringBuilder html=new StringBuilder(3000);

        //<< < 1 2 3...10 > >>
        //<< : 첫 page
        //<  :  bottomCount 만큼 이동 -
        //1,2,3 : 해당페이지 글
        //>  :  bottomCount 만큼 이동 +
        //>> : 마지막 페이지

        //maxNum = 21
        //currentPageNo = 1
        //rowPerPage    = 10
        //bottomCount   = 10

        long maxPageNo   = (maxNum -1)/rowPerPage +1;//3
        long startPageNO = ((currentPageNo -1)/bottomCount) * bottomCount +1  ;//1,11,21,...
        long endPageNo   = ((currentPageNo -1)/bottomCount+1)*bottomCount;   //10,20,30,...

        long nowBlockNo  = ((currentPageNo-1)/bottomCount)+1;//1
        long maxBlockNo  = ((maxNum -1)/bottomCount)+1;//3

        if(currentPageNo > maxPageNo) {
            return "";
        }

        html.append("<ul class=\"pagination\"> \n");
        //<<
        if(nowBlockNo>1 && nowBlockNo <= maxBlockNo) {
            html.append("<li class=\"page-item\"> \n");
            html.append("<a class=\"page-link\" href=\"javascript:"+scriptName+"('"+url+"',1); \"> \n");
            html.append("<span>&laquo;</span>");
            html.append("</a>  \n");
            html.append("</li> \n");
        }

        //< : &lt;
        if(startPageNO > bottomCount) {
            html.append("<li class=\"page-item\"> \n");
            html.append("<a class=\"page-link\" href=\"javascript:"+scriptName+"('"+url+"',"+(startPageNO - bottomCount)+"); \"> \n");
            html.append("<span>&lt;</span>");
            html.append("</a>  \n");
            html.append("</li> \n");
        }

        //1 2 3 ... 10
        long inx  = 0;
        for(inx =startPageNO ;inx<=maxPageNo && inx <=endPageNo;inx++ ) {
            if(inx == currentPageNo) {//현제 페이지 이면 link 없음
                html.append("<li class=\"page-item\"> \n");
                html.append("<a  class=\"page-link active\" href=\"#\"> \n");
                html.append(inx);
                html.append("</a>  \n");
                html.append("</li> \n");
            }else {
                html.append("<li class=\"page-item\"> \n");
                html.append("<a class=\"page-link\" href=\"javascript:"+scriptName+"('"+url+"',"+inx+"); \"> \n");
                html.append(inx);
                html.append("</a>  \n");
                html.append("</li> \n");
            }
        }

        //> : &gt;
        if(maxPageNo>inx) {
            html.append("<li class=\"page-item\"> \n");
            html.append("<a class=\"page-link\" href=\"javascript:"+scriptName+"('"+url+"',"+((nowBlockNo * bottomCount)+1)+"); \"> \n");
            html.append("<span>&gt;</span>");
            html.append("</a>  \n");
            html.append("</li> \n");
        }

        //>>
        if(maxPageNo>inx) {
            html.append("<li class=\"page-item\"> \n");
            html.append("<a class=\"page-link\" href=\"javascript:"+scriptName+"('"+url+"',"+maxPageNo+"); \"> \n");
            html.append("<span>&raquo;</span>");
            html.append("</a>  \n");
            html.append("</li> \n");
        }

        html.append("</ul> \n");

        return html.toString();
    }

    /**
     * 파일에 확장자 구하기
     * @param fileName
     * @return "": 확장자 없음, 그렇치 않으면 확장자 return
     */
    public static String getExt(String fileName) {
        String ext = "";
        String tmpFileName = fileName;
        if(tmpFileName.lastIndexOf(".")>-1) {
            int lastIdx = tmpFileName.lastIndexOf(".");
            ext=tmpFileName.substring(lastIdx+1);
        }
        return ext;
    }


    /**
     * 45byte pk return
     * @return
     */
    public static String getPK() {
        return getCurrentDate("yyyyMMdd")+"_"+getUUID();
    }

    /**
     *
     * @return 36byte 범용 고유 식별자(Universally Unique Identifiers)
     */
    public static String getUUID() {
        UUID uuid=UUID.randomUUID();
        return uuid.toString();
    }
    /**
     * 현재날짜, 시간 패턴
     * @param pattern
     * @return 문자열
     */
    public static String getCurrentDate(String pattern) {
        if(null == pattern || "".equals(pattern)) {
            pattern = "yyyyMMdd";
        }
        return LocalDateTime.now().format(DateTimeFormatter.ofPattern(pattern));
    }

    /**
     * 문자열 치환
     * @param strTarget(원본 문자열)
     * @param strReplace(치환문자열
     * @return String
     */
    public static String nvl(final String strTarget, final String strReplace) {
        if(null == strTarget || "".equals(strTarget)) {
            return strReplace.trim();
        }

        return strTarget.trim();
    }

    /**
     * 문자열이 null인 경우 ""으로 치환
     * @param strTarget
     * @return String
     */
    public static String nvl(final String strTarget) {
        return nvl(strTarget,"");
    }


}
