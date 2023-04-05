<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="listCount" value="${ requestScope.paging.listCount }" />
<c:set var="currentPage" value="${ requestScope.paging.currentPage }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
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

    #hotWrapper{
        width: 1130px;
        height: 1200px;
    }

    #hotWrapper > ul > li:first-child {
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
    #ulTable > li > ul > li:first-child +li           {width:35%;} /*제목 열 크기*/
    #ulTable > li > ul > li:first-child +li+li        {width:10%;} /*첨부파일 열 크기*/
    #ulTable > li > ul > li:first-child +li+li+li     {width:20%;} /*작성일 열 크기*/
    #ulTable > li > ul > li:first-child +li+li+li+li  {width:15%;} /*작성자 열 크기*/
	#ulTable > li > ul > li:first-child +li+li+li+li  {width:10%;} /*조회수 열 크기*/
    #divPaging {
          clear:both; 
        margin:0 auto; 
        width:220px; 
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

    .left {
        text-align : left;
}
	#title{
	text-decoration: none;
            width: 200px;
            height: 200px;
            display: block;
            background-color: white;
            text-align: left;
            
            color: #01CD88;
            font-weight: bold;
            
            text-shadow: 1px 1px 2px #D1D1D1;
            font-size: 20pt;
            border: 1px solid;
        
	}
	
	.hota {
		text-decoration: none;
		color: black;
	}
	
	.hota:hover {
		text-decoration: none;
		color: black;
		font-weight: bold;
	}
	#wri{
		align: center;
	}

</style>
<script type="text/javascript"
            src="${ pageContext.servletContext.contextPath }/resources/js/jquery-3.6.3.min.js"></script>
<script type="text/javascript">
	
</script>
<title></title>
</head>
<body>
<c:import url="/WEB-INF/views/common/menubar.jsp"/>
<c:import url="/WEB-INF/views/common/commubar.jsp"/>
<hr>
<div id="hotWrapper">

        <ul>
            <!-- 게시판 제목 -->
            <li id="title">HOT 게시판</li>

            <!-- 게시판 목록  -->
            <li>
                <ul id ="ulTable">
                    <li>
                        <ul>
                            <li>No</li>
                            <li class="left">제목</li>
                            <li>첨부파일</li>
                            <li>작성일</li>
                            <li>작성자</li>
                            <li>조회수</li>
                        </ul>
                    </li>
                    <!-- 게시물이 출력될 영역 -->
                <c:forEach items="${ list }" var="hh">
                	<li>
                		<ul>
                			<li>${ hh.rnum }</li>
                			<c:url var="hotdt" value="/hotnewdetail.do">
								<c:param name="hotnew_no" value="${ hh.hotnew_no }" />
								<c:param name="hotnew_name" value="${ hh.hotnew_name }" />
								<c:param name="user_id" value="${ hh.user_id }" />
							</c:url>
                            <li class="left">
                            <c:if test="${ !empty sessionScope.loginMember }">
								<a class="hota" href="${ hotdt }">${ hh.hotnew_name }</a>
							</c:if>
							<c:if test="${ empty sessionScope.loginMember }">
								${ hh.hotnew_name }
							</c:if>
                            </li>
                            <li>
                            	<c:if test="${ !empty hh.originfile_hotnew }">◎</c:if>
								<c:if test="${ empty hh.originfile_hotnew }">Empty</c:if>
                            </li>
                            <li>${hh.write_hotnew_date}</li>
                            <li>${hh.user_id}</li>
                            <li> &nbsp; &nbsp;${hh.click_hotnew_no}&nbsp; &nbsp; </li>
                		</ul>
                	</li>
                </c:forEach>                       
                </ul>
            </li>

            <!-- 검색 폼 영역 -->
            <li id='liSearchOption'>
            <form action="commuwrite.do" method="post">
            	<div>
            	<c:if test="${ !empty sessionScope.loginMember and loginMember.admin_ck ne 'Y'}">
             		<input id="wri" type=submit value="글쓰기">
             	</c:if>
            	</div>
            </form>
            	<form action="hotsearch.do" method="post">
                <div>
                    <select name="searchtype" >
                        <option value="hotname">제목</option>
                        <option value="hotvalue">내용</option>
                        <option value="hotid">작성자</option>
                    </select>
                    <input type="search" name="keyword">
                    <input type="submit" value="검색">
                </div>
                </form>
             </li>

        </ul>
        <!-- 페이징 처리 -->
		<c:import url="/WEB-INF/views/hot/hotsearchpaging.jsp" />
    </div>
<br>
<hr>
<c:import url="/WEB-INF/views/common/footer.jsp"/>
</body>
</html>