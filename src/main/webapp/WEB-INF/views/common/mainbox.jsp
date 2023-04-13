<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
            height: 400px;
        }

        #adminBox {
            display: flex;
            border: 1px solid #D1D1D1;
            border-radius: 35px;
        }

        #adminBox #user_visit {
            width: 80%;
            height: 400px;
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
            width: 100%;
            height: 400px;

        }

         #adminBox #user_visit #visit_count {
            position: relative;
            top: 30px;
            border: none;

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
            width: 20%;
            height: 400px;
            border: 1px solid #D1D1D1;
            border-radius: 30px;
            margin: 0;
        }

        #login_Box > div {
            align-items: center;
            margin-top: 30px;
            background-color: #fcfaa7;
          /*   background-color: white; */
        }


        #login_Box #login_join {
            width: 150px;
            height: 150px;
            line-height: 150px;
            background-color: #01CD88;
        }

        #login_Box #login_join > div {
            margin: 30px 0;
            text-align: center;
            justify-content: center;
        }

        #userBox #userBox_intro {
            border: 1px solid #D1D1D1;
            position: relative;
            float: left;
            margin-left: 0.5%;
            width: 70%;
            height: 400px;
            background-color: white;
            border-radius: 35px;
            font-size: 50pt;
            line-height: 300px;
        }

        #userBox #userBox_loginBox {
            border: 1px solid #D1D1D1;
            position: relative;
            float: right;
            margin-right: 0.5%;
            width: 28%;
            height: 400px;
            background-color: white;
            border-radius: 35px;
        }

        #userBox_memberBox {
            margin: 0;
            display: flex;
            border: 1px solid #D1D1D1;
            border-radius: 35px;
            height: 400px;
            justify-content: space-around;


        }

        #userBox_memberBox > div {
            border: 1px solid #D1D1D1;
            position: relative;
            float: right;
            margin-right: 0.5%;
            width: 25%;
            height: 400px;
            background-color: white;
            border-radius: 35px;
            align-items: center;
            text-align: center;
        }

        #userBox_memberBox > div > div {
            border: 1px solid #D1D1D1;
        }


        #userBox_memberBox #calendar_box #calendar {
            position: relative;
            width: 450px;
            height: 380px;
            margin: 0;
            padding: 0;
            border-radius: 35px;
            left: 10px;
        }

        #myActivity_box {
            position: relative;
            left: 80px;
            color: white;
        }

        #myActivity_box > div > a {
            color: white;
        }


        #myActivity_box div {
            background: #01CD88;
            color: white;
        }

        #userBox_memberBox #myActivity_box div {
            line-height: 50px;
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
            text-align: center;
        }

        #today > div:first-child, #month > div:first-child, #year > div:first-child, #total_post > div:first-child,
        #total_coment > div:first-child {
            width: 35%;
            text-align: center;
            justify-content: center;
            font-size: x-large;
            color: white;
            background: rgba(64, 217, 166, 0.8);
        }

        #today > div:last-child, #month > div:last-child, #year > div:last-child, #total_post > div:last-child,
        #total_coment > div:last-child {
            width: 60%;
        }

        .term {
            display: flex;
            width: 100%;
        }

        .term > div {
            display: flex;
            width: 50%;
        }

        .term > div > div, .term > div > input {
            margin: auto;
        }

        .term > div > div:first-child {
            width: 95%;
        }

        #calendar div {
        }

        div.fc-daygrid-day-top {
            font-size: 8pt;
        }

        div.fc-scrollgrid-sync-inner {
            font-size: 12pt;
        }

        div.fc-event-title-container {
            height: 15px;
        }

        :root {
            --fc-border-color: rgb(69, 149, 63);
            --fc-daygrid-event-dot-width: 5px;
            --fc-neutral-bg-color: rgba(255, 215, 185, 0.3);
            --fc-button-bg-color: #98c9fa;
            --fc-button-hover-bg-color: #259aff;
            --fc-button-active-bg-color: #0087ff;
            --fc-button-text-color: #FFFFFF;
            --fc-event-bg-color: #d1e5ef;
            --fc-event-border-color: none;
        }

    </style>
    <!-- fullcalendar CDN -->
    <script src='https://cdn.jsdelivr.net/npm/@fullcalendar/core@6.1.5/index.global.min.js'></script>
    <script src='https://cdn.jsdelivr.net/npm/@fullcalendar/daygrid@6.1.5/index.global.min.js'></script>
    <script>
        $(function () {

            $.ajax({
                url: 'calendar.do', // Replace with your server URL that returns the JSON object
                type: 'post',
                data: {
                    "user_id": "${loginMember.user_id}"
                },
                dataType: 'json',
                success: function (data) {
                    var jsonStr = JSON.stringify(data);
                    var json = JSON.parse(jsonStr).list;
                    console.log("data : " + JSON.stringify(json));
                    var events = [];
                    for (var i in json) {

                        events.push({
                            title: json[i].diary_category,
                            start: json[i].diary_post_date,
                            diary_no: json[i].diary_no
                        });
                    }
                    var calendarEl = document.getElementById('calendar');
                    var calendar = new FullCalendar.Calendar(calendarEl, {
                        height: 400,
                        contentHeight: 400,
                        aspectRatio: 30,
                        locale: 'ko',
                        ihandleWindowResize: true,
                        initialView: 'dayGridMonth',
                        events: events,
                        eventClick: function (info) {
                            location.href = "diary.do?diary_no=" + events.diary_no;
                        },
                        headerToolbar: {
                            left: '',
                            center: 'title',
                        },
                        titleFormat:
                            {
                                titleFormat: {
                                    year: 'numeric',
                                    month: 'long',
                                    day: 'numeric',
                                    timeZoneName: 'short'
                                }
                            },
                    });
                    calendar.render();


                },

                error: function (jqXHR, err, errorThrown) {
                    console.error('Error loading events: ' + JSON.stringify(jqXHR) + "[" + JSON.stringify(err) + "], " + errorThrown);
                }
            });


            $('div.fc-event-title.fc-sticky').each(function (index, item) {

                if ($(this).text() == '운동') {
                    $(this).parent().css("background", "red");
                }

            })// foreach


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
            location.href = "logout.do";
        }


        //adminBox에서 접속자수, 게시물수 get
        $(function () {
            if ("${loginMember.admin_ck}" === 'Y') {
                setInterval(function () {

                    $.ajax({
                        url: "adminBox.do",
                        type: "post",
                        dataType: "json",
                        success: function (jsonData) {
                            console.log("jsonData sending ");

                            $('#todayVisitors').html(jsonData.visitorsT + ' 명');
                            $('#monthVisitors').html(jsonData.visitorsM + ' 명');
                            $('#avgVisitors').html(jsonData.visitorsAvg + ' 명');
                            $('#postCount').html(jsonData.postCount + ' 개');
                            //$('#blackPostCount').html(jsonData.blackPostCount + ' 명');

                        },
                        error: function (request, status, errorData) {
                            console.log("error code : " + request.status
                                + "\nMessage : " + request.responseText
                                + "\nError : " + errorData);
                        }
                    });//adminBox ajax close;

                }, 1000);	//setInterval() close;

            }//관리자일때만
        });//function close;


        //-------------------------------------------------------

        //myActivity_box에서 user 게시글, user reple 갯수 get
        $(function () {

            if ("${sessionScope.loginMember}" !== "" && "${loginMember.admin_ck}" === 'N') {

                $.ajax({
                    url: "myActivity_box.do",
                    type: "post",
                    dataType: "json",
                    success: function (jsonData) {
                      //  alert("jsonData sending ");

                        $('#myPost').html('내가 쓴 게시글 ' + jsonData.postCount + ' 개');
                        $('#myReply').html('내가 쓴 댓글 ' + jsonData.replyCount + ' 개');


                    },
                    error: function (request, status, errorData) {
                        console.log("error code : " + request.status
                            + "\nMessage : " + request.responseText
                            + "\nError : " + errorData);
                    }
                });//adminBox ajax close;

            }//if close => user


        });//function close;
    </script>
</head>
<body>
<div id="mainContain">
    <!-- non-login -->
    <c:if test="${ empty sessionScope.loginMember }">
        <%-- intro / login / find / join --%>
        <div id="userBox">
            <div id="userBox_intro">
                <iframe width="840px" height="400px" src="https://www.youtube.com/embed/H0PtMz_tydA?autoplay=1&mute=1"
                        title="YouTube video player" frameborder="0"
                        allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
                        allowfullscreen></iframe>
            </div>
            <div id="userBox_loginBox" align="center">
                <div id="loginbtn">
                    <img alt="loginbtn" onclick="moveLoginPage()"
                         src="${ pageContext.servletContext.contextPath }/resources/images/mainLogo.jpg"/>
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
                        <a href="${ pageContext.servletContext.contextPath }/enrollPage.do">회원가입</a>
                    </div>

                </div>
            </div>
        </div>
    </c:if>

    <!-- -------------------------------------------------------------------------------------------------------------- -->


    <!-- 로그인 했을 때 : 일반회원인 경우 -->
    <c:if test="${ !empty sessionScope.loginMember and loginMember.admin_ck eq 'N' }">
        <div id="userBox_memberBox" style="border: none">
            <div id="calendar_box" style="border: none;">
                <div id="calendar" style="font-size: 6pt;text-align: center; border: none;"></div>
            </div>
            <div id="myActivity_box" style="border: none; ">
                <div><a href="${ pageContext.servletContext.contextPath }/diary.do">오늘의 다이어리</a></div>
                <div id="myPost">${ postCount }</div> <!-- 유저의 게시글 쿼리문 물어보기 -->
                <div id="myReply">${ replyCount }</div>
            </div>
            <div id="userBox_info">
                <form class="pofile" action="myinfo.do" method="post">
                    <input type="hidden" name="user_id" value="${ loginMember.user_id }"/>
                    <c:if test="${ empty loginMember.profile_renamefile }">
                        <input type="image" alt="memberProfile"
                               src="${ pageContext.servletContext.contextPath }/resources/profile_upfiles/profile.jpeg"
                               style="width: 150px; height: 150px"/>
                    </c:if>
                    <c:if test="${ !empty loginMember.profile_renamefile }">
                        <input type="image" alt="memberProfile"
                               src="${ pageContext.servletContext.contextPath }/resources/profile_upfiles/${ loginMember.profile_renamefile }"
                               style="width: 200px; height: 200px"/>
                    </c:if>
                </form>
                <div id="user_nickname" style="border: none">${ loginMember.user_nickname } 님</div>
                <br><br><br><br>
                <div id="login_join" style="border: none">

                    <a href="${ pageContext.servletContext.contextPath }/logout.do" style="height: 40px;
            padding: 10px 16px;
            background: #f3f3f4;
            color: #0d0c22;
            border-radius: 8px;
            text-align: center;
            font-size: 14px;
            font-weight: 500;
            line-height: 20px;
            box-sizing: border-box;">로그아웃</a>
                </div>
            </div>
        </div>

    </c:if>


    <!-- 로그인 했을 때 : 관리자인 경우 -->
    <c:if
            test="${ !empty sessionScope.loginMember and loginMember.admin_ck eq 'Y' }">
        <div id="adminBox">
            <div id="user_visit">
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
                    <div id="total_post">
                     <div>총 게시물 수</div>
                     <div id="postCount"></div>
                  </div>
               </div>
            </div>
 <!--            <div id="border_mgt">
               <div>게시판 분류</div>
               <div id="board_count">

                  <div id="total_coment">
                     <div>총 유해게시물 수</div>
                     <div id="blackPostCount"></div>
                  </div>
-->

                     <div>
                        음식 데이터 삽입용
                    <div>
                        <form action="insertFoodData.do" method="POST" enctype="multipart/form-data">
                            <input type="file" name="mfile" accept=".xls,.xlsx" style="text-align: center"/>

                            <input type="submit" value="음식 데이터 삽입(xlsx)"
                                   style="   height: 40px;
                                              padding: 10px 16px;
                                             border: none;
                                            background: #f3f3f4;
                                            color: #0d0c22;
                                            border-radius: 8px;
                                            text-align: center;
                                            font-size: 14px;
                                            font-weight: 500;
                                            line-height: 20px;
                                            box-sizing: border-box;">
                        </form>
                        <br>



                        <form action="insertMoveData.do" method="POST" enctype="multipart/form-data">
                            <input type="file" name="mfile" accept=".xls,.xlsx">
                            <input type="submit" value="운동 데이터 삽입(xlsx)" style="
                              height: 40px;
                                padding: 10px 16px;
                                border: none;
                                background: #f3f3f4;
                                color: #0d0c22;
                                border-radius: 8px;
                                text-align: center;
                                font-size: 14px;
                                font-weight: 500;
                                line-height: 20px;
                                box-sizing: border-box;"/>
                        </form>
                    </div>


                </div>
            </div>
            <div id="login_Box" align="center">
                <div style="padding: 10px 0; height: 40px;">
                    관리자<br>${ loginMember.user_nickname } 님
                </div>
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