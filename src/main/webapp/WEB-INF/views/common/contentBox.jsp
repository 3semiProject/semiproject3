<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>main page content box</title>
<style type="text/css">
* {
	color: #01CD88;
}

.cona:hover {
		text-decoration: none;
		font-weight: bolder;
		color: #01CD88;
	}
#mainTextBox {
	width: 1200px;
	border-radius: 35px;
	height: 800px;
	float: left;
	margin-bottom: 50px;
}

#mainTextBox #tab1 {
	width: 600px;
	height: 800px;
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
	text-align: center;
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

div[name="article"] {
	align-self: center;
	text-align: center;
	width: 80%;
	height: 22%;
	margin: 0 auto;
	margin-top: 4%;
	border: 1px solid black;
	border-radius: 35px;
}

div[name="youtube"] {
	align-self: center;
	text-align: center;
	width: 80%;
	height: 22%;
	margin: 0 auto;
	margin-top: 4%;
	border: 1px solid black;
	border-radius: 35px;
}

#tab1 h1 {
	color: #01CD88;
	font-weight: bold;
	text-shadow: 1px 1px 2px #D1D1D1;
}

th {
	font-size: x-large;
}

td, .cona {
	font-size: large;
	color : black;
}
span{
 	color : black;
 	font-size: 14pt;
	font-weight: bolder;
	text-decoration-line: underline; 
	text-decoration-thickness: 2px;
}


</style>
<script type="text/javascript"
	src="${ pageContext.servletContext.contextPath }/resources/js/jquery-3.6.3.min.js"></script>
<script type="text/javascript">
	$(function() {
		var values = $('#new_topN').html();
		console.log("values : " + values);
		$.ajax({
			url : "ftop5.do",
			type : "post",
			dataType : "json",
			success : function(data) {
				console.log("success : " + data);

				var jsonStr = JSON.stringify(data);
				var json = JSON.parse(jsonStr);

				for ( var i in json.list) {
					values += "<tr><td>"
							+ "<a class='cona' href='freedetail.do?free_no="
							+ json.list[i].free_no
							+ "'>"
							+ decodeURIComponent(json.list[i].free_name)
									.replace(/\+/gi, " ") + "</a></td><td>"
							+ json.list[i].user_id + "</td><td>"
							+ json.list[i].write_free_date + "</td><td>"
							+ json.list[i].click_free_no + "</td></tr>";
				}
				$('#new_topN').html(values);
			},
			error : function(jqXHR, textStatus, errorThrown) {
				console.log("ftop5.do error : " + jqXHR + ", " + textStatus
						+ ", " + errorThrown);
			}
		});

	}); //document ready

	$(function() {
		var values = $('#hot_topN').html();
		console.log("values : " + values);
		$.ajax({
			url : "hntop5.do",
			type : "post",
			dataType : "json",
			success : function(data) {
				console.log("success : " + data);

				var jsonStr = JSON.stringify(data);
				var json = JSON.parse(jsonStr);

				for ( var i in json.list) {
					values += "<tr><td><a class='cona' href='hotnewdetail.do?hotnew_no="
							+ json.list[i].hotnew_no
							+ "&hotnew_name="
							+ json.list[i].hotnew_name
							+ "&user_id="
							+ json.list[i].user_id
							+ "'>"
							+ decodeURIComponent(json.list[i].hotnew_name)
									.replace(/\+/gi, " ") + "</a></td><td>"
							+ json.list[i].user_id + "</td><td>"
							+ json.list[i].write_hotnew_date + "</td><td>"
							+ json.list[i].click_hotnew_no + "</td></tr>";
				}
				$('#hot_topN').html(values);
			},
			error : function(jqXHR, textStatus, errorThrown) {
				console.log("hntop5.do error : " + jqXHR + ", " + textStatus
						+ ", " + errorThrown);
			}
		});

	}); //document ready
	
	
	//신규 가입자 리스트
	$(function() {
		var values = $('#newMember').html();
		console.log("values : " + values);
		$.ajax({
			url : "newMember.do",
			type : "post",
			dataType : "json",
			success : function(data) {
				console.log("success : " + data);

				var jsonStr = JSON.stringify(data);
				var json = JSON.parse(jsonStr);

				for ( var i in json.list) {
					values += "<tr><td><a class='cona' href='myinfo.do?user_id="
							+ json.list[i].user_id
							+ "&user_name="
							+ json.list[i].user_name
							+ "&user_nickname="
							+ json.list[i].user_nickname
							+ "&phone="
							+ json.list[i].phone
							+ "&birth="
							+ json.list[i].birth
							+ "&gender="
							+ json.list[i].gender
							+ "&email="
							+ json.list[i].email
							+ "&join_date="
							+ json.list[i].join_date
							+ "'>"
							+ json.list[i].user_id + "</td><td>"
							+ decodeURIComponent(json.list[i].user_name)
									.replace(/\+/gi, " ") + "</a></td><td>"
							+ decodeURIComponent(json.list[i].user_nickname)
									.replace(/\+/gi, " ") + "</td><td>"
							+ json.list[i].phone + "</td><td>"
							+ json.list[i].birth + "</td><td>"
							+ json.list[i].gender + "</td><td>"
							+ json.list[i].email + "</td><td>"
							+ json.list[i].join_date + "</td></tr>";
				}
				$('#newMember').html(values);
			},
			error : function(jqXHR, textStatus, errorThrown) {
				console.log("newMember.do error : " + jqXHR + ", " + textStatus
						+ ", " + errorThrown);
			}
		});

	}); //document ready
	
	
	//<----- admin page table ----->
	
</script>
</head>
<body>
<c:if test="${ loginMember.admin_ck ne 'Y' }">
	<hr style="clear: both; border: none">
	<%-- hot/new & article / youtube --%>
	<div id="mainTextBox">
		<div id="mainTextBox_topN">
			<div id="tab1" style="height: 50%; border: 1px solid black;">
				<h1 style="text-align: center">조회수 TOP 게시글</h1>
				<table id="hot_topN" align="center" border="1"
					style="width: 95%; margin-top: 50px;">
					<tr>
						<th style="width: 45%">제목</th>
						<th style="width: 20%">글쓴이</th>
						<th style="width: 20%">날짜</th>
						<th style="width: 15%">조회수</th>
					</tr>

				</table>
			</div>
			<div id="tab1" style="height: 50%; border: 1px solid black;">
				<h1 style="text-align: center">최신 Free 게시글</h1>
				<table id="new_topN" align="center" border="1"
					style="width: 95%; margin-top: 50px;">
					<tr>
						<th style="width: 45%">제목</th>
						<th style="width: 20%">글쓴이</th>
						<th style="width: 20%">날짜</th>
						<th style="width: 15%">조회수</th>
					</tr>
				</table>

			</div>
		</div>


		<div id="mainTextBox_banner">
			<div id="banner_article">

				<a href="https://newsis.com/view/?id=NISX20230407_0002257899&cID=10201&pID=10200">
				<img width="273.2" height="146.9" src="https://image.newsis.com/2022/04/11/NISI20220411_0000972072_web.jpg?rnd=20220411161920">
				<span>기사제목입니당.</span>
				</a>

				
				<div name="article">article2</div>
				<div name="article">article3</div>
				<div name="article">article4</div>


			</div>
			<div id="banner_youtube">
			<c:forEach var="list" items="${bannerlink}">
				<iframe width="273.2" height="196.9" src="${list}" 
					title="YouTube video player" frameborder="0" 
					allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" 
					allowfullscreen>
				</iframe>
				</c:forEach>
			</div>
		</div>
	</div>
</c:if>
<c:if test="${ !empty loginMember && loginMember.admin_ck eq 'Y' }">
<hr style="clear: both; border: none">
		<div id="mainTextBox"
			style="border: 1px solid #D1D1D1; margin-top: 20px;">
			<div id="tab1" style="border: 1px solid #D1D1D1; width:1200px; height: 800px; border-radius: 30px;">
				<h1 style="text-align: center">신규가입자</h1>
				<table id="newMember" align="center" border="1"
					style="width: 95%; margin-top: 50px;">
					<tr>
						<th style="width: 10%">회원아이디</th>
						<th style="width: 10%">회원이름</th>
						<th style="width: 15%">회원닉네임</th>
						<th style="width: 15%">회원전화번호</th>
						<th style="width: 10%">회원생일</th>
						<th style="width: 10%">회원성별</th>
						<th style="width: 20%">회원이메일</th>
						<th style="width: 10%">가입일자</th>
					</tr>
				</table>
			</div>
		</div>
	</c:if>
</body>
</html>









