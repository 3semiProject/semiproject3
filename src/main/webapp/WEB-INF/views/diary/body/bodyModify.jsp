<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>


    <meta charset="UTF-8">
    <title>Diary</title>
    <link rel="stylesheet" type="text/css"
          href="${ pageContext.servletContext.contextPath }/resources/css/vars.css">
    <link rel="stylesheet" type="text/css"
          href="${ pageContext.servletContext.contextPath }/resources/css/diarytab.css">
    <link rel="stylesheet" type="text/css"
          href="${ pageContext.servletContext.contextPath }/resources/css/button_div.css">
    <style type="text/css">
        /* 바디다이어리 출력용 */
        div#diaryPart {
            height: 80%;
            min-height: 100%;
            align-items: center;
            display: flex;
            justify-content: center;
            font-family: Copperplate, Papyrus, fantasy;
        }

        div.button {
            float: center;
        }

        #modifybtn {
            width: 55px;
            height: 30px;
            border: 1px solid #827482;
            background-color: white;
            color: #827482;
            border-radius: 7px;
        }

        div.bodyBox {
            position: relative;
            left: 250px;
            height: 100px;
            text-align: center;
            align-items: center;
            flex-direction: column;
            justify-content: center;
            margin: 0;
            padding: 0;
        }

        div.bodyBox > div {
            display: inline-block;
            width: 100px;
            height: 100px;
            float: left;
            margin-left: 12px;
            border-radius: 18px;
            border: 1px solid #827482;
            font-weight: bold;
            text-align: center;
        }

        div.bodyBox > div > h4 {
            margin: 5px 0px 12px 0px;
        }

        div.bodyBox > div > input {

            width: 40px;
            height: 20px;
            border: 0;
            font-size: 15px;
            border-bottom: 1.2px solid black;
            text-align: center;
        }

        div.bodyBox > div > input:focus {
            outline: none;
        }

        div.imageBox > img {
            width: 750px;
            height: 500px;
        }

        div.memobox > textarea {
            height: 150px;
            border: 1.2px solid black;
            width: 750px;
            font-size: 15px;
            margin: 20px;
            padding: 10px;
        }

    </style>
    <style type="text/css">
        /* bar들 중앙정렬 */
        .vars {
            display: flex;
            flex-direction: column;
            justify-content: center;
        }
    </style>
    <script type="text/javascript"
            src="${ pageContext.servletContext.contextPath }/resources/js/jquery-3.6.3.min.js"></script>
</head>
<body>

<br><c:import url="/WEB-INF/views/common/menubar.jsp"/> <!--메인 메뉴바-->


<div style="width: 1200px; text-align: center;">
    <br><c:import url="/WEB-INF/views/diary/common/diarymenubar.jsp" /><!--다이어리 메뉴바-->
    <br>

    <script type="text/javascript">
        //----- 프로필 이미지 미리보기 관련 function ----------
        //FileReader() 객체는 비동기적으로 파일의 내용을 읽어들이는 데 사용
        const reader = new FileReader();

        function changeImg(input) {

            if (input.files && input.files[0]) {
                reader.onload = e => {
                    //이미지 src변경
                    const previewImage = document.getElementById("showimg_body");
                    previewImage.src = e.target.result;
                    console.log(previewImage.src);
                }
                //이미지 읽기
                reader.readAsDataURL(input.files[0]);
            }

        }
    </script>
    </head>

    <body>
    <div id="bodyPart">
        <form action="diary_updateBodyModify.do" method="post" enctype="multipart/form-data">
            <input name="userid" type="hidden" value="${ diary.user_id }"><br>
            <input name="diaryno" type="hidden" value="${ diary.diary_no }"><br>
            <label> 작성일시 :
                <input name="diary_post_date" type="date" value="${ diary.diary_post_date }"><br>
            </label>
            <div class="bodyBox">
                <div>
                    <h4>BMI</h4>
                    <input name="body_bmi" value="${body.body_bmi}"><br>
                </div>
                <div>
                    <h4>Bmr</h4>
                    <input name="body_bmr" value="${body.body_bmr}"><br>
                </div>
                <div>
                    <h4>체중</h4>
                    <input name="body_weight" value="${body.body_weight}">kg <br>
                </div>
                <div>
                    <h4>체지방량</h4>
                    <input name="body_fat" value="${body.body_fat}">g <br>
                </div>
                <div>
                    <h4>골격근량</h4>
                    <input name="body_muscle" value="${body.body_muscle}">g<br>
                </div>
                <div>
                    <h4>허리둘레</h4>
                    <input name="body_waistline" value="${body.body_waistline}">cm <br>
                </div>
            </div>
            <br>
            <!-- Image Box -->
            <!-- 등록된 사진 출력 -->
            <div class="imageBox">

                <!-- 이미지입력되면 event인식해서 changeImage() function 실행됨 -->

                <c:if test="${ empty diary.diary_image }">
                    <img id="showimg_body"
                         src="${ pageContext.servletContext.contextPath }/resources/images/diary/noimage2.jpg"/>
                </c:if>

                <c:if test="${ !empty diary.diary_image }">
                    <img id="showimg_body"
                         src="${ pageContext.servletContext.contextPath }/resources/diary_upfile/${ diary.diary_image }">
                </c:if>
                <div>
                    <input style="width: 70px;" type="file" name="upfile" onchange="changeImg(this);"/>
                </div>
            </div>
            <!-- 등록된 메모 출력 -->
            <!-- Memo Box -->
            <div class="memobox">

                <textarea name="diary_memo" va>${ diary.diary_memo }</textarea>
            </div>
            <br>
            <!-- 다이어리에 : 시간, 메모, 이미지파일 -->
            <input type="submit" value="저장">
        </form>

        <script type="text/javascript">
            $("form").submit(function (e) {
                //체중이 0이상이어야 전송가능
                var body_weight = $('input[name="body_weight"]').val();
                if (body_weight <= 0) {
                    alert("체중은 필수 입력사항입니다. 작성화면으로 돌아갑니다.");
                    e.preventDefault(); // 기본 동작 방지
                } else {
                    console.log($(this).serialize());
                    alert("성공");
                }

            });
        </script>
        <br>
    </div>
</div>
<c:import url="/WEB-INF/views/common/footer.jsp"/>

</body>
</html>