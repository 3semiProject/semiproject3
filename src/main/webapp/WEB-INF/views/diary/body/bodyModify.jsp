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

        input[type="number"]::-webkit-outer-spin-button,
        input[type="number"]::-webkit-inner-spin-button {
            -webkit-appearance: none;
            margin: 0;
        }


        input[type=submit], button.delete {
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
            box-sizing: border-box;
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
            src="${ pageContext.servletContext.contextPath }/resources/js/jquery-3.6.3 .min.js"></script>
</head>
<body>

<br><c:import url="/WEB-INF/views/common/menubar.jsp"/> <!--메인 메뉴바-->


<div style="width: 1200px; text-align: center;">
    <br><c:import url="/WEB-INF/views/diary/common/diarymenubar.jsp" /><!--다이어리 메뉴바-->
    <br>


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
                    <input type="number" step=0.01  min=0 required name="body_bmi" value="${body.body_bmi}"><br>
                </div>
                <div>
                    <h4>Bmr</h4>
                    <input type="number" step=0.01  min=0 required name="body_bmr" value="${body.body_bmr}"><br>
                </div>
                <div>
                    <h4>체중</h4>
                    <input type="number" step=0.01  min=0 required name="body_weight" value="${body.body_weight}">kg <br>
                </div>
                <div>
                    <h4>체지방량</h4>
                    <input type="number" step=0.01  min=0 required name="body_fat" value="${body.body_fat}">g <br>
                </div>
                <div>
                    <h4>골격근량</h4>
                    <input type="number" step=0.01  min=0 required name="body_muscle" value="${body.body_muscle}">g<br>
                </div>
                <div>
                    <h4>허리둘레</h4>
                    <input type="number" step=0.01  min=0 required name="body_waistline" value="${body.body_waistline}">cm <br>
                </div>
            </div>
            <br>
            <!-- Image Box -->
            <!-- 등록된 사진 출력 -->
            <div class="imageBox">

                <!-- 이미지입력되면 event인식해서 changeImage() function 실행됨 -->

                <c:if test="${ empty diary.diary_image }">
                    <label> <input style="display: none" type="file" name="upfile" onchange="changeImg(this);">
                        <img id="showimg_body"
                             src="${ pageContext.servletContext.contextPath }/resources/images/diary/noimage2.jpg"/>
                    </label>

                </c:if>

                <c:if test="${ !empty diary.diary_image }">
                    <label> <input style="display: none" type="file" name="upfile" onchange="changeImg(this);">
                        <img id="showimg_body"
                             src="${ pageContext.servletContext.contextPath }/resources/diary_upfile/${ diary.diary_image }">
                    </label>

                </c:if>


            </div>
            <!-- 등록된 메모 출력 -->
            <!-- Memo Box -->
            <div class="memobox">

                <textarea name="diary_memo">${ diary.diary_memo }</textarea>
            </div>
            <br>
            <!-- 다이어리에 : 시간, 메모, 이미지파일 -->
            <input type="submit" value="저장">
        </form>
        <br>
        <button class="delete"
                onclick="location.href='diary_deleteBody.do?user_id=${diary.user_id}&diary_no=${diary.diary_no}'"
                style="background: rgba(139,69,19,0.31)">다이어리 삭제
        </button>
        <script type="text/javascript">
            $("form").submit(function (e) {
                //체중이 0이상이어야 전송가능
                var body_weight = $('input[name="body_weight"]').val();
                if (body_weight <= 0) {
                    alert("체중은 필수 입력사항입니다. 작성화면으로 돌아갑니다.");
                    e.preventDefault(); // 기본 동작 방지
                } else if (body_weight >= 200) {
                    alert("진짜?");
                    e.preventDefault(); // 기본 동작 방지
                }

            });
        </script>
        <br>
    </div>
</div>
<c:import url="/WEB-INF/views/common/footer.jsp"/>


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
</body>
</html>