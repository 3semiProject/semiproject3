<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
            height: 1200px;
        }

        #userBox {
            text-align: center;
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

        #loginbtn img {
            line-height: 100px;
            width: 80%;
            height: 100px;
            margin: 10px;
        }

        #loginA {

        }

        #mainTextBox {
            width: 100%;
            border-radius: 35px;
            height: 800px;
            float: left;
        }


        #mainTextBox_topN {
            position: relative;
            width: 52%;
            margin-left: 0.5%;
            margin-top: 15px;
            background-color: white;
            border-radius: 35px;
            height: 800px;
            float: left;
        }

        #mainTextBox_banner {

            position: relative;
            width: 46%;
            margin-right: 0.5%;
            margin-top: 15px;
            background-color: white;
            border-radius: 35px;
            height: 800px;
            float: right;
        }

        #banner_article {
            position: relative;
            float: left;
            margin: 0;
            width: 49.5%;
            height: 800px;
            border: 1px blue solid;
            background-color: white;
        }


        #banner_youtube {
            position: relative;
            margin: 0;
            float: right;
            width: 49.5%;
            height: 800px;
            border: 1px blue solid;
            background-color: white;
        }

        div[name="article"]{
            align-self: center;
            text-align: center;
            width: 80%;
            height: 22%;
            margin: 0 auto;
            margin-top: 4%;
            border: 1px solid black;
            border-radius: 35px;
        }

        div[name="youtube"]{
            align-self: center;
            text-align: center;
            width: 80%;
            height: 22%;
            margin: 0 auto;
            margin-top: 4%;
            border: 1px solid black;
            border-radius: 35px;
        }
        
        #tab1 h1{
        	color: #01CD88;
            font-weight: bold;
            text-shadow: 1px 1px 2px #D1D1D1;
        }
    </style>

    <script type="text/javascript"
            src="${ pageContext.servletContext.contextPath }/resources/js/jquery-3.6.3.min.js"></script>
    <script type="text/javascript">
        function moveLoginPage() {
            //버튼 클릭시, 로그인 페이지로 이동하는 controller 요청
            location.href = "loginPage.do";
        }
            
            
        $(function(){
           var values = $('#new_topN').html();
           console.log("values : " + values);
           $.ajax({
              url: "ftop5.do",
              type: "post",
              dataType: "json",
              success: function(data){
                 console.log("success : " + data);
                 
                 var jsonStr = JSON.stringify(data);
                 var json = JSON.parse(jsonStr);
                 
                 for(var i in json.list){
                    values +=  "</td><td><a href=''>" 
                  + decodeURIComponent(
                        json.list[i].free_name).replace(/\+/gi, " ")
                  + "</a></td><td>" + json.list[i].user_id
                  + "</td><td>" + json.list[i].write_free_date
                  + "</td></tr>";
                 }
                 $('#new_topN').html(values);
              },
              error : function(jqXHR, textStatus, errorThrown){
                 console.log("ftop5.do error : " + jqXHR
                      + ", " + textStatus + ", "
                      + errorThrown);
              }
           });
            
        }); //document ready
        
        $(function(){
        	var values = $('#hot_topN').html();
        	console.log("values : " + values);
        	$.ajax({
        		url: "hntop5.do",
        		type: "post",
        		dataType: "json",
        		success: function(data){
        			console.log("success : " + data);
        			
        			var jsonStr = JSON.stringify(data);
        			var json = JSON.parse(jsonStr);
        			
        			for(var i in json.list){
        				values +=  "</td><td><a href=''>" 
						+ decodeURIComponent(
								json.list[i].hotnew_name).replace(/\+/gi, " ")
						+ "</a></td><td>" + json.list[i].user_id
						+ "</td><td>" + json.list[i].write_hotnew_date
						+ "</td></tr>";
        			}
        			$('#hot_topN').html(values);
        		},
        		error : function(jqXHR, textStatus, errorThrown){
        			console.log("ftop5.do error : " + jqXHR
    						+ ", " + textStatus + ", "
    						+ errorThrown);
        		}
        	});
            
        }); //document ready
    </script>
</head>
<body>
<div id="mainContain">
    <!-- non-login -->
    <c:if test="${ empty sessionScope.loginMember }">
        <%-- intro / login / find / join --%>

        <div id="userBox">
            <div id="userBox_intro">Introduce</div>
            <div id="userBox_loginBox">
                <div id="loginbtn"><img alt="loginbtn" onclick="moveLoginPage()"
                                        src="${ pageContext.servletContext.contextPath }/resources/images/mainLogo.jpg">
                </div>
                <div id="loginA">
                    <div id="login_find">
                        <a href="${ pageContext.servletContext.contextPath }/findId.do">ID 찾기</a>
                        <a href="${ pageContext.servletContext.contextPath }/findPw.do">PW 찾기</a>
                    </div>
                    <div id="login_join">
                        <a href="${ pageContext.servletContext.contextPath }/enrollPage.do">회원가입</a>
                    </div>
                </div>
            </div>
        </div>
       </c:if>
   <!-- 로그인 했을 때 : 일반회원인 경우 -->
   <c:if test="${ !empty sessionScope.loginMember and loginMember.admin_ck ne 'Y' }">
        <div id="userBox">
            <div id="userBox_intro">Introduce</div>
            <div id="userBox_loginBox">
                <div id="loginbtn"><img alt="loginbtn" onclick="moveLoginPage()"
                                        src="${ pageContext.servletContext.contextPath }/resources/images/mainLogo.jpg">
                </div>
                <div id="loginA">
                    <div id="login_find">
                        <a href="${ pageContext.servletContext.contextPath }/findId.do">ID 찾기</a>
                        <a href="${ pageContext.servletContext.contextPath }/findPw.do">PW 찾기</a>
                    </div>
                    <div id="login_join">
                        <a href="${ pageContext.servletContext.contextPath }/logout.do">로그아웃</a>
                    </div>
                </div>
            </div>
        </div>
   </c:if>
   
   <!-- 로그인 했을 때 : 관리자인 경우 -->
   <c:if test="${ !empty sessionScope.loginMember and loginMember.admin_ck ne 'N' }">
        <div id="userBox">
            <div id="userBox_intro">Introduce</div>
            <div id="userBox_loginBox">
                <div id="loginbtn"><img alt="loginbtn"
                                        src="${ pageContext.servletContext.contextPath }/resources/images/button.jpg">
                </div>
                <div id="loginA">
                    <div id="login_find">
                        <a href="${ pageContext.servletContext.contextPath }/findId.do">ID 찾기</a>
                        <a href="${ pageContext.servletContext.contextPath }/findPw.do">PW 찾기</a>
                    </div>
                    <div id="login_join">
                        <a href="${ pageContext.servletContext.contextPath }/logout.do">로그아웃</a>
                    </div>
                </div>
            </div>
        </div>
   </c:if>

        <hr style="clear:both; border: none">
        <%-- hot/new & article / youtube --%>
        <div id="mainTextBox">
            <div id="mainTextBox_topN">
                <div id="tab1" style="height: 50%; border: 1px solid black;">
                    <h1 style="text-align: center">조회수 TOP 게시글</h1>
                    <table id="hot_topN" align="center" border="1" style="width: 95%;margin-top: 50px;">
                        <tr>
                            <th style="width: 60%">제목</th>
                            <th style="width: 20%">글쓴이</th>
                            <th style="width: 20%">날짜</th>

                        </tr>
                        
                    </table>
                </div>
                <div id="tab1" style="height: 50%; border: 1px solid black;">
                    <h1 style="text-align: center">최신 Free 게시글</h1>
                    <table id="new_topN" align="center" border="1" style="width: 95%;margin-top: 50px;">
                        <tr>
                            <th style="width: 60%">제목</th>
                            <th style="width: 20%">글쓴이</th>
                            <th style="width: 20%">날짜</th>

                        </tr>
                    </table>

                </div>
            </div>


            <div id="mainTextBox_banner">
                <div id="banner_article">

                    <div name="article">article1</div>
                    <div name="article">article2</div>
                    <div name="article">article3</div>
                    <div name="article">article4</div>


                </div>
                <div id="banner_youtube">
                    <div name="youtube">youtube1</div>
                    <div name="youtube">youtube2</div>
                    <div name="youtube">youtube3</div>
                    <div name="youtube">youtube4</div>


                </div>
            </div>
        </div>
</div>


</body>
</html>