<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<%@ page session="true"%>
<c:set var="loginId" value="${sessionScope.id}"/>
<c:set var="loginOutLink" value="${loginId=='' ? '/login/login' : '/login/logout'}"/>
<c:set var="loginOut" value="${loginId=='' ? 'Login' : 'ID='+=loginId}"/>
<!DOCTYPE html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <script src="https://code.jquery.com/jquery-1.11.3.js"></script>
    <title>Document</title>
    <style>
        * {
            border : 0;
            padding : 0;
        }

        ul {
            border:  1px solid rgb(235,236,239);
            border-bottom : 0;
        }

        li {
            background-color: #f9f9fa;
            list-style-type: none;
            border-bottom : 1px solid rgb(235,236,239);
            padding : 18px 18px 0 18px;
        }

        #commentList {
            width : 50%;
            margin : auto;
        }

        .comment-content {
            overflow-wrap: break-word;
        }

        .comment-bottom {
            font-size:9pt;
            color : rgb(97,97,97);
            padding: 8px 0 8px 0;
        }

        .comment-bottom > a {
            color : rgb(97,97,97);
            text-decoration: none;
            margin : 0 6px 0 0;
        }

        .comment-area {
            padding : 0 0 0 46px;
        }

        .commenter {
            font-size:12pt;
            font-weight:bold;
        }

        .commenter-writebox {
            padding : 15px 20px 20px 20px;
        }

        .comment-img {
            font-size:36px;
            position: absolute;
        }

        .comment-item {
            position:relative;
        }

        .up_date {
            margin : 0 8px 0 0;
        }

        #comment-writebox {
            background-color: white;
            border : 1px solid #e5e5e5;
            border-radius: 5px;
        }

        textarea {
            display: block;
            width: 100%;
            min-height: 17px;
            padding: 0 20px;
            border: 0;
            outline: 0;
            font-size: 13px;
            resize: none;
            box-sizing: border-box;
            background: transparent;
            overflow-wrap: break-word;
            overflow-x: hidden;
            overflow-y: auto;
        }

        #comment-writebox-bottom {
            padding : 3px 10px 10px 10px;
            min-height : 35px;
        }

        .btn {
            font-size:10pt;
            color : black;
            background-color: #eff0f2;
            text-decoration: none;
            padding : 9px 10px 9px 10px;
            border-radius: 5px;
            float : right;
        }

        #btn-write-comment, #btn-write-reply {
            color : #009f47;
            background-color: #e0f8eb;
        }

        #btn-cancel-reply {
            background-color: #eff0f2;
            margin-right : 10px;
        }

        #btn-write-modify {
            color : #009f47;
            background-color: #e0f8eb;
        }

        #btn-cancel-modify {
            margin-right : 10px;
        }

        #reply-writebox {
            display : none;
            background-color: white;
            border : 1px solid #e5e5e5;
            border-radius: 5px;
            margin : 10px;
        }

        #reply-writebox-bottom {
            padding : 3px 10px 10px 10px;
            min-height : 35px;
        }

        #modify-writebox {
            background-color: white;
            border : 1px solid #e5e5e5;
            border-radius: 5px;
            margin : 10px;
        }

        #modify-writebox-bottom {
            padding : 3px 10px 10px 10px;
            min-height : 35px;
        }

        /* The Modal (background) */
        .modal {
            display: none; /* Hidden by default */
            position: fixed; /* Stay in place */
            z-index: 1; /* Sit on top */
            padding-top: 100px; /* Location of the box */
            left: 0;
            top: 0;
            width: 100%; /* Full width */
            height: 100%; /* Full height */
            overflow: auto; /* Enable scroll if needed */
            background-color: rgb(0,0,0); /* Fallback color */
            background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
        }

        /* Modal Content */
        .modal-content {
            background-color: #fefefe;
            margin: auto;
            padding: 20px;
            border: 1px solid #888;
            width: 50%;
        }

        /* The Close Button */
        .close {
            color: #aaaaaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
        }

        .close:hover,
        .close:focus {
            color: #000;
            text-decoration: none;
            cursor: pointer;
        }



        .paging {
            color: black;
            width: 100%;
            text-align: center;
        }

        .page {
            color: black;
            text-decoration: none;
            padding: 6px;
            margin-right: 10px;
        }

        .paging-active {
            background-color: rgb(216, 216, 216);
            border-radius: 5px;
            color: rgb(24, 24, 24);
        }

        .paging-container {
            width:100%;
            height: 70px;
            margin-top: 50px;
            margin : auto;
        }
    </style>
</head>
<body>
<div id="commentList">
    <div id="commentListList">
        <%-- 댓글 목록 --%>
    </div>
    <div class="paging-container" id="commentListPaging">
        <%--<div class="paging">
            <a class="page" href="#">&lt;</a>

            <c:forEach items="" >
                <a class="page" href="#">1</a>
                <a class="page paging-active" href="#">5</a>
            </c:forEach>
            <a class="page" href="#">&gt;</a>
        </div>--%>
    </div>
    <div id="comment-writebox">
        <div class="commenter commenter-writebox">${id}</div>
        <div class="comment-writebox-content">
            <textarea name="" id="" cols="30" rows="3" placeholder="댓글을 남겨보세요"></textarea>
        </div>
        <div id="comment-writebox-bottom">
            <div class="register-box">
                <a href="#" class="btn" id="btn-write-comment">등록</a>
            </div>
        </div>
    </div>
</div>
<div id="reply-writebox">
    <div class="commenter commenter-writebox">${id}</div>
    <div class="reply-writebox-content">
        <textarea name="" id="" cols="30" rows="3" placeholder="댓글을 남겨보세요"></textarea>
    </div>
    <div id="reply-writebox-bottom">
        <div class="register-box">
            <a href="#" class="btn" id="btn-write-reply">등록</a>
            <a href="#" class="btn" id="btn-cancel-reply">취소</a>
        </div>
    </div>
</div>
<div id="modalWin" class="modal">
    <!-- Modal content -->
    <div class="modal-content">
        <span class="close">&times;</span>
        <p>
        <h2> | 댓글 수정</h2>
        <div id="modify-writebox">
            <div class="commenter commenter-writebox"></div>
            <div class="modify-writebox-content">
                <textarea cols="30" rows="5" placeholder="댓글을 남겨보세요"></textarea>
            </div>
            <div id="modify-writebox-bottom">
                <div class="register-box">
                    <a href="#" class="btn" id="btn-write-modify">등록</a>
                </div>
            </div>
        </div>
        </p>
    </div>
</div>
<script>
    let id = 'asdf';

    //댓글 리스트
    let showList = function (bno, page){
        $.ajax({
            type:'GET',       // 요청 메서드
            url: '/ch4/comments?bno='+bno+'&page='+page,  // 요청 URI
            // headers : { "content-type": "application/json"}, // 요청 헤더
            // dataType : 'json', // 전송받을 데이터의 타입
            // data : JSON.stringify(person),  // 서버로 전송할 데이터. stringify()로 직렬화 필요.
            success : function(result){

                $('#commentListList').html(toHtml(result.list));
                $('#commentListPaging').html(toHtmlPaging(result));
            },
            error   : function(){ alert("error") } // 에러가 발생했을 때, 호출될 함수
        }); // $.ajax()
    }

    let toHtml = function (comments) {
        let tmp = "<ul>";

        comments.forEach(function (comment) {
            //댓글
            tmp += '<li class="comment-item" data-cno="'+ comment.cno +'" data-bno="'+ comment.bno +'">'
            if (comment.cno != comment.pcno) { // 답글 구분해주기.
                tmp += '<span>L</span>'
            }
            tmp += '    <span class="comment-img">'
            tmp += '        <i class="fa fa-user-circle" aria-hidden="true"></i>'
            tmp += '    </span>'
            tmp += '<div class="comment-area">'
            tmp += '    <div class="commenter">' + comment.commenter + '</div>'
            tmp += '    <div class="comment-content">' + comment.comment + '</div>'
            tmp += '<div class="comment-bottom">'
            tmp += "    <span class='up_date'>"+ dateformat(comment.up_date) + "</span>"
            tmp += ' <a href="#" class="btn-write" data-cno="'+ comment.cno +'" data-bno="'+ comment.bno +'" data-pcno="'+ comment.pcno +'">답글쓰기</a>'
            tmp += ' <a href="#" class="btn-modify" data-cno="'+ comment.cno +'" data-bno="'+ comment.bno +'" data-pcno="'+ comment.pcno +'">수정</a>'
            tmp += ' <a href="#" class="btn-delete" data-cno="'+ comment.cno +'" data-bno="'+ comment.bno +'" data-pcno="'+ comment.pcno +'">삭제</a>'
            tmp += ' </div>' // comment-bottom
            tmp += ' </div>' // comment-area
            tmp += '</li>'
        })
        return tmp + "</ul>";
    }

    let dateformat = function(datParam) {
        const d = new Date(datParam)
        date = d.toISOString().split('T')[0];
        const time = d.toTimeString().split(' ')[0];
        return date+" "+time;
    }

    let toHtmlPaging = function (map) {
        let pageTmp = "<div className='paging'>";
        if(map.totalCnt==null || map.totalCnt==0) {
            pageTmp += '<div> 게시물이 없습니다. </div>'
        }
        if(map.totalCnt!=null && map.totalCnt!=0) {
            if(map.ph.showPrev) {
                pageTmp += "<a class='page' href='#' onclick='showList(655, "+(map.ph.beginPage-1)+")'>&lt;</a>"
            }

            for (var i=map.ph.beginPage;i<=map.ph.endPage;i++){
                pageTmp += "<a class='page "+ (i==map.ph.sc.page ? 'paging-active' : '' ) +"' href='#' onclick='showList(655, " + i + ")' '>" + i + "</a>"
            }
            if(map.ph.showNext) {
                pageTmp += "<a class='page' href='#' onclick='showList(655, "+(map.ph.endPage+1)+")'>&gt;</a>"
            }
        }
        pageTmp += "</div>"

        return pageTmp;
    }

    let addZero = function (value = 1) {
        return value > 9 ? value : "0" + value;
    }

    let dateToString = function (ms = 0) {
        let date = new Date(ms);

        let yyyy = date.getFullYear();
        let mm = addZero(date.getMonth() + 1);
        let dd = addZero(date.getDate());

        let HH = addZero(date.getHours());
        let MM = addZero(date.getMinutes());
        let ss = addZero(date.getSeconds());

        return yyyy+"."+mm+"."+dd+ " " + HH + ":" + MM + ":" + ss;
    }

    $(document).ready(function(){
        let bno = 655;
        showList(bno, 1);

        // 답글 쓰기
        $("#commentListList").on("click", "a.btn-write", function(e){
            let target = e.target; // target??
            let cno = target.getAttribute("data-cno")
            let bno = target.getAttribute("data-bno")
            let pcno = target.getAttribute("data-pcno")

            let repForm = $("#reply-writebox");

            repForm.appendTo($("li[data-cno="+cno+"]"));
            repForm.css("display", "block");
            repForm.attr("data-pcno", pcno);
            repForm.attr("data-bno",  bno);
        });

        $("#btn-write-comment").click(function(e){
            if(${param.bno eq null || param.bno eq 0}) {
                bno = 655;
            }
            let comment = $(".comment-writebox-content textarea").val();

            if(comment.trim()==''){
                alert("답글을 입력해주세요.");
                $(".comment-writebox-content textarea").focus();
                return;
            }

            $.ajax({
                type:'POST',       // 요청 메서드
                url: '/ch4/write?bno='+bno,  // 요청 URI
                headers : { "content-type": "application/json"}, // 요청 헤더
                data : JSON.stringify({bno:bno, comment:comment}),  // 서버로 전송할 데이터. stringify()로 직렬화 필요.
                success : function(result){
                    alert(result);       // result는 서버가 전송한 데이터
                    showList(bno, 1);
                },
                error   : function(){ alert("error") } // 에러가 발생했을 때, 호출될 함수
            }); // $.ajax()

            //댓글 처리 후 작업
            $(".comment-writebox-content textarea").val("");
        });

        $("#commentListList").on("click", "#btn-write-reply", function(e){
            let pcno = $("#reply-writebox").attr("data-pcno");
            let bno = $("#reply-writebox").attr("data-bno");
            let comment = $(".reply-writebox-content textarea").val();

            if(comment.trim()==''){
                alert("답글을 입력해주세요.");
                $(".reply-writebox-content textarea").focus();
                return;
            }

            $.ajax({
                type:'POST',       // 요청 메서드
                url: '/ch4/replyWrite?bno='+bno,  // 요청 URI
                headers : { "content-type": "application/json"}, // 요청 헤더
                data : JSON.stringify({pcno:pcno, bno:bno, comment:comment}),  // 서버로 전송할 데이터. stringify()로 직렬화 필요.
                success : function(result){
                    alert(result);       // result는 서버가 전송한 데이터
                    showList(bno, 1);
                },
                error   : function(){ alert("error") } // 에러가 발생했을 때, 호출될 함수
            }); // $.ajax()

            //답글 처리 후 작업
            $("#reply-writebox").css("display", "none");
            $(".reply-writebox-content textarea").val("");
            $("#reply-writebox").appendTo("body"); // 원래 있던 곳으로 되돌리기
        });

        // 답글 취소
        $("#btn-cancel-reply").click(function(e){
            $("#reply-writebox").css("display", "none");
        });

        // 댓글 수정
        $("#commentListList").on("click", "a.btn-modify", function(e){
            let target = e.target;
            let cno = target.getAttribute("data-cno");
            let bno = target.getAttribute("data-bno");
            let pcno = target.getAttribute("data-pcno");
            let li = $("li[data-cno="+cno+"]");
            let commenter = $(".commenter", li).first().text();
            let comment = $(".comment-content", li).first().text();

            $("#modalWin .commenter").text(commenter);
            $("#modalWin textarea").text(comment);
            $("#btn-write-modify").attr("data-cno", cno);
            $("#btn-write-modify").attr("data-pcno", pcno);
            $("#btn-write-modify").attr("data-bno", bno);

            // 팝업창을 열고 내용을 보여준다.
            $("#modalWin").css("display","block");
        });

        //댓글 삭제
        $("#commentListList").on("click", "a.btn-delete", function(e){
            let cno = $(this).attr("data-cno");
            let bno = $(this).attr("data-bno");

            $.ajax({
                type:'DELETE',       // 요청 메서드
                url: '/ch4/comments/'+ cno +'?bno='+bno,  // 요청 URI
                // headers : { "content-type": "application/json"}, // 요청 헤더
                // dataType : 'json', // 전송받을 데이터의 타입
                // data : JSON.stringify(person),  // 서버로 전송할 데이터. stringify()로 직렬화 필요.
                success : function(result){
                    alert(result);
                    showList(bno, 1); // 리스트 갱신
                },
                error   : function(){ alert("error") } // 에러가 발생했을 때, 호출될 함수
            }); // $.ajax()
        });

        //댓글 수정 팝업 - 등록 버튼
        $("#btn-write-modify").click(function(){
            // 1. 변경된 내용을 서버로 전송
            let cno = $(this).attr("data-cno");
            let comment = $(".modify-writebox-content textarea").val();

            if(comment.trim()==''){
                alert("댓글을 입력해주세요.");
                $("#modalWin textarea").focus();
                return;
            }

            $.ajax({
                type:'PATCH',       // 요청 메서드
                url: '/ch4/comments/'+cno,  // 요청 URI
                headers : { "content-type": "application/json"}, // 요청 헤더
                data : JSON.stringify({bno:bno, comment:comment}),  // 서버로 전송할 데이터. stringify()로 직렬화 필요.
                success : function(result){
                    alert(result);       // result는 서버가 전송한 데이터
                    showList(bno, 1);
                },
                error   : function(){ alert("error") } // 에러가 발생했을 때, 호출될 함수
            }); // $.ajax()
            // 2. 모달 창을 닫는다.
            $(".close").trigger("click");
        });

        $(".close").click(function(){
            $("#modalWin").css("display","none");
        });
    });
</script>
</body>
</html>
