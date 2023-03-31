<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>main</title>
<style type="text/css">
* {
	color: #01CD88;
}

a {
	text-decoration: none;
}

#mainContain {
	width: 1200px;
	height: 300px;
}

#adminBox {
	display: flex;
	border: 1px solid #D1D1D1;
	border-radius: 35px;
}

#adminBox #user_visit, #border_mgt {
	width: 580px;
	height: 300px;
	text-align: center;
	border: 1px solid #D1D1D1;
	border-radius: 35px;
	/* 	border: 1px solid #D1D1D1;
	position: relative;
	float: left;
	margin-top: 5px;
	margin-left: 0.5%;
	width: 50%;
	height: 300px;
	background-color: white;
	border-radius: 35px;
	font-size: 50pt;
	line-height: 300px; */
}

#adminBox div div {
	border: 1px solid #D1D1D1;
	border-radius: 35px;
	align-items: center;
}

#adminBox #user_visit #visit_count {
	width: 550px;
	height: 240px;
}

#adminBox #user_visit #visit_count div {
	display: flex;
	height: 80px;
}

#adminBox #border_mgt #board_count div {
	display: flex;
	height: 80px;
}

#userBox #userBox_intro {
	border: 1px solid #D1D1D1;
	position: relative;
	float: left;
	margin-top: 5px;
	margin-left: 0.5%;
	width: 70%;
	height: 300px;
	background-color: white;
	border-radius: 35px;
	font-size: 50pt;
	line-height: 300px;
}

#userBox #userBox_loginBox {
	border: 1px solid #D1D1D1;
	position: relative;
	float: right;
	margin-top: 5px;
	margin-right: 0.5%;
	width: 28%;
	height: 300px;
	background-color: white;
	border-radius: 35px;
}

#userBox_memberBox{
	display: flex;
	border: 1px solid #D1D1D1;
	border-radius: 35px;
	height: 300px;
	justify-content: space-around;
/* 	border: 1px solid #D1D1D1;
	position: relative;
	float: right;
	margin-top: 5px;
	margin-right: 0.5%;
	width: 28%;
	height: 300px;
	background-color: white;
	border-radius: 35px; */
}
#userBox_memberBox > div {
	border: 1px solid #D1D1D1;
	position: relative;
	float: right;
	margin-top: 5px;
	margin-right: 0.5%;
	width: 28%;
	height: 300px;
	background-color: white;
	border-radius: 35px;
	align-items: center;
	text-align: center;
}

#userBox_memberBox div div{
border: 1px solid #D1D1D1;
}


#userBox_memberBox #calendar_box #calendar {
	height: 250px;
	border-radius: 35px;
}

#userBox_memberBox #myActivity_box div{
	height: 50px;
	width: 80%;
	margin: 30px 30px;
	border-radius: 15px;
}

#userBox_memberBox form input[type="image"] {
	line-height: 100px;
	width: 60%;
	height: 100px;
	margin: 10px;
	border-radius: 20px;
}

#userBox_loginBox #loginbtn {
	border: 1px solid #D1D1D1;
	border-radius: 35px;
	width: 300px;
	margin: 20px 0;
}

#loginbtn img {
	line-height: 100px;
	width: 80%;
	height: 100px;
	margin: 10px;
}
</style>

<script type="text/javascript"
	src="${ pageContext.servletContext.contextPath }/resources/js/jquery-3.6.3.min.js"></script>
<script type="text/javascript">
	function moveLoginPage() {
		//버튼 클릭시, 로그인 페이지로 이동하는 controller 요청
		location.href = "loginPage.do";
	}
</script>
</head>
<body>
	<div id="mainContain">
		<!-- non-login -->
		<c:if test="${ empty sessionScope.loginMember }">
			<%-- intro / login / find / join --%>
			<div id="userBox">
				<div id="userBox_intro">Introduce</div>
				<div id="userBox_loginBox" align="center">
					<div id="loginbtn">
						<img alt="loginbtn" onclick="moveLoginPage()"
							src="${ pageContext.servletContext.contextPath }/resources/images/mainLogo.jpg" />
						<div>Login</div>
					</div>
					<div id="loginA">
						<div id="login_find">
							<a href="${ pageContext.servletContext.contextPath }/findId.do">ID
								찾기</a> <a
								href="${ pageContext.servletContext.contextPath }/findPw.do">PW
								찾기</a>
						</div>
						<div id="login_join">
							<a
								href="${ pageContext.servletContext.contextPath }/enrollPage.do">회원가입</a>
						</div>
					</div>
				</div>
			</div>
		</c:if>

		<!-- -------------------------------------------------------------------------------------------------------------- -->
		>



		<!-- 로그인 했을 때 : 일반회원인 경우 -->
		<c:if
			test="${ !empty sessionScope.loginMember and loginMember.admin_ck eq 'N' }">
			<div id="userBox_memberBox">
				<div id="calendar_box">
					<div>calendar</div>
					<div id="calendar"></div>
				</div>
				<div id="myActivity_box">
					<div><a href="${ pageContext.servletContext.contextPath }/diary_showEatDiary.do">오늘의 다이어리</a></div>
					<div>내가 쓴 게시글 ${ loginMember.user_id } 개</div> <!-- 유저의 게시글 쿼리문 물어보기 -->
					<div>내가 쓴 댓글 ${ loginMember.user_id } 개</div>
				</div>
				<div id="userBox_info">
				<form class="pofile" action="myinfo.do" method="post">
					<input type="hidden" name="user_id"
						value="${ loginMember.user_id }" /> <input type="image"
						alt="memberProfile"
						src="${ pageContext.servletContext.contextPath }/resources/images/profile.jpeg" />
				</form>
				<div id="loginA">
					<div id="user_nickname">${ loginMember.user_nickname }님</div>
					<div id="login_join">
						<a href="${ pageContext.servletContext.contextPath }/logout.do">로그아웃</a>
					</div>
				</div>
				</div>
			</div>

		</c:if>



		<!-- 로그인 했을 때 : 관리자인 경우 -->
		<c:if
			test="${ !empty sessionScope.loginMember and loginMember.admin_ck eq 'Y' }">
			<div id="adminBox">
				<div id="user_visit">
					<div>접속자 분류</div>
					<div id="visit_count">
						<div id="today">
							<div>오늘 접속자 수</div>
							<div></div>
						</div>
						<div id="month">
							<div>월 접속자 수</div>
							<div></div>
						</div>
						<div id="year">
							<div>월 평균 접속자 수</div>
							<div></div>
						</div>
					</div>
				</div>
				<div id="border_mgt">
					<div>게시판 분류</div>
					<div id="board_count">
						<div id="total_post">
							<div>총 게시물 수</div>
							<div></div>
						</div>
						<div id="total_coment">
							<div>총 코멘트 수</div>
							<div></div>
						</div>
					</div>
				</div>
				<div>
					<div id="login_join">
						<a href="${ pageContext.servletContext.contextPath }/logout.do">로그아웃</a>
					</div>
				</div>
			</div>
			<%-- <div id="userBox">
				<div id="userBox_intro">Introduce</div>
				<div id="userBox_loginBox">
					<div id="loginbtn">
						<img alt="loginbtn"
							src="${ pageContext.servletContext.contextPath }/resources/images/button.jpg">
					</div>
					<div id="loginA">
						<div id="login_find">
							<a href="${ pageContext.servletContext.contextPath }/findId.do">ID
								찾기</a> <a
								href="${ pageContext.servletContext.contextPath }/findPw.do">PW
								찾기</a>
						</div>
						<div id="login_join">
							<a href="${ pageContext.servletContext.contextPath }/logout.do">로그아웃</a>
						</div>
					</div>
				</div>
			</div> --%>
		</c:if>


	</div>
</body>
</html>