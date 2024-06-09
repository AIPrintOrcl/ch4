/*
package com.fastcampus.ch4.domain;

import org.junit.Test;

import static org.junit.Assert.*;

public class PageHandlerTest {
    @Test
    public void test() { // 첫 지점
        PageHandler ph = new PageHandler(250, 1);

        ph.pirnt();
        System.out.println("ph = " + ph);
        //page = 1
        //1 2 3 4 5 6 7 8 9 10 [NEXT]
        //ph = PageHandler{totalCnt=250, pageSize=10, naviSize=10, totalPage=25, page=1, beginPage=1, endPage=10, showPrev=false, showNext=true}

        assertTrue(ph.getBeginPage() ==1);
        assertTrue(ph.getEndPage() ==10);
    }

    @Test
    public void test2() { // 중간 지점
        PageHandler ph = new PageHandler(250, 15);

        ph.pirnt();
        System.out.println("ph = " + ph);
        //page = 15
        //[PREV] 11 12 13 14 15 16 17 18 19 20 [NEXT]
        //ph = PageHandler{totalCnt=250, pageSize=10, naviSize=10, totalPage=25, page=15, beginPage=11, endPage=20, showPrev=true, showNext=true}

        assertTrue(ph.getBeginPage() ==11);
        assertTrue(ph.getEndPage() ==20);
    }

    @Test
    public void test3() { // 끝 지점
        PageHandler ph = new PageHandler(255, 25);

        ph.pirnt();
        System.out.println("ph = " + ph);
        //page = 25
        //[PREV] 21 22 23 24 25 26
        //ph = PageHandler{totalCnt=255, pageSize=10, naviSize=10, totalPage=26, page=25, beginPage=21, endPage=26, showPrev=true, showNext=false}

        assertTrue(ph.getBeginPage() ==21);
        assertTrue(ph.getEndPage() ==26);
    }

    @Test
    public void test4() {
        PageHandler ph = new PageHandler(255, 10);

        ph.pirnt();
        System.out.println("ph = " + ph);

        assertTrue(ph.getBeginPage() ==1);
        assertTrue(ph.getEndPage() ==10);
    }

}//class
*/
