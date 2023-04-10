<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
	width: 500px;
	height: 300px;
	text-align: center;
	border: 1px solid #D1D1D1;
	border-radius: 35px;
	margin: 0 10px;
	/*    border: 1px solid #D1D1D1;
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

#adminBox #user_visit #visit_count, #adminBox #user_visit #visit_count {
	width: 500px;
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

#login_Box {
	width: 120px;
	height: 300px;
	border: 1px solid #D1D1D1;
	border-radius: 35px;
	margin: auto;
}

#login_Box div {
	align-items: center;
	margin-top: 30px;
}

#login_Box #login_join {
	width: 100px;
	height: 100px;
	margin: 10px;
	line-height: 100px;
	background-color: #01CD88;
}

#login_Box #login_join div {
	margin: 30px 0;
	text-align: center;
	justify-content: center;
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

#userBox_memberBox {
	display: flex;
	border: 1px solid #D1D1D1;
	border-radius: 35px;
	height: 300px;
	justify-content: space-around;
	/*    border: 1px solid #D1D1D1;
   position: relative;
   float: right;
   margin-top: 5px;
   margin-right: 0.5%;
   width: 28%;
   height: 300px;
   background-color: white;
   border-radius: 35px; */
}

#userBox_memberBox>div {
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

#userBox_memberBox div div {
	border: 1px solid #D1D1D1;
}

#userBox_memberBox #calendar_box #calendar {
	height: 250px;
	border-radius: 35px;
}

#userBox_memberBox #myActivity_box div {
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

#todayVisitors, #monthVisitors, #avgVisitors, #postCount,
	#blackPostCount {
	width: 300px;
	font-size: xx-large;
	margin: auto;
	justify-content: center;
	color: black;
}
<!--
input
 
type
 
date의
 
placeholder
 
없애기--
> /* input[type=month]::-webkit-datetime-edit-text { 
  -webkit-appearance: none; 
  display: none; 
} 

input[type=month]::-webkit-datetime-edit-month-field{ 
  -webkit-appearance: none; 
  display: none; 
} 

input[type=month]::-webkit-datetime-edit-day-field {
  -webkit-appearance: none; 
  display: none; 
} 

input[type=month]::-webkit-datetime-edit-year-field { 
  -webkit-appearance: none; 
  display: none; 
} */
</style>
<!-- fullcalendar CDN -->
<script src='https://cdn.jsdelivr.net/npm/@fullcalendar/core@6.1.5/index.global.min.js'></script>
<script src='https://cdn.jsdelivr.net/npm/@fullcalendar/daygrid@6.1.5/index.global.min.js'></script>
<script>
$(function () {
	$.ajax({
        url: 'calendar.do', // Replace with your server URL that returns the JSON object
        type: 'post',
        data : {
           "user_id" : "${loginMember.user_id}"
        },
        dataType: 'json',
        success: function(data) {
           var jsonStr = JSON.stringify(data);
           var json = JSON.parse(jsonStr).list;
           console.log("data : "+ JSON.stringify(json));
           var events = [];
           for (var i in json) {

              events.push({
                 title: json[i].diary_no,
                 start: json[i].diary_post_date
              });
           }
           var calendarEl = document.getElementById('calendar');
           var calendar = new FullCalendar.Calendar(calendarEl, {

               initialView: 'dayGridMonth',
               events: events,
               eventClick: function(info) {
            	   location.href = "diary.do?diary_no=" + events.title;
               }
            });
           calendar.render();
         },

        error: function(jqXHR, err, errorThrown) {
           console.error('Error loading events: '+ JSON.stringify(jqXHR) +"["+ JSON.stringify(err) + "], " + errorThrown);
        }
     });
});
</script>


<script type="text/javascript"
   src="${ pageContext.servletContext.contextPath }/resources/js/jquery-3.6.3.min.js"></script>
<script type="text/javascript">
   function moveLoginPage() {
      //버튼 클릭시, 로그인 페이지로 이동하는 controller 요청
      location.href = "loginPage.do";
   }
   
   function logout() {	
	   location.href ="logout.do";
}
 
	
   //adminBox에서 접속자수, 게시물수 get
   $(function (){

	   
	   if(${"loginMember.admin_ck"} == "Y"){
  setInterval(function() {
		 
  $.ajax({
	  url: "adminBox.do",
	  type: "post",
	  dataType: "json",
	  success: function(jsonData) {
		  console.log("jsonData sending ");
		
		$('#todayVisitors').html(jsonData.visitorsT + ' 명');
		$('#monthVisitors').html(jsonData.visitorsM + ' 명');
		$('#avgVisitors').html(jsonData.visitorsAvg + ' 명');
		$('#postCount').html(jsonData.postCount + ' 개');
		//$('#blackPostCount').html(jsonData.blackPostCount + ' 명');

	},
	error: function(request, status, errorData){
		console.log("error code : " + request.status
				+ "\nMessage : " + request.responseText
				+ "\nError : " + errorData);
	} 
  });//adminBox ajax close;
  
  }, 1000);	//setInterval() close;
	   }
   });//function close;
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
      



      <!-- 로그인 했을 때 : 일반회원인 경우 -->
      <c:if
         test="${ !empty sessionScope.loginMember and loginMember.admin_ck eq 'N' }">
         <div id="userBox_memberBox">
            <div id="calendar_box">
               <div>calendar</div>
               <div id="calendar"></div>
            </div>
            <div id="myActivity_box">
               <div><a href="${ pageContext.servletContext.contextPath }/diary.do">오늘의 다이어리</a></div>
               <div>내가 쓴 게시글 ${ loginMember.user_id } 개</div> <!-- 유저의 게시글 쿼리문 물어보기 -->
               <div>내가 쓴 댓글 ${ loginMember.user_id } 개</div>
            </div>
            <div id="userBox_info">
            <form class="pofile" action="myinfo.do" method="post">
               <input type="hidden" name="user_id" value="${ loginMember.user_id }" />
               <c:if test="${ empty loginMember.profile_renamefile }">
                <input type="image" alt="memberProfile"
                  src="${ pageContext.servletContext.contextPath }/resources/profile_upfiles/profile.jpeg" />
                </c:if>
               <c:if test="${ !empty loginMember.profile_renamefile }">
                <input type="image" alt="memberProfile"
                  src="${ pageContext.servletContext.contextPath }/resources/profile_upfiles/${ loginMember.profile_renamefile }" />
                </c:if>
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
           <form action="visitSearch.do">
               <div>접속자 분류</div>
               <div style="display: flex;">
               <div style="width: 30%;">기간</div>
              	<c:set var="now" value="<%=new java.util.Date()%>" />
				<c:set var="sys"><fmt:formatDate value="${now}" pattern="yyyy" /></c:set>
               <input style="width: 60%; text-align: center;" type="month" value="년 / 월"/>
               </div>
           </form>
               <div id="visit_count">
                  <div id="today">
                     <div>접속자 수</div>
                     <div id="todayVisitors"></div>
                  </div>
                  <div id="month">
                     <div>월 접속자 수</div>
                     <div id="monthVisitors"></div>
                  </div>
                  <div id="year">
                     <div>월 평균 접속자 수</div>
                     <div id="avgVisitors"></div>
                  </div>
               </div>
            </div>
            <div id="border_mgt">
               <div>게시판 분류</div>
               <div id="board_count">
                  <div id="total_post">
                     <div>총 게시물 수</div>
                     <div id="postCount"></div>
                  </div>
                  <div id="total_coment">
                     <div>총 유해게시물 수</div>
                     <div id="blackPostCount"></div>
                  </div>
               </div>
            </div>
            <div id="login_Box" align="center">
            	<div style="padding: 10px 0; height: 40px;">
            	관리자<br>${ loginMember.user_nickname } 님 </div>
              	<div id="login_join" onclick="logout();">
                  <a style="color: white;" 
                  href="${ pageContext.servletContext.contextPath }/logout.do">로그아웃</a>
               </div>
            </div>
         </div>
      
      </c:if>
   </div>
</body>
</html>