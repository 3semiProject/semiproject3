<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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

    #nocietWrapper{
        width: 1130px;
        height: 1200px;
    }

    #nocietWrapper > ul > li:first-child {
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
	#ulTable > li > ul > li:first-child +li+li+li+li+li  {width:10%;} /*조회수 열 크기*/
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
    <title>공지사항</title>

    <script type="text/javascript"
            src="${ pageContext.servletContext.contextPath }/resources/js/jquery-3.6.3.min.js"></script>
    <script type="text/javascript">
	function elist() {
		//버튼 클릭시, 로그인 페이지로 이동하는 controller 요청
		location.href = "nlist.do";
	}
    </script>
</head>
<body>
	<c:import url="/WEB-INF/views/common/menubar.jsp" />
	
	<c:import url="/WEB-INF/views/common/csbar.jsp" />
<hr>
<div id="nocietWrapper">

        <ul>
            <!-- 게시판 제목 -->
            <li id="title" onclick="nlist()">공지사항</li>

            <!-- 게시판 목록  -->
            <li>
                <ul id ="ulTable">
                    <li>
                        <ul>
                            <li>No</li>
                            <li class="center">제목</li>
                            <li>첨부파일</li>
                            <li>작성일</li>
                            <li>작성자</li>
                            <li>조회수</li>
                        </ul>
                    </li>
                    <!-- 게시물이 출력될 영역 -->
                <c:forEach items="${ list }" var="n">
                	<li>
                		<ul>
                			<li>${ n.notice_no }</li>
                			<c:url var="ndt" value="/ndetail.do?page=1">
								<c:param name="notice_no" value="${ n.notice_no }" />
								<c:param name="page" value="${ currentPage }" />
							</c:url>
                            <li class="center">
                            <c:if test="${ !empty sessionScope.loginMember }">
								<a class="yy" href="${ ndt }">${ n.notice_title }</a>
							</c:if>
							<c:if test="${ empty sessionScope.loginMember }">
								${ n.notice_title }
							</c:if>
                            </li>
                            <li>
                            	<c:if test="${ !empty n.notice_originfile }">◎</c:if>
								<c:if test="${ empty n.notice_originfile }">Empty</c:if>
                            </li>
                            <li>${n.write_notice_date}</li>
                            <li>${n.user_id}</li>
                            <li class="center"> &nbsp; ${n.notice_views}</li>
                		</ul>
                	</li>
                </c:forEach>                       
                </ul>
            </li>
            <br>
            <c:if test="${sessionScope.loginMember.admin_ck eq 'Y'}">
            	<form action="nmovewrite.do" method="post">
            		<div align="left">
            			<c:if test="${ !empty sessionScope.loginMember }">
             				<input id="nri" type=submit value="글쓰기">
             			</c:if>
            		</div>
            	</form>
            </c:if>
            
<%--검색 항목--%>
<center>
            <li id='liSearchOption'>
            	<form action="nsearch.do?page=1" method="post">
                <div>
                    <select name="searchtype" >
                        <option value="nname">제목</option>
                        <option value="ncontent">내용</option>
                        <option value="nid">작성자</option>                        
                    </select>
                    <input type="search" name="keyword">
                    <input type="submit" value="검색">
                </div>
                </form>
             </li>

        </ul>
	<c:import url="/WEB-INF/views/notice/noticepaging.jsp" />
   </div>
   <br>
</center>
<hr>
	<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>
