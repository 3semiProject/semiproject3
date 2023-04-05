<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<script type="text/javascript" src="${pageContext.servletContext.contextPath}/resources/js/jquery-3.6.3.min.js"></script>
<script type="text/javascript">
$(function(){
    var className =""  //변수를 선언한다.
      
     $('.f_q_link').on({    //버튼을

         click: function(){  //클릭했을때 

              className=$(this).parent().next().attr('class').slice(-2); 
              //보여줄 li의 class이름을 뒤에서 두자리(on)를 변수에 담는다.

             if(className=='on'){  //만약 클래스명이 'on'이면

                 $(this).parent().next().removeClass('on'); //class'on' 삭제

                $(this).prev().children().eq(3).children()
                .css({transform:'rotate(0deg)',transition:'all 0.4s',color:'#000'});
                 //화살표 아이콘의 원래 css로 돌리기
             }
             else if(className!='on'){  //만약 클래스명이 'on'이 아니면

                 $(this).parent().next().addClass('on');  //class'on' 추가

                $(this).prev().children().eq(3).children()
               .css({transform:'rotate(180deg)',transition:'all 0.4s',color:'#7070ea'});  
                // 화살표 아이콘 css 수정
             }
              
          }
         
      });
      
  });
</script>
<style type="text/css">

        ul, li{ 
        list-style:none;
        text-align:center;
        padding:0;
        margin:0;
}	
		.clearfix{border : 2px solid silver;
				border-bottom:1px solid silver;
				font-size:14pt;
				}
        .clearfix:after{content: "";display: block;clear: both;}
        .f_question1>ul>li,.f_answer1>ul>li{float: left;}
        .fnq{width: 1000px;line-height:50px;margin:left;}
        .f_question1{position: relative}
        .f_answer1{background: white;display: none;}
        .f_answer1.on{display: block;}
        .f_answer1>ul>li:nth-child(1){width: 10%;text-align: center;}
        .f_answer1>ul>li:nth-child(2){width: 15%;text-align: center;}
        .f_answer1>ul>li:nth-child(3){width: 61%; text-align: center;}
        .f_answer1>ul>li:nth-child(4){width: 7%; text-align: center;}
        .f_answer1>ul>li:nth-child(5){width: 7%; text-align: center;}
        .f_question1>ul>li:nth-child(1){width: 10%;text-align: center;}
        .f_question1>ul>li:nth-child(2){width: 15%;text-align: center;}
        .f_question1>ul>li:nth-child(3){width: 61%; }
        .f_q_link{width: 100%;height: 100%;position:absolute;top: 0;left: 0;}
       #title{
	text-decoration: none;
            width: 200px;
            height: 45px;
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
</head>
<body>
	<c:import url="/WEB-INF/views/common/menubar.jsp" />
	
	<c:import url="/WEB-INF/views/common/csbar.jsp" />
<hr>

<div>

		<ul>
        	<li id="title">FAQ</li>
        	<br>
		<form action="fwform.do" method="post" align="left">
			<div>
				<c:if test="${ loginMember.admin_ck eq 'Y'}">
					<input id="qri" type=submit value="글쓰기">
				</c:if>
			</div>
		</form>
		<br>
       <c:forEach items="${ list }" var="f">
	    <ul class="fnq">
        <li class="f_question1">
            <ul class="clearfix" style="font-weight:bold; background-color:#01CD88;">
                <li>F</li>
                <li>${ f.faq_cat }</li>
                <li>${ f.faq_title }</li>
                <li><i class="fa fa-angle-double-up"></i></li>
            </ul>
            <a href="#" class="f_q_link"></a>
        </li>
        <li class="f_answer1">
            <ul class="clearfix">
                <li>A</li>
                <li>${ f.faq_cat }</li>
                <li>${ f.faq_content }</li>
                <li>
				<c:if test="${ loginMember.admin_ck eq 'Y' }">
					<c:url var="ffup" value="/faqupview.do">
						<c:param name="faq_no" value="${ f.faq_no }" />
					</c:url>
					<a href="${ ffup }">[수정]</a> &nbsp; &nbsp;
				</c:if>
                </li>
                <li>
				<c:if test="${ loginMember.admin_ck eq 'Y' }">
					<c:url var="ffde" value="/faqdel.do">
						<c:param name="faq_no" value="${ f.faq_no }" />
					</c:url>
					<a href="${ ffde }">[삭제]</a> &nbsp; &nbsp;
				</c:if>
                </li>
            </ul>
        </li>
    </ul>
    </c:forEach> 
    </ul>
</div>
	<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>