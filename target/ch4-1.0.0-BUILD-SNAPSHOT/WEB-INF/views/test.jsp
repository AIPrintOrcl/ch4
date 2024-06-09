<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <script src="https://code.jquery.com/jquery-1.11.3.js"></script>
</head>
<body>
<h2>commentTest :</h2>
comment : <input type="text" name="comment"><br>
<button id="sendBtn" type="button">SEND</button>
<button id="modBtn" type="button">수정</button>

<div id="commentList"></div>
<div id="replyForm" style="display: none">
    <input type="text" name="replyComment">
    <button id="wrtRepBtn" type="button">등록</button>
</div>

    <script>
        let bno = 655;
        let showList = function (bno){
            $.ajax({
                type:'GET',       // 요청 메서드
                url: '/ch4/write?bno='+bno,  // 요청 URI
                // headers : { "content-type": "application/json"}, // 요청 헤더
                // dataType : 'json', // 전송받을 데이터의 타입
                // data : JSON.stringify(person),  // 서버로 전송할 데이터. stringify()로 직렬화 필요.
                success : function(result){
                    $('#commentList').html(toHtml(result));
                },
                error   : function(){ alert("error") } // 에러가 발생했을 때, 호출될 함수
            }); // $.ajax()
        }

        let toHtml = function (comments) {
            let tmp = "<ul>";

            comments.forEach(function (comment){
                tmp += '<li data-cno='+comment.cno // data-속성명=속성값 => dataset(속성명 : 속성값) 저장됨.
                tmp += ' data-pcno='+comment.pcno
                tmp += ' data-bno='+comment.bno + '>'
                if(comment.cno!=comment.pcno) { // 답글 구분해주기.
                    tmp += 'L'
                }
                tmp += ' commenter=<span class="commenter">' + comment.commenter + '</span>'
                tmp += ' comment=<span class="comment">' + comment.comment + '</span>'
                tmp += ' up_date=' + comment.up_date
                tmp += '<button class="delBtn" >삭제</button>'
                tmp += '<button class="modBtn" >수정</button>'
                tmp += '<button class="replyBtn" >답글</button>'
                tmp += '</li>'
            })

            return tmp + "</ul>";
        }

        $(document).ready(function(){
            showList(bno);

            // SEND 버튼 - 댓글 작성
            $("#sendBtn").click(function(){
                let comment = $("input[name=comment]").val();

                if(comment.trim()==''){
                    alert("댓글을 입력해주세요.");
                    $("input[name=comment]").focus();
                    return;
                }

                $.ajax({
                    type:'POST',       // 요청 메서드
                    url: '/ch4/comments?bno='+bno,  // 요청 URI
                    headers : { "content-type": "application/json"}, // 요청 헤더
                    data : JSON.stringify({bno:bno, comment:comment}),  // 서버로 전송할 데이터. stringify()로 직렬화 필요.
                    success : function(result){
                        alert(result);       // result는 서버가 전송한 데이터
                        showList(bno);
                    },
                    error   : function(){ alert("error") } // 에러가 발생했을 때, 호출될 함수
                }); // $.ajax()
            });

            // 수정 버튼 - 댓글 수정
            $("#modBtn").click(function(){
                let cno = $(this).attr("data-cno");
                let comment = $("input[name=comment]").val();

                if(comment.trim()==''){
                    alert("댓글을 입력해주세요.");
                    $("input[name=comment]").focus();
                    return;
                }

                $.ajax({
                    type:'PATCH',       // 요청 메서드
                    url: '/ch4/comments/'+cno,  // 요청 URI
                    headers : { "content-type": "application/json"}, // 요청 헤더
                    data : JSON.stringify({bno:bno, comment:comment}),  // 서버로 전송할 데이터. stringify()로 직렬화 필요.
                    success : function(result){
                        alert(result);       // result는 서버가 전송한 데이터
                        showList(bno);
                    },
                    error   : function(){ alert("error") } // 에러가 발생했을 때, 호출될 함수
                }); // $.ajax()
            });

            // 댓글 수정 - 수정할 댓글을 input 태그에 보내기
            $("#commentList").on("click", ".modBtn", function() { // 이벤트를 고정된 요소에 걸어야한다.
                let cno = $(this).parent().attr("data-cno");
                let comment = $("span[class=comment]", $(this).parent()).text();

                // 1. comment의 내용을 input에 뿌려주기
                $("input[name=comment]").val(comment);
                // 2. cno 전달하기
                $("#modBtn").attr("data-cno", cno); // <button id="modBtn" data-con="cno">
            });

            // 댓글 삭제
            // $(".delBtn").click(function(){ // 삭제 버튼이 만들어지기 전에 정의됨..
            $("#commentList").on("click", ".delBtn", function(){ // 이벤트를 고정된 요소에 걸어야한다.
                let cno = $(this).parent().attr("data-cno");
                let bno = $(this).parent().attr("data-bno");

                $.ajax({
                    type:'DELETE',       // 요청 메서드
                    url: '/ch4/comments/'+ cno +'?bno='+bno,  // 요청 URI
                    // headers : { "content-type": "application/json"}, // 요청 헤더
                    // dataType : 'json', // 전송받을 데이터의 타입
                    // data : JSON.stringify(person),  // 서버로 전송할 데이터. stringify()로 직렬화 필요.
                    success : function(result){
                        alert(result);
                        showList(bno); // 리스트 갱신
                    },
                    error   : function(){ alert("error") } // 에러가 발생했을 때, 호출될 함수
                }); // $.ajax()
            });

            // 답글 버튼
            $("#commentList").on("click", ".replyBtn", function() { // 이벤트를 고정된 요소에 걸어야한다.
                // 1. replyForm을 옮기고
                $("#replyForm").appendTo($(this).parent());

                // 2. 답글을 입력할 폼을 보여주고,
                $("#replyForm").css("display", "block");
            });

            // 답글 등록 버튼
            $("#wrtRepBtn").click(function(){
                let bno = $("#replyForm").parent().attr("data-bno");
                let pcno = $("#replyForm").parent().attr("data-pcno");
                let comment = $("input[name=replyComment]").val();

                if(comment.trim()==''){
                    alert("답글을 입력해주세요.");
                    $("input[name=replyComment]").focus();
                    return;
                }

                $.ajax({
                    type:'POST',       // 요청 메서드
                    url: '/ch4/write?bno='+bno,  // 요청 URI
                    headers : { "content-type": "application/json"}, // 요청 헤더
                    data : JSON.stringify({pcno:pcno, bno:bno, comment:comment}),  // 서버로 전송할 데이터. stringify()로 직렬화 필요.
                    success : function(result){
                        alert(result);       // result는 서버가 전송한 데이터
                        showList(bno);
                    },
                    error   : function(){ alert("error") } // 에러가 발생했을 때, 호출될 함수
                }); // $.ajax()

                //답글 처리 후 작업
                $("#replyForm").css("display", "none");
                $("input[name=replyComment]").val("");
                $("#replyForm").appendTo("body"); // 원래 있던 곳으로 되돌리기
            });
        });
    </script>
</body>
</html>
