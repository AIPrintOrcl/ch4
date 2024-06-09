package com.fastcampus.ch4.domain;

import org.springframework.web.util.UriComponentsBuilder;

public class SearchCondition {

    private String keyword = "";
    private String option = "";
//    private Integer offset = 0;
    private Integer pageSize = 10;
    private Integer page = 1;

    public SearchCondition() {
    }

    public SearchCondition(String keyword, String option, Integer pageSize, Integer page) {
        this.keyword = keyword;
        this.option = option;
        this.pageSize = pageSize;
        this.page = page;
    }

    public String getQueryString(Integer page) {
        // ?page=1&pageSize=10&option=T&keyword="title" 생성
        return UriComponentsBuilder.newInstance()
                .queryParam("page", page)
                .queryParam("pageSize", pageSize)
                .queryParam("option", option)
                .queryParam("keyword", keyword)
                .build().toString();
    }

    public String getQueryString() {
        return getQueryString(page);
    }

    public String getKeyword() {
        return keyword;
    }

    public void setKeyword(String keyword) {
        this.keyword = keyword;
    }

    public String getOption() {
        return option;
    }

    public void setOption(String option) {
        this.option = option;
    }

    public Integer getOffset() { //boardMapper.xml ${offset}에서 getOffset() 값을 가져올 수 있다.
        return (page - 1) * pageSize;
    }

    public Integer getPageSize() {
        return pageSize;
    }

    public void setPageSize(Integer pageSize) {
        this.pageSize = pageSize;
    }

    public Integer getPage() {
        return page;
    }

    public void setPage(Integer page) {
        this.page = page;
    }

    @Override
    public String toString() {
        return "SearchCondition{" +
                "keyword='" + keyword + '\'' +
                ", option='" + option + '\'' +
                ", offset=" + getOffset() +
                ", pageSize=" + pageSize +
                ", page=" + page +
                '}';
    }
}//class
