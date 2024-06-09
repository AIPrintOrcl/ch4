package com.fastcampus.ch4.controller;

import com.fastcampus.ch4.domain.BoardDto;
import com.fastcampus.ch4.domain.CommentDto;
import com.fastcampus.ch4.domain.PageHandler;
import com.fastcampus.ch4.domain.SearchCondition;
import com.fastcampus.ch4.service.CommentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class CommentController {

    @Autowired
    CommentService commentService;

    @GetMapping("/comment")
    public String test() {
        return "comment";
    }

    // 댓글을 수정하는 메서드
    @PatchMapping("/comments/{cno}")
    @ResponseBody
    public ResponseEntity<String> modify(@PathVariable Integer cno,@RequestBody CommentDto dto, HttpSession session) {
//        String commenter = (String) session.getAttribute("id");
        String commenter = "asdf";
        dto.setCommenter(commenter);
        dto.setCno(cno);
        System.out.println("dto = " + dto);

        try {
            int rowCnt = commentService.modify(dto);

            if(rowCnt!=1) throw new Exception("Modify Failed");

            return new ResponseEntity<>("MODIFY_OK", HttpStatus.OK);

        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>("MODIFY_ERR", HttpStatus.BAD_REQUEST);
        }
    }

    // 댓글을 등록하는 메서드
    @PostMapping("/write")
    @ResponseBody
    public ResponseEntity<String> write(@RequestBody CommentDto dto, Integer bno, HttpSession session) {
//        String commenter = (String) session.getAttribute("id");
        String commenter = "asdf";
        dto.setCommenter(commenter);
        dto.setBno(bno);
        dto.setPcno(null); // dto pcno 리셋
        System.out.println("dto = " + dto);

        try {
            int rowCnt = commentService.write(dto);
            if(rowCnt != 1) throw new Exception("Write Failed");

            return new ResponseEntity<>("WRITE_OK", HttpStatus.OK);

        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>("WRITE_ERR", HttpStatus.BAD_REQUEST);
        }

    }

    // 댓글을 등록하는 메서드
    @PostMapping("/replyWrite")
    @ResponseBody
    public ResponseEntity<String> replyWrite(@RequestBody CommentDto dto, Integer bno, HttpSession session) {
//        String commenter = (String) session.getAttribute("id");
        String commenter = "asdf";
        dto.setCommenter(commenter);
        dto.setBno(bno);
        
        System.out.println("dto = " + dto);

        try {
            int rowCnt = commentService.write(dto);
            if(rowCnt != 1) throw new Exception("Write Failed");

            return new ResponseEntity<>("WRITE_OK", HttpStatus.OK);

        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>("WRITE_ERR", HttpStatus.BAD_REQUEST);
        }

    }

    // 지정된 댓글을 삭제하는 메서드
    @DeleteMapping("/comments/{cno}") // /comments/1?bno=1085 <-- 삭제할 댓글 번호
    @ResponseBody
    public ResponseEntity<String> remove(@PathVariable Integer cno, Integer bno, HttpSession session) { // @PathVariable : REST의 uri에 포함된 값을 가져온다.
//        String commenter = (String) session.getAttribute("id");
        String commenter = "asdf";

        try {
            int rowCnt = commentService.remove(cno, bno, commenter);

            if(rowCnt !=1) throw new Exception("Delete Failed");

            return new ResponseEntity<>("DEL_OK", HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>("DEL_ERR", HttpStatus.BAD_REQUEST);
        }

    }

    // 지정된 게시물의 모든 댓글을 가져오는 메서드
    @GetMapping("/comments") // /comments?bno=1080 GET
    @ResponseBody
    public ResponseEntity<Map<String, Object>> list(Integer bno, SearchCondition sc) { // ResponseEntity<> : 엔티티+상태코드 포함하여 출력
//        List<CommentDto> list = null;
        Map<String, Object> map = new HashMap<String, Object>();

        System.out.println("sc = " + sc);

        //http://localhost/ch4/board/list => page=null, pageSize=null일 경우
        if(sc.getPage() == null ) sc.setPage(1);
        if(sc.getPageSize()==null) sc.setPageSize(10);

        try {
            int totalCnt = commentService.getCount(bno);
            map.put("totalCnt", totalCnt);

            PageHandler pageHandler = new PageHandler(totalCnt, sc); //페이징 내비게이션

            map.put("ph", pageHandler);

            map.put("page", sc.getPage()); // http://localhost/ch4/board/list?page=3&pageSize=10
            map.put("pageSize", sc.getPageSize());

            List<CommentDto> list = commentService.getList(bno, sc);
            map.put("list", list);

            return new ResponseEntity<Map<String, Object>>(map, HttpStatus.OK); // 200
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<Map<String, Object>>(HttpStatus.BAD_REQUEST); // 400
        }

    }
}//class