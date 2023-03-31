<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>마이페이지</title>

    <style>
    	 body {
    		width: 1200px;
    		height: 1200px;
    		
    	}
    	#btn_box {
        	width: 1200px;
       		display: flex;
       		justify-content: center;
			
        }
    	
    	body #btn_box div{
      		left: 350px;
    		width: 100px;
    		
    	}
        table th {
            background: #99ffff;
        }

        table th {
            border: 1px solid black;
        }

        table tr td {
            border: 1px solid black;
        }

        table#tbl {
            border: 2px solid black;

        }

      
    </style>
<script src="${ pageContext.servletContext.contextPath }/resources/js/jquery-3.6.3.min.js"></script>
<script type="text/javascript">

</script>

</head>
<body>
<h1 align="center">회원정보 보기</h1>
<hr>
<div id="btn_box" align="center">
	<div>기본정보</div>
	<div>
	<form action="pwCheckPopUp.do" method="post" name="user_id">
		<input type="hidden" name="user_id" value="${ member.user_id }" />
		<input type="submit" value="수정하기" />
	</form>
	</div>
</div>
<table id="tbl" align="center" width="500" cellspacing="5" cellpadding="0">
    <tr>
        <th width="120">아이디</th>
        <td>${ member.user_id}</td>
    </tr>
    <tr>
        <th width="120">패스워드</th>
        <td hidden="true">${member.user_pw}</td>
    </tr>
    <tr>
        <th width="120">이름</th>
        <td>${member.user_name}</td>
    </tr>
    <tr>
        <th width="120">닉네임</th>
        <td>${member.user_nickname}</td>
    </tr>
    <tr>
        <th width="120">전화번호</th>
        <td>${member.phone}</td>
    </tr>
    <tr>
        <th width="120">생일</th>
        <td>${member.birth}</td>
    </tr>
    <tr>
        <th width="120">성 별</th>

        <c:if test="${member.gender eq 'M'}">
            <td>
                남자
            </td>
        </c:if>

        <c:if test="${member.gender eq 'F'}">
            <td>
                여자
            </td>
        </c:if>
    </tr>
    <tr>
        <th width="120">이메일</th>
        <td>${member.email}</td>
    </tr>


</table>
</body>
</html>
