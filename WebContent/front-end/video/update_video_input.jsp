<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.video.model.*"%>

<%
	//VideoVO videoVO = (VideoVO) request.getAttribute("videoVO");
%>

<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<title>影片資料修改 - update_video_input.jsp</title>

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
	<h3>影片資料修改 - update_video_input.jsp</h3>
	<h3>資料修改:</h3>

	<%-- 錯誤表列 --%>
	<c:if test="${not empty errorMsgs}">
		<font style="color: red">請修正以下錯誤:</font>
		<ul>
			<c:forEach var="message" items="${errorMsgs}">
				<li style="color: red">${message}</li>
			</c:forEach>
		</ul>
	</c:if>

	<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/video/video.do" name="form1" enctype="multipart/form-data">
		<table>
			<tr>
				<td>影片編號:<font color=red><b>*</b></font></td>
				<td>${videoVO.videono}</td>
			</tr>
<!-- 			<tr> -->
<!-- 				<td>課程編號:</td> -->
<!-- 				<td><input type="TEXT" name="courseno" size="45" -->
<%-- 					value="${videoVO.courseno}"/></td> --%>
<!-- 			</tr> -->
			<jsp:useBean id="courseSvc" scope="page" class="com.course.model.CourseService"/>
			<tr>
				<td>課程編號:<font color=red><b>*</b></font></td>
				<td><select name="courseno" size="1">
					<c:forEach var="courseVO" items="${courseSvc.all}">
						<option value="${courseVO.courseno}" ${videoVO.courseno == courseVO.courseno ? 'selected' : '' }> ${courseVO.coursename}
					</c:forEach>
					</select>
			</tr>
			<tr>
				<td>範圍編號:</td>
				<td><input type="number" name="testscope" size="45"
					value="${videoVO.testscope}" /></td>
			</tr>
			<tr>
				<td>單元編號:</td>
				<td><input type="number" name="chapterno" size="45"
					value="${videoVO.chapterno}" /></td>
			</tr>
			<tr>
				<td>單元名稱:</td>
				<td><input type="TEXT" name="chaptername" size="45"
					value="${videoVO.chaptername}" /></td>
			</tr>
			<tr>
				<td>單元長度:</td>
				<td><input type="NUMBER" name="chapterlen" size="45"
					value="${videoVO.chapterlen}" /></td>
			</tr>
			<tr>
				<td>影片內容:</td>
				<td><input type="FILE" name="video" size="45"
					value="${videoVO.video}" /></td>
			</tr>

		</table>
		<br>
		<input type="hidden" name="action" value="update">
		<input type="hidden" name="videono" value="${videoVO.videono}">
		<input type="submit" value="送出修改">
		
		<br>
		<h2>當前影片</h2>
		<video width="320" height="240" loop autoplay controls muted poster="<%=request.getContextPath()%>/NoData/none2.jpg">
  			<source src="<%=request.getContextPath()%>/video/VideoReaderFromDB?videono=${videoVO.videono}" type="video/mp4">
  			萬一瀏覽器未支援時顯示訊息
		</video>
	</FORM>
</body>
</html>