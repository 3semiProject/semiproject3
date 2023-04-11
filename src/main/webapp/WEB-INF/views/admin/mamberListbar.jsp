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

    #ulTable > li > ul > li:first-child               {width:7%;} /*아이디 열 크기*/
    #ulTable > li > ul > li:first-child +li           {width:7%;} /*이름 열 크기*/
    #ulTable > li > ul > li:first-child +li+li        {width:10%;} /*닉네임 열 크기*/
    #ulTable > li > ul > li:first-child +li+li+li     {width:10%;} /*전화번호 열 크기*/
    #ulTable > li > ul > li:first-child +li+li+li+li  {width:10%;} /*생일 열 크기*/
	#ulTable > li > ul > li:first-child +li+li+li+li+li  {width:21%;} /*이메일 열 크기*/
	#ulTable > li > ul > li:first-child +li+li+li+li+li+li  {width:10%;} /*가입일 열 크기*/
	#ulTable > li > ul > li:first-child +li+li+li+li+li+li+li  {width:7%;} /*성별 열 크기*/
	#ulTable > li > ul > li:first-child +li+li+li+li+li+li+li+li  {width:13%;} /*로그인여부 열 크기*/
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
    <script type="text/javascript" src="${ pageContext.servletContext.contextPath }/resources/js/jquery-3.6.3.min.js"></script>
    <script type="text/javascript">
	$(function(){
		//$('선택자').이벤트함수(function(){ 실행 코드 });
		//$('선택자').on('이벤트종류', function(){ 실행 코드 });
		//작성한 이벤트 실행 코드는 이벤트가 발생될 때 까지 대기상태임
		
		//검색할 항목을 선택하면, 해당 항목에 대한 폼이 보여지게 함
		//보여지고 있는 다른 폼은 다시 안 보이게 함
		$('input[name=item]').on('change', function(){
			//change 이벤트가 발생한 radio 와 연결된 폼만
			//보여지게 하고, 나머지 폼들은 안보이게 처리함
			$('input[name=item]').each(function(index){
				//해당 index번째  radio 가 checked 인지 확인하고
				if($(this).is(':checked')){
					$('form.sform').eq(index).css('display', 'block');
				}else {
					$('form.sform').eq(index).css('display', 'none');
				}
				
			});	//each
		});	//on
		
	}); //document.ready
    </script>
</head>
<body>
<%--관리자 접속시--%>
<c:if test="${sessionScope.loginMember.admin_ck eq 'Y'}" >
<hr>
<br>
<%--검색 항목--%>
<center>
<div id="liSearchOption">
	<form action="membersearch.do?page=1" method="post">
	<div style="display: flex; border: 1px solid #D1D1D1;">
		<div style="width: 30%; border: 1px solid #D1D1D1;">키워드 검색</div>
		<div style="width: 60%;">
			<select name="searchtype">
				<option value="uid">아이디</option>
				<option value="uname">이름</option>
				<option value="unick">닉네임</option>
				<option value="uphone">전화번호</option>
				<option value="uemail">이메일</option>
			</select> <input type="search" name="keyword"> 
			<input type="submit" value="검색">
			</div>
		</div>
	</form>
</div>
<br>
</center>
</c:if>
</body>
</html>