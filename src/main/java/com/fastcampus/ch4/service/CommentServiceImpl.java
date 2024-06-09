package com.fastcampus.ch4.service;

import com.fastcampus.ch4.dao.*;
import com.fastcampus.ch4.domain.*;
import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;
import org.springframework.transaction.annotation.*;

import java.util.*;

@Service
public class CommentServiceImpl implements CommentService {
    //필드 주입
    @Autowired
    BoardDao boardDao;
    @Autowired
    CommentDao commentDao;

//    생성자 주입 - 생성자가 하나밖에 없을 때 사용. 생성자를 이용하여 주입
//    @Autowired
//    public CommentServiceImpl(CommentDao commentDao, BoardDao boardDao) {
//        this.commentDao = commentDao;
//        this.boardDao = boardDao;
//    }
//    필드 주입과 생성자 주입 비교
//    필드 주입와 같은 기능을 한다. 되도록이면 생성자 주입을 사용하는 것을 권장.
//    필드 주입 경우 컴파일 때 @Autowired 붙이지 않아 주입되지 않아도 에러X => 에러 잡기 힘듬..
//    생성자 주입을 할 경우 컴파일 때 주입되지 않으면 바로 어떤 객체가 주입되지 않는지 알 수 있다.

    @Override
    public int getCount(Integer bno) throws Exception {
        return commentDao.count(bno);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public int remove(Integer cno, Integer bno, String commenter) throws Exception {
        int rowCnt = boardDao.updateCommentCnt(bno, -1); // board 테이블의 comment_cnt를 감소시키고
        System.out.println("updateCommentCnt - rowCnt = " + rowCnt);
//        throw new Exception("test");
        rowCnt = commentDao.delete(cno, commenter); // comment 테이블의 comment를 삭제한다.
        System.out.println("rowCnt = " + rowCnt);
        return rowCnt;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public int write(CommentDto commentDto) throws Exception {
        boardDao.updateCommentCnt(commentDto.getBno(), 1);
//                throw new Exception("test");
        return commentDao.insert(commentDto);
    }

    @Override
    public List<CommentDto> getList(Integer bno, SearchCondition sc) throws Exception {
//        throw new Exception("test");
        return commentDao.selectAll(bno, sc);
    }

    @Override
    public CommentDto read(Integer cno) throws Exception {
        return commentDao.select(cno);
    }

    @Override
    public int modify(CommentDto commentDto) throws Exception {
        return commentDao.update(commentDto);
    }

    @Override
    public int writeReplyComments(CommentDto dto) {
        return commentDao.insertReply(dto);
    }

}
