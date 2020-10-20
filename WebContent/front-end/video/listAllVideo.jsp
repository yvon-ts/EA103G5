<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="com.video.model.*"%>

<jsp:useBean id="videoSvc" scope="page" class="com.video.model.VideoService"/>

<!DOCTYPE html>

<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>所有影片列表 - listAllVideo.jsp</title>
<style>
table, th, td {
	border: 1px solid black;
}
</style>
</head>

<body>
	<h1>所有影片列表 - listAllVideo.jsp</h1>
	<p>
		<a href="<%=request.getContextPath()%>/front-end/video/select_page.jsp">回首頁</a>
	</p>

	<%-- 錯誤表列 --%>
	<c:if test="${not empty errorMsgs}">
		<font style="color: red">請修正以下錯誤:</font>
		<ul>
			<c:forEach var="message" items="${errorMsgs}">
				<li style="color: red">${message}</li>
			</c:forEach>
		</ul>
	</c:if>

	<table>
		<tr>
			<th>影片編號</th>
			<th>課程編號</th>
			<th>範圍編號</th>
			<th>單元編號</th>
			<th>單元名稱</th>
			<th>單元長度</th>
			<th>影片內容</th>
			<th>修改</th>
			<th>刪除</th>
		</tr>
		<c:forEach var="videoVO" items="${videoSvc.all}">
			<tr>
				<td>${videoVO.videono}</td>
				<td>${videoVO.courseno}</td>
				<td>${videoVO.testscope}</td>
				<td>${videoVO.chapterno}</td>
				<td>${videoVO.chaptername}</td>
				<td>${videoVO.chapterlen}</td>
				<td>${videoVO.video}</td>
				<td>
					<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/video/video.do" style="margin-bottom: 0px;">
			     	<input type="submit" value="修改">
			     	<input type="hidden" name="videono"  value="${videoVO.videono}">
			     	<input type="hidden" name="action"	value="getOne_For_Update"></FORM>
				</td>
				<td>
					<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/video/video.do" style="margin-bottom: 0px;">
			     	<input type="submit" value="刪除">
			     	<input type="hidden" name="videono"  value="${videoVO.videono}">
			     	<input type="hidden" name="action"	value="delete"></FORM>
				</td>
			</tr>
		</c:forEach>
	</table>

</body>

</html>