<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
    body{
        line-height:2em;        
        font-family:"맑은 고딕";
}
    ul, li{ 
        list-style:none;
        text-align:center;
        padding:0;
        margin:0;
}

    #memberWrapper{
        width: 1130px;
        height: 1200px;
    }

    #memberWrapper > ul > li:first-child {
        text-align: center;
        font-size:14pt;
        height:40px;
        vertical-align:middle;
        line-height:30px;
}

    #ulTable {margin-top:10px;}
    

    #ulTable > li:first-child > ul > li {
        background-color:#01CD88;
        font-weight:bold;
        text-align:center;
}

    #ulTable > li > ul {
        clear:both;
        padding:0px auto;
        position:relative;
        min-width:40px;
}
    #ulTable > li > ul > li { 
        float:left;
        font-size:10pt;
        border-bottom:1px solid silver;
        vertical-align:baseline;
}    

    #ulTable > li > ul > li:first-child               {width:10%;} /*No 열 크기*/
    #ulTable > li > ul > li:first-child +li           {width:10%;} /*제목 열 크기*/
    #ulTable > li > ul > li:first-child +li+li        {width:10%;} /*첨부파일 열 크기*/
    #ulTable > li > ul > li:first-child +li+li+li     {width:10%;} /*작성일 열 크기*/
    #ulTable > li > ul > li:first-child +li+li+li+li  {width:10%;} /*작성자 열 크기*/
	#ulTable > li > ul > li:first-child +li+li+li+li+li  {width:15%;} /*조회수 열 크기*/
	#ulTable > li > ul > li:first-child +li+li+li+li+li+li  {width:10%;} /*조회수 열 크기*/
	#ulTable > li > ul > li:first-child +li+li+li+li+li+li+li  {width:7%;} /*조회수 열 크기*/
	#ulTable > li > ul > li:first-child +li+li+li+li+li+li+li+li  {width:13%;} /*조회수 열 크기*/
    #divPaging {
          clear:both; 
        margin:0 auto; 
        width:300px; 
        height:50px;
}

    #divPaging > div {
        float:left;
        width: 30px;
        margin:0 auto;
        text-align:center;
}

    #liSearchOption {clear:both;}
    #liSearchOption > div {
        margin:0 auto; 
        margin-top: 30px; 
        width:auto; 
        height:100px;

}

    .center {
        text-align : center;
}
	.yy {
		text-decoration: none;
		color: black;
	}
	
	.yy:hover {
		text-decoration: none;
		color: black;
		font-weight: bold;
	}

	
	#title{
	text-decoration: none;
            width: 200px;
            height: 200px;
            display: block;
            background-color: white;
            text-align: center;
            
            color: #01CD88;
            font-weight: bold;
            
            text-shadow: 1px 1px 2px #D1D1D1;
            font-size: 20pt;
            border: 1px solid;
        
	}

</style>
<script type="text/javascript" src="${ pageContext.servletContext.contextPath }/resources/js/jquery-3.6.3.min.js"></script>
<script type="text/javascript">
//로그인 제한/가능 라디오 체크가 변경되었을 때 실행되는 함수임
function changeLogin(element) {
	//선택한 radio의 name 속성의 이름에서 userid 분리 추출함
	var user_id = element.name.substring(9);
	console.log("changeLogin : " + user_id);
	if(element.checked == true && element.value == "N") {
		//로그인 제한을 체크했다면
		console.log("로그인 제한 체크함");
		location.href = "${ pageContext.servletContext.contextPath }/loginok.do?user_id=" + user_id + "&login_ok=N";
	}else{
		console.log("로그인 가능 체크함");
		location.href = "${ pageContext.servletContext.contextPath }/loginok.do?user_id=" + user_id + "&login_ok=Y";
	}
	
}
</script>
</head>
<body>
	<c:import url="/WEB-INF/views/common/menubar.jsp" />
	<hr>
<center>
            <li id='liSearchOption'>
            	<form action="qnasearch.do?page=1" method="post">
                <div>
                    <select name="searchtype" >
                        <option value="qname">제목</option>
                        <option value="qcontent">내용</option>
                        <option value="qid">작성자</option>                        
                    </select>
                    <input type="search" name="keyword">
                    <input type="submit" value="검색">
                </div>
                </form>
             </li>
</center>
<hr>
<div id="memberWrapper">

        <ul>
            <!-- 게시판 제목 -->
            <li id="title">회원정보</li>

            <!-- 게시판 목록  -->
            <li>
                <ul id ="ulTable">
                    <li>
                        <ul>
                            <li>아이디</li>
                            <li class="center">이름</li>
                            <li>닉네임</li>
                            <li>전화번호</li>
                            <li>생일</li>
                            <li>이메일</li>
                            <li>가입일</li>
                            <li>성별</li>
                            <li>로그인 여부</li>
                        </ul>
                    </li>
                    <!-- 게시물이 출력될 영역 -->
                <c:forEach items="${ list }" var="m">
                	<li>
                		<ul>
                			<li>${ m.user_id }</li>
                            <li class="center">${ m.user_name } </li>
                            <li>${m.user_nickname}</li>
                            <li>${m.phone}</li>
                            <li>${m.birth}</li>
                            <li>${m.email}</li>
                            <li class="center">${m.join_date}</li>
                            <li class="center">${m.gender}</li>
                            <li class="center">
                            	<c:if test="${ m.login_ok eq 'Y' }">
									<input type="radio" name="login_ok_${ m.user_id }" value="Y" checked onchange="changeLogin(this);"> 가능 &nbsp;
									<input type="radio" name="login_ok_${ m.user_id }" value="N"  onchange="changeLogin(this);"> 제한
								</c:if>
								<c:if test="${ m.login_ok eq 'N' }">
									<input type="radio" name="login_ok_${ m.user_id }" value="Y"  onchange="changeLogin(this);"> 가능 &nbsp;
									<input type="radio" name="login_ok_${ m.user_id }" value="N" checked onchange="changeLogin(this);"> 제한
								</c:if>
                            </li>
                		</ul>
                	</li>
                </c:forEach>                       
                </ul>
            </li>
            <br>
             &nbsp; &nbsp; <c:import url="/WEB-INF/views/admin/membersearchpaging.jsp" />                

	
	
	
	
</body>
</html>