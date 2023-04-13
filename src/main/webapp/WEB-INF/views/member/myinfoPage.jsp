<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>마이페이지</title>
    <style>

        .home_a {
            display: block;
            text-decoration: none;
            color: #01CD88;
            border: 1px solid #01CD88;
        }

        body {
            width: 1200px;
            height: 1200px;
        }

        h1 {
            color: #A4A4A4;
            font-weight: 800;
            font-size: 30pt;
        }

        #enroll_form {
            text-align: center;
            font-size: 15pt;
            font-style: inherit;
            color: #5f5f5f;
        }

        #join_box {
            display: flex;
            align-items: center;
            border: 3px solid #D1D1D1;
            width: 600px;
            height: 800px;
            border-radius: 30px;
            display: inline-block;
            margin: 0;
        }

        .join_e {
            border-bottom: 2px solid #D1D1D1;
            height: 100px;
            width: 600px;
            display: flex;
        }

        .join_item {
            line-height: 100px;
            margin: 0;
            height: 100px;
            width: 200px;
            border-right: 2px solid #D1D1D1;
        }

        .join_item2 {
            display: flex;
            padding: 30px;
        }

        .join_item2 > * {

            height: 30px;
            vertical-align: middle;

        }


        #title {
            display: inline-block;
            border-bottom: 3px solid #D1D1D1;
            margin: 50px 0;
            width: 500px;
            padding-bottom: 20px;
            font-size: xx-large;
             
        }

        .api_join_item2 {
            padding: 10px 30px;
        }

        .button_box {
            padding: 0 20px;
            width: 500px;
            font-size: x-large;
            margin-bottom: 20px;
            position: relative;
            left: 300px;

        }

        .button_box_form {
            display: flex;
        }


        .basic {
            display: flex;
            align-items: center;
            justify-content: space-around;
        }

    </style>
    <script
            src="${ pageContext.servletContext.contextPath }/resources/js/jquery-3.6.3.min.js"></script>

    <script type="text/javascript">
        function form_submit() {
            $('#pwCheckPopUp_form').submit();

        }
    </script>
</head>
<body>
<c:import url="/WEB-INF/views/common/menubar.jsp"/>
<hr>
<div style="width: 1200px; text-align: center">
    <div id="enroll_form">
        <h1 align="center" id="title">회원정보 보기</h1>
        <div class="button_box">
            <div id="join_box" align="center" style="height: 200px; width: 200px">
                <div class="join_e" style="height: 200px; width: 200px">
                    <c:if test="${ empty member.profile_renamefile }">
                        <img
                                style="height: 200px; width: 200px; border-radius: 25px; border: 2px solid #D1D1D1;"
                                src="resources/profile_upfiles/profile.jpeg" alt="profile"/>
                    </c:if>
                    <c:if test="${ !empty member.profile_renamefile}">
                        <img
                                style="height: 200px; width: 200px; border-radius: 25px; border: 2px solid #D1D1D1;"
                                src="resources/profile_upfiles/${ member.profile_renamefile }" alt="profile"/>
                    </c:if>
                </div>
            </div>
            <div class="basic">
                <div id="text" style="color: #D96969; ">기본정보</div>
                <div class="button_box_form">
                    <form action="deletePage.do" method="post" name="deleteMember">
                        <input type="hidden" name="user_id" value="${ member.user_id }"/>
                        <input type="submit" value="탈퇴하기" <%-- onclick="memberQuit();" --%> />
                    </form>
                    <button type="button" style="height: 23px; margin-left: 10px;" onclick="form_submit();">수정하기
                    </button>
                </div>
            </div>
        </div>
    </div>
    <form action="pwCheckPopUp.do" method="post" name="updateMember" id="pwCheckPopUp_form">
        <div id="join_box" align="center">
            <div class="join_e">
                <div class="join_item">ID</div>
                <div class="join_item2">
                    <input type="hidden" name="user_id" id="user_id" value="${ member.user_id }"/>
                    <div>${ member.user_id }</div>
                </div>
            </div>
            <div class="join_e">
                <div class="join_item">PW</div>
                <div class="join_item2">
                    <input type="password" name="user_pw" id="user_pw" readonly="readonly">
                </div>
            </div>
            <div class="join_e">
                <div class="join_item">이름</div>
                <div class="join_item2">
                    <div>${ member.user_name }</div>
                </div>
            </div>
            <div class="join_e">
                <div class="join_item">닉네임</div>
                <div class="join_item2">
                    <div>${ member.user_nickname }</div>
                </div>
            </div>
            <div class="join_e">
                <div class="join_item">생년월일</div>
                <div class="join_item2">
                    <div>${ member.birth }</div>
                </div>
            </div>
            <div class="join_e">
                <div class="join_item">성별</div>
                <div class="join_item2">
                    <c:if test="${ member.gender eq 'M' }">
                        <div>남자</div>
                    </c:if>
                    <c:if test="${ member.gender eq 'F' }">
                        <div>여자</div>
                    </c:if>
                </div>
            </div>
            <div class="join_e">
                <div class="join_item">전화번호</div>
                <div class="join_item2 auto_number api">
                    ${member.phone}
                </div>
            </div>
            <div class="join_e">
                <div class="join_item">이메일</div>
                <div class="join_item2 auto_number api">
                    ${member.email}
                </div>
            </div>
        </div>
    </form>
</div>

<c:import url="/WEB-INF/views/common/footer.jsp" />

</body>
</html>
