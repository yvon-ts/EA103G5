<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.posts.model.*"%>

<%
  PostsVO postsVO = (PostsVO) request.getAttribute("postsVO"); //EmpServlet.java (Concroller) 存入req的empVO物件 (包括幫忙取出的empVO, 也包括輸入資料錯誤時的empVO物件)
%>

<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<title>留言板貼文資料修改 - update_posts_input.jsp</title>

<style>
  table#table-1 {
	background-color: #CCCCFF;
    border: 2px solid black;
    text-align: center;
  }
  table#table-1 h4 {
    color: red;
    display: block;
    margin-bottom: 1px;
  }
  h4 {
    color: blue;
    display: inline;
  }
</style>

<style>
  table {
	width: 450px;
	background-color: white;
	margin-top: 1px;
	margin-bottom: 1px;
  }
  table, th, td {
    border: 0px solid #CCCCFF;
  }
  th, td {
    padding: 1px;
  }
</style>

</head>
<body bgcolor='white'>


<h3>資料修改:</h3>

<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/posts/posts.do" name="form1">


<table>
	<tr>
		<td>文章編號:</td>
		<td><%=postsVO.getPostno()%></td>
	</tr>
	<tr>
		<td>父文章編號:</td>
		<td><%=postsVO.getSuperpostno()%></td>
	</tr>
	<tr>
		<td>課程編號:</td>
		<td><%=postsVO.getCourseno()%></td>
	</tr>
	
	<tr>
		<td>會員編號:</td>
		<td><%=postsVO.getMemno()%></td>
	</tr>
	<tr>
		<td>內容:</td>
		<td><input type="TEXT" name="postcontent" size="45" value="<%=postsVO.getPostcontent()%>"></td>
	</tr>
	<tr>
		<td>發布時間:</td>
		<td><%=postsVO.getPosttime()%></td>
	</tr>




</table>
<br>
<input type="hidden" name="action" value="update">
<input type="hidden" name="postno" value="<%=postsVO.getPostno()%>"/>
<input type="hidden" name="courseno" value="<%=postsVO.getCourseno()%>"/>
<input type="hidden" name="superpostno" value="<%=postsVO.getSuperpostno()%>"/>
<input type="hidden" name="memno" value="<%=postsVO.getMemno()%>"/>


<input type="submit" value="送出修改"></FORM>
</body>






</html>