package com.fastcampus.ch4.domain;

import org.springframework.web.util.UriComponentsBuilder;

public class PageHandler {
//    private int page;       // 현재 페이지
//    private int pageSize;   // 한 페이지의 크기
//    private String option;  // 검색 옵션(제목+내용, 글쓴이)
//    private String keyword; // 검색어
    private SearchCondition sc;

    private int totalCnt;   // 총 게시물 갯수
    private int naviSize = 10;   // 페이지 내비게이션의 크기
    private int totalPage;  // 전체 페이지의 갯수
    private int beginPage;  // 내비게이션의 첫번째 페이지
    private int endPage;    // 내비게이션의 마지막 페이지
    private boolean showPrev; // 이전 페이지로 이동하는 링크를 보여줄 것인지의 여부
    private boolean showNext; // 다음 페이지로 이동하는 링크를 보여줄 것인지의 여부

    public PageHandler(int totalCnt, SearchCondition sc) {
        this.totalCnt = totalCnt;
        this.sc = sc;

        doPaging(totalCnt, sc);
    }

    //값을 받아야 하는 것 : 총 게시물 갯수, 한 페이지의 크기, 현재 페이지
    //그 외는 계산
    public void doPaging(int totalCnt, SearchCondition sc) {
        this.totalCnt = totalCnt;

        totalPage = (int)Math.ceil(totalCnt / (double)sc.getPageSize()); // 정수/정수=정수 반올림X. 정수/실수=실수 반올림O
        beginPage = ((sc.getPage()-1)/naviSize) * naviSize + 1;
//        endPage = ( (totalPage - beginPage) < naviSize ? (beginPage + (totalPage - beginPage)) : (beginPage + naviSize - 1) );
        endPage = Math.min(beginPage + naviSize - 1, totalPage);
        showPrev = beginPage != 1;
        showNext = endPage != totalPage;
    }

    void pirnt() {
        System.out.println("page = " + sc.getPage());
        System.out.print(showPrev ? "[PREV] " : ""); // 이전 페이지
        for(int i = beginPage; i <= endPage; i++) { // 네비게이션 목록 (1~10, 11~20)
            System.out.print(i+ " ");
        }//end for
        System.out.println(showNext ? "[NEXT] " : ""); // 다음 페이지
    }


    public boolean isShowNext() {
        return showNext;
    }

    public void setShowNext(boolean showNext) {
        this.showNext = showNext;
    }

    public boolean isShowPrev() {
        return showPrev;
    }

    public void setShowPrev(boolean showPrev) {
        this.showPrev = showPrev;
    }

    public int getEndPage() {
        return endPage;
    }

    public void setEndPage(int endPage) {
        this.endPage = endPage;
    }

    public int getBeginPage() {
        return beginPage;
    }

    public void setBeginPage(int beginPage) {
        this.beginPage = beginPage;
    }

    public int getTotalPage() {
        return totalPage;
    }

    public void setTotalPage(int totalPage) {
        this.totalPage = totalPage;
    }

    public int getNaviSize() {
        return naviSize;
    }

    public void setNaviSize(int naviSize) {
        this.naviSize = naviSize;
    }

    public int getTotalCnt() {
        return totalCnt;
    }

    public void setTotalCnt(int totalCnt) {
        this.totalCnt = totalCnt;
    }

    public SearchCondition getSc() {
        return sc;
    }

    public void setSc(SearchCondition sc) {
        this.sc = sc;
    }

    @Override
    public String toString() {
        return "PageHandler{" +
                "sc=" + sc +
                ", totalCnt=" + totalCnt +
                ", naviSize=" + naviSize +
                ", totalPage=" + totalPage +
                ", beginPage=" + beginPage +
                ", endPage=" + endPage +
                ", showPrev=" + showPrev +
                ", showNext=" + showNext +
                '}';
    }
}//class
