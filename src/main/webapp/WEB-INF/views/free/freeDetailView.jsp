<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style type="text/css">
<!--
Simple Css --> /*    html, body{ margin:0; padding:0}
    */ form td {
   width: 800px;
   margin: 0 auto;
}

body {
   line-height: 2em;
   font-family: "맑은 고딕";
}

#fixdel {
   position: absolute;
   left: 50%;
   top: 50%;
   transform: translate(-50%, -50%);
   width: 400px;
   text-decoration: none;
   background-color: white;
   text-align: center;
   color: #01CD88;
   font-weight: bold;
   font-size: 20pt;
   border: 1px solid;
}
#title {
   position: static;
    top: 50%;
    left: 50%;
   width: 400px;
   transform: translate(100%, 0%);
   text-decoration: none;
   background-color: white;
   text-align: center;
   color: #01CD88;
   font-weight: bold;
   text-shadow: 1px 1px 2px #D1D1D1;
   font-size: 20pt;
   border: 1px solid;
}

.imginfo {
   width: 30px;
   height: 30px;
}

table {
  -moz-border-radius: 5px !important;
  border-collapse: collapse !important;
  border: none !important;
  border-style: hidden;
  background-color: #DCFFDC;
  border-radius: 20px;
}

table th,
table td {
  border: none !important
}
table th:first-child {
  -moz-border-radius: 5px 0 0 0 !important;
}
table th:last-child {
  -moz-border-radius: 0 5px 0 0 !important;
}
table tr:last-child td:first-child {
  -moz-border-radius: 0 0 0 5px !important;
}
table tr:last-child td:last-child {
  -moz-border-radius: 0 0 5px 0 !important;
}

.cbfile {
   font-size: 14px bold;
}

.yesdragon {
   float: left;
   max-width: 900px;
   word-break: break-all;
   line-height: 1.5;
   position: relative !important;
   overflow: hidden;
   font-size: 13px;
   color: #333;
}

.allarea {
   line-height: 22px;
   margin-bottom: 50px;
   margin: auto;
   padding: 30px;
   width: 900px;
   border-radius: 30px;
   border: 1px solid #D1D1D1;
   background-color: #F0FFF0;
}

a {
	text-decoration: none;
	color: #01CD88;
}

a:hover {
	text-decoration: none;
	color: #01CD88;
	font-weight: bold;
	text-shadow: 1px 1px 2px #D1D1D1;
}
</style>
<script type="text/javascript"
   src="${ pageContext.servletContext.contextPath }/resources/js/jquery-3.6.3.min.js"></script>
<script type="text/javascript">
   
</script>
<title></title>
</head>
<body>
   <c:import url="/WEB-INF/views/common/menubar.jsp" />
   <c:import url="/WEB-INF/views/common/commubar.jsp" />
   <hr>
	<div>
		<p id="title">FREE 게시글 상세보기</p>
	</div>
   <div class="allarea">
         <div class="fixdel" align="right">
            <c:if test="${ requestScope.free.user_id eq sessionScope.loginMember.user_id and !empty sessionScope.loginMember}">
               <c:url var="ffup" value="/freeupmove.do">
                     <c:param name="free_no" value="${ free.free_no }" />
                  </c:url> <a href="${ ffup }">[글수정] </a> &nbsp; &nbsp;
            </c:if>

            <c:if test="${ requestScope.free.user_id eq sessionScope.loginMember.user_id and !empty sessionScope.loginMember}">
               <c:url var="ffde" value="/freedelete.do">
                  <c:param name="free_no" value="${ free.free_no }" />
               </c:url>
               <a href="${ ffde }"> [글삭제]</a> &nbsp; &nbsp;
            </c:if>
         </div>



         <div class="topinfo" style="">
            <div class="topareatitle" style="">
               <h3 class="titlename">
                  <span class="ffname"> &nbsp; ${ free.free_name }</span>
               </h3>
               <hr>
            </div>
            <div class="userezinfo">
               <div class="side">
                  <span class="userinfoimg">작성자: ${ free.user_id }</span> <span
                     class="datetime" style="text-align: right"> &nbsp; 작성일: <fmt:formatDate
                        value="${free.write_free_date}" pattern="yyyy-MM-dd a HH:mm:ss" />
                  </span>
               </div>
               <div class="side fr">
                  <span>조회수 <b>&nbsp;${free.click_free_no}&nbsp;</b></span> 
                  <span>추천수 <b><c:if
                           test="${!empty likeFree.user_id and likeFree.user_id eq sessionScope.loginMember.user_id}">
                           <img
                              src="${ pageContext.servletContext.contextPath }/resources/images/fullheart.png"
                              width="15" height="15" alt="fullheart">
               					${free.free_like_no} &nbsp;
               </c:if> 
               <c:if test="${empty likeFree.user_id or likeFree.user_id ne sessionScope.loginMember.user_id}">
                           <img
                              src="${ pageContext.servletContext.contextPath }/resources/images/heart.png"
                              width="15" height="15" alt="heart">
               					${free.free_like_no} &nbsp;
               </c:if> 
               <c:if test="${ !empty sessionScope.loginMember }">
                           <c:url var="fflikein" value="/freelike.do">
                              <c:param name="user_id"
                                 value="${sessionScope.loginMember.user_id }" />
                              <c:param name="free_no" value="${free.free_no }" />
                              <c:param name="free_like_no" value="${free.free_like_no }" />
                           </c:url>
                           <a href="${ fflikein }">[추천하기]</a>
                        </c:if>&nbsp; </b>
                  </span>
                  <span class="cbfile">첨부 파일 : </span>
            <!-- 첨부파일이 있다면, 파일명 클릭시 다운로드 실행 처리 -->
            <c:forEach items="${ ofile }" var="of" varStatus="status">
               <c:if test="${ !empty of and !empty sessionScope.loginMember}">
                  <c:url var="ffd" value="/freedown.do">
                     <c:param name="ofile" value="${ of }" />
                     <c:param name="rfile" value="${ rfile[status.index] }" />
                  </c:url>
                   &nbsp;<a href="${ ffd }">${ of }</a>
               </c:if>
            </c:forEach>
            <!-- 첨부파일이 없다면, Empty 처리 -->
            <c:if test="${ empty free.originfile_free}">
                   &nbsp; * 첨부파일이 없습니다 *
               </c:if>
                  <hr>
               </div>
            </div>
         </div>
         <br>
         <br>
         <div class="yesdragon">

            <c:forEach items="${ rfile }" var="rf">
               <c:if test="${ !empty rf and !empty sessionScope.loginMember}">
                  <br>
               &nbsp; &nbsp; <img
                     src="${ pageContext.servletContext.contextPath }/resources/free_upfiles/${rf}"
                     width="400" alt="upfile">
                  <br>
               </c:if>
            </c:forEach>
            &nbsp; &nbsp; ${free.free_value}<br>
            <br>
            <br>
         </div>
         
         <table style="margin-left: auto; margin-right: auto;" width="900px"
         border="1px solid" cellpadding="0" cellspacing="0">
            <th>댓글 작성자</th>
         <td align="center"><b>댓글내용 &nbsp; &nbsp; </b>
         <c:if test="${ !empty sessionScope.loginMember.user_id }">
               <c:url var="ffrein" value="/movefreerepin.do">
                  <c:param name="free_no" value="${free.free_no }" />
               </c:url>
               <a href="${ ffrein }">[댓글등록]</a>
            </c:if>
         </td>
         

         <c:forEach items="${ list }" var="f">
            <tr>
               <c:if test="${ f.free_reply_lev eq 2 }">
                  <th>${f.user_id}</th>
                  <td>&nbsp; &nbsp; ${f.free_value} &nbsp; 
                  <c:if test="${ f.user_id eq sessionScope.loginMember.user_id and !empty sessionScope.loginMember}">
                        <c:url var="ffreup" value="/movefreerepup.do">
                           <c:param name="free_no" value="${f.free_no }" />
                        </c:url>
                        <a href="${ ffreup }">[댓글 수정하기]</a> &nbsp;
               </c:if> 
               <c:if test="${ f.user_id eq sessionScope.loginMember.user_id and !empty sessionScope.loginMember}">
                        <c:url var="ffrede" value="/freerepdelete.do">
                           <c:param name="free_no" value="${ f.free_no }" />
                           <c:param name="free_ref" value="${ f.free_ref }" />
                           <c:param name="free_reply_ref" value="${ f.free_reply_ref }" />
                           <c:param name="free_reply_lev" value="${ f.free_reply_lev }" />
                           <c:param name="freeno" value="${ free.free_no }" />
                        </c:url>
                        <a href="${ ffrede }">[댓글 삭제하기]</a> &nbsp;
               </c:if> <c:if test="${!empty sessionScope.loginMember}">
                        <c:url var="ffrereup" value="/movefreerepin2.do">
                           <c:param name="free_ref" value="${f.free_ref }" />
                           <c:param name="free_reply_ref" value="${f.free_reply_ref }" />
                           <c:param name="free_reply_lev" value="${f.free_reply_lev }" />
                        </c:url>
                        <a href="${ ffrereup }">[대댓글등록]</a>
                     </c:if>
                  </td>
               </c:if>
               <c:if test="${ f.free_reply_lev eq 3 }">
                  <th>${f.user_id}</th>
                  <td>&nbsp; &nbsp; &nbsp; &nbsp; ▶ ${f.free_value} 
                  <c:if test="${ f.user_id eq sessionScope.loginMember.user_id and !empty sessionScope.loginMember}">
                        <c:url var="ffreup2" value="/movefreerepup.do">
                           <c:param name="free_no" value="${f.free_no }" />
                        </c:url>
                        <a href="${ ffreup2 }">[댓글 수정하기]</a> &nbsp;
               </c:if> 
               <c:if test="${ f.user_id eq sessionScope.loginMember.user_id and !empty sessionScope.loginMember}">
                        <c:url var="ffrede2" value="/freerepdelete.do">
                           <c:param name="free_no" value="${ f.free_no }" />
                           <c:param name="free_ref" value="${ f.free_ref }" />
                           <c:param name="free_reply_ref" value="${ f.free_reply_ref }" />
                           <c:param name="free_reply_lev" value="${ f.free_reply_lev }" />
                           <c:param name="freeno" value="${ free.free_no }" />
                        </c:url>
                        <a href="${ ffrede2 }">[댓글 삭제하기]</a> &nbsp;
               </c:if>
                  </td>
               </c:if>
            </tr>
            </c:forEach>
      </table>
      <br>
      <hr>
      <div align="right">
            <td colspan="2" align="right">
            <c:if test="${empty sessionScope.loginMember}">
                  * 메인페이지의 TOP5 게시글 상세보기 이외의 모든 기능을 이용하시려면 로그인해주세요 *
                  <button onclick="location.href='loginPage.do'">로그인이동</button>&nbsp;
               </c:if> <c:if test="${!empty sessionScope.loginMember}">
                  <button onclick="location.href='main.do'">메인페이지</button>&nbsp;
               </c:if> <button onclick="javascript:history.go(-1)">뒤로가기</button>
      </div>
   </div>
   <br>
<hr>

<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>