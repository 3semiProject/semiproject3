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

    #bannerWrapper{
        width: 1130px;
        height: 1200px;
    }

    #bannerWrapper > ul > li:first-child {
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

    #ulTable > li > ul > li:first-child               {width:9%;} /*No 열 크기*/
    #ulTable > li > ul > li:first-child +li           {width:48%;} /*제목 열 크기*/
    #ulTable > li > ul > li:first-child +li+li        {width:17%;} /*작성자 열 크기*/
    #ulTable > li > ul > li:first-child +li+li+li     {width:17%;} /*등록일 열 크기*/
    #ulTable > li > ul > li:first-child +li+li+li+li  {width:9%;} /*배너항목 열 크기*/
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
    <title>유튜브&기사 관리</title>

    <script type="text/javascript"
            src="${ pageContext.servletContext.contextPath }/resources/js/jquery-3.6.3.min.js"></script>
    <script type="text/javascript">
    </script>
</head>
<body>
	<c:import url="/WEB-INF/views/common/menubar.jsp" />
<hr>
<div id="bannerWrapper">

        <ul>
            <!-- 게시판 제목 -->
            <li id="title">유튜브&기사 관리</li>

            <!-- 게시판 목록  -->
            <li>
                <ul id ="ulTable">
                    <li>
                        <ul>
                        	<li>No</li>
                            <li>제목</li>
                            <li class="center">작성자</li>
                            <li>등록일</li>
                            <li>배너항목</li>
                        </ul>
                    </li>
                    <!-- 게시물이 출력될 영역 -->
                <c:forEach items="${ list }" var="ba">
                	<li>
                		<ul>
                			<li>${ ba.banner_no }</li>
                			<c:url var="badt" value="/badetail.do?page=1">
								<c:param name="banner_no" value="${ ba.banner_no }" />
								<c:param name="page" value="${ currentPage }" />
							</c:url>
                            <li class="center">
                            <c:if test="${ !empty sessionScope.loginMember }">
								<a class="yy" href="${ badt }">${ ba.banner_title }</a>
							</c:if>
							<c:if test="${ empty sessionScope.loginMember }">
								${ ba.banner_title }
							</c:if>
                            </li>
                            <li>${ ba.user_id }</li>
                            <li>${ ba.banner_post_date }</li>
                            <li>${ ba.banner_item }</li>
                		</ul>
                	</li>
                </c:forEach>                       
                </ul>
            </li>
            <c:if test="${sessionScope.loginMember.admin_ck eq 'Y'}">
             	<form action="bawform.do" method="post">
            		<div align="left">
            			<c:if test="${ !empty sessionScope.loginMember }">
             				<input id="bari" type=submit value="글쓰기">
             			</c:if>
            		</div>
            	</form>
            </c:if>
             	
            
<%--검색 항목--%>
<center>
            <li id='liSearchOption'>
            	<form action="basearch.do?page=1" method="post">
                <div>
                    <select name="searchtype" >
                        <option value="baname">제목</option>
                        <option value="baid">작성자</option>                        
                    </select>
                    <input type="search" name="keyword">
                    <input type="submit" value="검색">
                </div>
                </form>
             </li>

        </ul>
	<c:import url="/WEB-INF/views/banner/bannerpaging.jsp" />
   </div>
   <br>
</center>
<hr>
	<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>
