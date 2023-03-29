<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>DAMUNITY</title>
<script type="text/javascript"
	src="${ pageContext.servletContext.contextPath }/resources/js/jquery-3.6.3.min.js"></script>
<script type="text/javascript">
    
    var page = 1;
	
    $(function(){
        var values = $('#qna').html();
        console.log("values : " + values);
        $.ajax({
           url: "qnalist.do",
           type: "post",
           data: {page:page} ,
           dataType: "json",
           success: function(data){
              console.log("success : " + data);
              
              var jsonStr = JSON.stringify(data);
              var json = JSON.parse(jsonStr);
              
              for(var i in json.list){
					values += "<tr><td>" + json.list[i].qna_no
					+ "</td><td><a href='qdetail.do?qna_no="
					+ json.list[i].qna_no + "'>" 
					+ decodeURIComponent(json.list[i].qna_title).replace(/\+/gi, " ")
					+ "</a></td><td>" + json.list[i].user_id
					+ "</td><td>" + json.list[i].qna_views
					+ "</td><td>" + json.list[i].qna_post_date
					+ "</td></tr>";
              }
              $('#qna').html(values);
           },
           error : function(jqXHR, textStatus, errorThrown){
              console.log("qnalist.do error : " + jqXHR
                   + ", " + textStatus + ", "
                   + errorThrown);
           }
        });
         
     });
    </script>
</head>
<body>

	<c:import url="/WEB-INF/views/common/menubar.jsp" />

	<c:import url="/WEB-INF/views/common/csbar.jsp" />
	<hr>
	<section>
		<div
			style="float: left; border: 1px solid navy; padding: 5px; margin: 0;">
			<h1>Q n A</h1>
			<table id="qna" border="1" cellspacing="0">
				<tr>
					<th>번호</th>
					<th>제목</th>
					<th>작성자</th>
					<th>조회수</th>
					<th>날짜</th>
				</tr>
			</table>
		</div>
	</section>
	<hr>
	<div>
		<c:import url="/WEB-INF/views/qna_faq/faqListView.jsp"></c:import>
	</div>
	<c:import url="/WEB-INF/views/common/footer.jsp" />

</body>
</html>
