<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<title>Video: Home</title>
</head>

<body>

	<h1>Video: Home</h1>
	<p>This is the Home Page for EA103G5 Video: Home</p>
	<h3>資料查詢：</h3>

	<%-- 錯誤處理 --%>
	<c:if test="${not empty errorMsgs }">
		<h3>請修正以下錯誤：</h3>
		<ul>
			<c:forEach var="message" items="${errorMsgs}">
				<li>${message}</li>
			</c:forEach>
		</ul>
	</c:if>

	<ul>
		<li><a href="<%=request.getContextPath()%>/front-end/video/listAllVideo.jsp"> List </a> all Videos.</li>

		<li>
			<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/video/video.do">
				<span> 請輸入影片編號 (如 VID0001)：</span> <input type="text" name="videono">
				<input type="hidden" name="action" value="getOne_For_Display">
				<input type="submit" value="送出">
			</FORM>
		</li>

		<jsp:useBean id="videoSvc" scope="page" class="com.video.model.VideoService" />

		<li>
			<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/video/video.do">
				<span> 請選擇影片編號：</span> <select name="videono">
					<c:forEach var="videoVO" items="${videoSvc.all}">
						<option value="${videoVO.videono}">
							${videoVO.videono}
					</c:forEach>
				</select> <input type="hidden" name="action" value="getOne_For_Display">
				<input type="submit" value="送出">
			</FORM>
		</li>

		<li>
			<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/video/video.do">
				<span> 請選擇影片名稱：</span> <select name="videono">
					<c:forEach var="videoVO" items="${videoSvc.all}">
						<option value="${videoVO.videono}">
							${videoVO.chaptername}
					</c:forEach>
				</select>
				<input type="hidden" name="action" value="getOne_For_Display">
				<input type="submit" value="送出">
			</FORM>
		</li>
	</ul>
	
	<h3>影片管理</h3>
	<ul>
		<li> <a href="<%=request.getContextPath()%>/front-end/video/addVideo.jsp"> Add </a> a new Video.</li>
	</ul>
	
	<jsp:include page="/front-end/video/listAllVideo.jsp"/>
	
</body>
</html>