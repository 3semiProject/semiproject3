<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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

    #nocietWrapper{
        width: 1200px;
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

	#ulTable > li > ul > li:first-child               			  {width:5%;} /*체크박스 열 크기*/
    #ulTable > li > ul > li:first-child +li           			  {width:5%;}  /*No 열 크기*/
    #ulTable > li > ul > li:first-child +li+li        			  {width:35%;} /*제목 열 크기*/
    #ulTable > li > ul > li:first-child +li+li+li    			  {width:10%;} /*첨부파일 열 크기*/
    #ulTable > li > ul > li:first-child +li+li+li+li  			  {width:15%;} /*작성자 열 크기*/
	#ulTable > li > ul > li:first-child +li+li+li+li+li  		  {width:10%;} /*작성일 열 크기*/
	#ulTable > li > ul > li:first-child +li+li+li+li+li+li  	  {width:10%;} /*조회수 열 크기*/
	#ulTable > li > ul > li:first-child +li+li+li+li+li +li+li 	  {width:5%;} /*수정버튼 열 크기*/
	#ulTable > li > ul > li:first-child +li+li+li+li+li+li+li+li  {width:5%;} /*삭제버 열 크기*/
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

    #liSearchOption {
    clear:both;
    }
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
    <script type="text/javascript"
            src="${ pageContext.servletContext.contextPath }/resources/js/jquery-3.6.3.min.js"></script>
    <script type="text/javascript"></script>
</head>
<body>
<%--관리자 접속시--%>
<c:if test="${sessionScope.loginMember.admin_ck eq 'Y'}" >
<hr>
<br>
<%--검색 항목--%>
<center>
<div style="display: flex; border: 1px solid #D1D1D1;">
	<div style="width: 30%; border: 1px solid #D1D1D1;">게시판별 보기</div>
	<div style="width: 60%;">
		<select id="optionLink" name="searchtype" onchange="if(this.value) location.href=(this.value);">
			<option value="black" selected="selected">유해게시글관리</option>
			<option value="adHotlist.do?page=1">HOT</option>
			<option value="adNewlist.do?page=1">NEW</option>
			<option value="commu.do?page=1">FREE</option>
			<option value="tiplist.do?page=1">TIP</option>
			<option value="eyebodylist.do?page=1">EYEBODY</option>
			<option value="bfaflist.do?page=1">BF&AF</option>
			<option value="nlist.do?page=1">공지사항</option>
			<option value="elist.do?page=1">이벤트</option>
			<option value="qnalist.do">FAQ</option>
			<option value="faqlist.do?page=1">QNA</option>
			
		</select>
	</div>
</div>	
<div id="liSearchOption">
	<form action="nsearch.do?page=1" method="post">
	<div style="display: flex; border: 1px solid #D1D1D1;">
		<div style="width: 30%; border: 1px solid #D1D1D1;">키워드 검색</div>
		<div style="width: 60%;">
			<select name="searchtype">
				<option value="nname">제목</option>
				<option value="ncontent">내용</option>
				<option value="nid">작성자</option>
			</select> <input type="search" name="keyword"> <input
				type="submit" value="검색">
		</div>
	</div>
	</form>
</div>
<br>
</center>
</c:if>
</body>
</html>