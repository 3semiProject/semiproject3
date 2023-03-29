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

    #eyebodyWrapper{
        width: 1130px;
        height: 1200px;
    }

    #eyebodyWrapper > ul > li:first-child {
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
	
	.eyebodya {
		text-decoration: none;
		color: black;
	}
	
	.eyebodya:hover {
		text-decoration: none;
		color: black;
		font-weight: bold;
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
<div id="eyebodyWrapper">

        <ul>
            <!-- 게시판 제목 -->
            <li id="title">EYEBODY 게시판</li>

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
                <c:forEach items="${ list }" var="e">
                	<li>
                		<ul>
                			<li>${ e.eyebody_no }</li>
                			<c:url var="edt" value="/edetail.do">
								<c:param name="eyebody_no" value="${ e.eyebody_no }" />
								<c:param name="page" value="${ currentPage }" />
							</c:url>
                            <li class="left">
                            <c:if test="${ !empty sessionScope.loginMember }">
								<a class="eyebodya" href="${ edt }">${ e.eyebody_name }</a>
							</c:if>
							<c:if test="${ empty sessionScope.loginMember }">
								${ e.eyebody_name }
							</c:if>
                            </li>
                            <li>
                            	<c:if test="${ !empty e.originfile_eyebody }">◎</c:if>
								<c:if test="${ empty e.originfile_eyebody }">Empty</c:if>
                            </li>
                            <li>${e.write_eyebody_date}</li>
                            <li>${e.user_id}</li>
                            <li> &nbsp; &nbsp;${e.click_eyebody_no}&nbsp; &nbsp; </li>
                		</ul>
                	</li>
                </c:forEach>                       
                </ul>
            </li>

            <!-- 검색 폼 영역 -->
            <li id='liSearchOption'>
            	<form action="eyebodysearch.do?page=1" method="post">
                <div>
                    <select name="searchtype" >
                        <option value="ename">제목</option>
                        <option value="evalue">내용</option>
                        <option value="eid">작성자</option>
                    </select>
                    <input type="search" name="keyword">
                    <input type="submit" value="검색">
                </div>
                </form>
             </li>

        </ul>
        <!-- 페이징 처리 -->
		<c:import url="/WEB-INF/views/eyebody/eyebodysearchpaging.jsp" />
    </div>
<br>
<hr>
<c:import url="/WEB-INF/views/common/footer.jsp"/>
</body>
</html>