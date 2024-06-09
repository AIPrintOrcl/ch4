package com.fastcampus.ch4.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.fastcampus.ch4.domain.BoardDto;
import com.fastcampus.ch4.domain.PageHandler;
import com.fastcampus.ch4.domain.SearchCondition;
import com.fastcampus.ch4.service.BoardService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.HashMap;
import java.util.List;
import java.util.Map;



@Controller
@RequestMapping("/board")
public class BoardController {

    @Autowired
    BoardService boardService;

    //게시물 수정
    @PostMapping("/modify")
    public String modify(Integer page, Integer pageSize, BoardDto boardDto, Model m, HttpSession session, RedirectAttributes rattr) {
        boardDto.setWriter((String) session.getAttribute("id"));

        try {

            int rowCnt = boardService.modify(boardDto);

            if(rowCnt != 1) {
                throw new Exception("Modify fail");
            }
            rattr.addFlashAttribute("msg", "MODIFY_OK");
        } catch (Exception e) {
            e.printStackTrace();
            m.addAttribute("boardDto", boardDto);
            rattr.addFlashAttribute("msg", "MODIFY_ERR");
            return "board";
        }

//        m.addAttribute("page", page);
//        m.addAttribute("pageSize", pageSize);

        return "redirect:/board/list?page="+page+"&pageSize="+pageSize;
    }

    //게시물 등록
    @PostMapping("/write")
    public String write(BoardDto boardDto, HttpSession session, Model m, RedirectAttributes rattr) {
        boardDto.setWriter((String)session.getAttribute("id"));

        try {
            int rowCnt = boardService.write(boardDto);

            if(rowCnt != 1) {
                throw new Exception("write error");
            }
            rattr.addFlashAttribute("msg", "WRITE_OK");
        } catch (Exception e) {
            e.printStackTrace();

            m.addAttribute("boardDto", boardDto); // 입력했던 내용 저장
            rattr.addFlashAttribute("msg", "WRITE_ERR");

            return "board"; // 입력했던 내용을 입력한 상태로 글쓰기 창으로 이동
        }

        return "redirect:/board/list";
    }

    //게시물 쓰기 화면 이동
    @GetMapping("/write")
    public String write(Model m) {
        m.addAttribute("mode", "new"); //board.jsp 읽기/쓰기 구분하기 위함
        return "board"; // 읽기와 쓰기에 사용. 쓰기에 사용할때는 mode=new
    }

    //게시물 삭제
    @PostMapping("/remove")
    public String remove(Integer bno, Integer page, Integer pageSize, Model m, HttpSession session, RedirectAttributes rattr) { // RedirectAttributes : 한번만 사용 가능하도록 세션에 잠깐 저장했다가 한번 사용 후 지워버린다.
        String writer = (String)session.getAttribute("id");
        try {
            //삭제 성공/실패 메세지
            int rowCnt = boardService.remove(bno, writer);

            if(rowCnt!=1) {
               throw new Exception("board remove error");
            }
            rattr.addAttribute("msg", "DEL_OK");
        } catch (Exception e) {
            e.printStackTrace();
            rattr.addFlashAttribute("msg", "DEL_ERR");

        }
        return "redirect:/board/list?page="+page+"&pageSize="+pageSize;
//        m.addAttribute("page", page); //http://localhost/ch4/board/list?page=3&pageSize=10
//        m.addAttribute("pageSize", pageSize);
//        return "redirect:/board/list"; // BoardController{ list() }
    }

    //게시물 읽기
    @GetMapping("/read")
    public String read(Integer bno, Integer page, Integer pageSize, Model m) {
        try {
            BoardDto boardDto = boardService.read(bno);
//            m.addAttribute("boardDto", boardDto); // 아래 문장과 동일
            m.addAttribute(boardDto);
            m.addAttribute("page", page);
            m.addAttribute("pageSize", pageSize);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return "board";
    }

    @GetMapping("/list")
    public String list(SearchCondition sc, Model m, HttpServletRequest request) { // Integer page, pageSize Null 에러X
        if(!loginCheck(request))
            return "redirect:/login/login?toURL="+request.getRequestURL();  // 로그인을 안했으면 로그인 화면으로 이동

        //http://localhost/ch4/board/list => page=null, pageSize=null일 경우
        if(sc.getPage() == null ) sc.setPage(1);
        if(sc.getPageSize()==null) sc.setPageSize(10);

        try {
            int totalCnt = boardService.getSearchResultCnt(sc);
            m.addAttribute("totalCnt", totalCnt);

            PageHandler pageHandler = new PageHandler(totalCnt, sc); //페이징 내비게이션

            List<BoardDto> list = boardService.getSearchResultPage(sc);
            m.addAttribute("list", list);
            m.addAttribute("ph", pageHandler);

            m.addAttribute("page", sc.getPage()); // http://localhost/ch4/board/list?page=3&pageSize=10
            m.addAttribute("pageSize", sc.getPageSize());
        } catch (Exception e) {
            throw new RuntimeException(e);
        }

        return "boardList"; // 로그인을 한 상태이면, 게시판 화면으로 이동
    }

    private boolean loginCheck(HttpServletRequest request) {
        // 1. 세션을 얻어서
        HttpSession session = request.getSession();
        // 2. 세션에 id가 있는지 확인, 있으면 true를 반환
        return session.getAttribute("id")!=null;
    }
}