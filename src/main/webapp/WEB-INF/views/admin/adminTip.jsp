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
       	width:1200px;
    	height:1200px;
        line-height:2em;        
        font-family:"맑은 고딕";
}
    ul, li{ 
        list-style:none;
        text-align:center;
        padding:0;
        margin:0;
}

    #tipWrapper{
        width: 1200px;
        height: 1200px;
    }

    #tipWrapper > ul > li:first-child {
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

 	#ulTable > li > ul > li:first-child               			  {width:5%;} /*No 열 크기*/
    #ulTable > li > ul > li:first-child +li           			  {width:35%;} /*제목 열 크기*/
    #ulTable > li > ul > li:first-child +li+li        			  {width:15%;} /*첨부파일 열 크기*/
    #ulTable > li > ul > li:first-child +li+li+li    			  {width:15%;} /*작성자 열 크기*/
    #ulTable > li > ul > li:first-child +li+li+li+li  			  {width:10%;} /*작성일 열 크기*/
	#ulTable > li > ul > li:first-child +li+li+li+li+li  		  {width:10%;} /*조회수 열 크기*/
	#ulTable > li > ul > li:first-child +li+li+li+li+li+li  	  {width:10%;} /*삭제*/
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
	
	.tipa {
		text-decoration: none;
		color: black;
	}
	
	.tipa:hover {
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
function delBoard(input) {
	location.href="adAllBoardDelete.do?board_no="+input+"&category=2";
	}
</script>
<title></title>
</head>
<body>
<%--관리자 접속시--%>
<c:if test="${sessionScope.loginMember.admin_ck eq 'Y'}" >
<c:import url="/WEB-INF/views/common/menubar.jsp" />
<hr>
<br>
<%--검색 항목--%>
<center>
<div style="display: flex; border: 1px solid #D1D1D1;">
	<div style="width: 30%; border: 1px solid #D1D1D1;">게시판별 보기</div>
	<div style="width: 60%;">
		<select id="optionLink" name="searchtype" onchange="if(this.value) location.href=(this.value);">
			<option value="adFreelist.do?page=1">FREE</option>
			<option value="adTiplist.do?page=1" selected="selected">TIP</option>
			<option value="adEyelist.do?page=1">EYEBODY</option>
			<option value="adBFlist.do?page=1">BF&AF</option>
			<option value="nlist.do?page=1">공지사항</option>
			<option value="elist.do?page=1">이벤트</option>
			<option value="faqlist.do?page=1">FAQ</option>
			<option value="qnalist.do?page=1">QNA</option>
		</select>
	</div>
</div>	
<div id="liSearchOption">
	<form action="adTipsearch.do?page=1" method="post">
	<div style="display: flex; border: 1px solid #D1D1D1;">
		<div style="width: 30%; border: 1px solid #D1D1D1;">키워드 검색</div>
		<div style="width: 60%;">
			<select name="searchtype">
				<option value="tname">제목</option>
				<option value="tvalue">내용</option>
				<option value="tid">작성자</option>
			</select> <input type="search" name="keyword"> <input
				type="submit" value="검색">
		</div>
	</div>
	</form>
</div>
<br>
</center>
<div id="tipWrapper">

        <ul>
            <!-- 게시판 제목 -->
            <li id="title">TIP 게시판</li>

            <!-- 게시판 목록  -->
            <li>
                <ul id ="ulTable">
                    <li>
                        <ul>
                            <li>No</li>
                            <li class="center">제목</li>
                            <li>첨부파일</li>
                            <li>작성자</li>
                            <li>작성일</li>
                            <li>조회</li>
                            <li>삭제</li>
                        </ul>
                    </li>
                    <!-- 게시물이 출력될 영역 -->
                <c:forEach items="${ list }" var="t">
                	<li>
                		<ul>
                			<li>${ t.tip_no }</li>
                			<c:url var="tdt" value="/adTipdetail.do">
								<c:param name="tip_no" value="${ t.tip_no }" />
								<c:param name="page" value="${ currentPage }" />
								<c:param name="user_id" value="${ sessionScope.loginMember.user_id }" />
							</c:url>
                            <li class="left">
                            <c:if test="${ !empty sessionScope.loginMember }">
								<a class="tipa" href="${ tdt }">${ t.tip_name }</a>
							</c:if>
							<c:if test="${ empty sessionScope.loginMember }">
								${ t.tip_name }
							</c:if>
                            </li>
                            <li>
                            	<c:if test="${ !empty t.originfile_tip }">◎</c:if>
								<c:if test="${ empty t.originfile_tip }">Empty</c:if>
                            </li>
                            <li>${t.user_id}</li>
                            <li>${t.write_tip_date}</li>
                            <li> &nbsp; &nbsp;${t.click_tip_no}&nbsp; &nbsp; </li>
                           <li><button type="button" onclick="delBoard('${ t.tip_no }');">삭제</button></li> 
                            
                		</ul>
                	</li>
                </c:forEach>                       
                </ul>
            </li>
        </ul>
        <br>
        <br>
        <!-- 페이징 처리 -->
		<c:import url="/WEB-INF/views/admin/tippaging.jsp" />
    </div>
<br>
<hr>
<c:import url="/WEB-INF/views/common/footer.jsp"/>
</c:if>
</body>
</html>