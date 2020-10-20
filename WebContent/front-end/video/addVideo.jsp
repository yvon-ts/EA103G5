<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.video.model.*"%>

<%
	VideoVO videoVO = (VideoVO) request.getAttribute("videoVO");
%>

<html>

<head>
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
	<title>影片資料新增 - addVideo.jsp</title>

	<script src="https://code.jquery.com/jquery-3.5.1.js"></script>

	<style>
		table {
			width: 450px;
			background-color: white;
			margin-top: 1px;
			margin-bottom: 1px;
		}

		table,
		th,
		td {
			border: 0px solid #CCCCFF;
		}

		th,
		td {
			padding: 1px;
		}
	</style>

</head>

<body bgcolor='white'>
	<h3>影片資料新增 - addVideo.jsp</h3>

	<p>
		<a href="<%=request.getContextPath()%>/front-end/video/select_page.jsp">回首頁</a>
	</p>

	<h3>資料新增:</h3>

	<%-- 錯誤表列 --%>
	<c:if test="${not empty errorMsgs}">
		<font style="color: red">請修正以下錯誤:</font>
		<ul>
			<c:forEach var="message" items="${errorMsgs}">
				<li style="color: red">${message}</li>
			</c:forEach>
		</ul>
	</c:if>

	<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/video/video.do" name="form1"
		enctype="multipart/form-data">
		<table>
			<jsp:useBean id="courseSvc" scope="page" class="com.course.model.CourseService" />
			<tr>
				<td>課程編號:<font color=red><b>*</b></font>
				</td>
				<td><select name="courseno" size="1">
						<c:forEach var="courseVO" items="${courseSvc.all}">
							<option value="${courseVO.courseno}" ${videoVO.courseno==courseVO.courseno ? 'selected' : ''
								}> ${courseVO.coursename}
						</c:forEach>
					</select>
			</tr>
			<tr>
				<td>範圍編號:</td>
				<td><input type="number" name="testscope" size="45"
						value="<%=(videoVO == null) ? 0 : videoVO.getTestscope()%>" /></td>
			</tr>
			<tr>
				<td>單元編號:</td>
				<td><input type="number" name="chapterno" size="45"
						value="<%=(videoVO == null) ? 0 : videoVO.getChapterno()%>" /></td>
			</tr>
			<tr>
				<td>單元名稱:</td>
				<td><input type="TEXT" name="chaptername" size="45"
						value="<%=(videoVO == null) ? "積分8" : videoVO.getChaptername()%>" /></td>
			</tr>
			<tr>
				<td>單元長度:</td>
				<td><input type="number" name="chapterlen" size="45" readonly
						value="<%=(videoVO == null) ? 0 : videoVO.getChapterlen()%>" />
					<span>#應該要自動抓影片長度</span></td>
			</tr>
			<tr>
				<td>影片內容:</td>
				<td><input type="file" name="video" size="45" accept="video/*" id="fileUp" /></td>
				<!-- <td><input type="FILE" name="video" size="45" value="<%=(videoVO == null) ? "Not Thing" : videoVO.getVideo()%>" /></td> -->
				<!-- 				如何保存forward回來的上傳選項呢？ -->
			</tr>

		</table>
		<pre id="infos"></pre>
		<br>
		<input type="hidden" name="action" value="insert">
		<input type="submit" value="送出新增">
	</FORM>


	<script>
		// var myVideos = [];
		var files = null;
		window.URL = window.URL || window.webkitURL;
		document.getElementById('fileUp').onchange = setFileInfo;

		function setFileInfo() {
			files = this.files;
			console.log(files[0].duration);
			//myVideos.push(files[0]);
			var video = document.createElement('video');
			video.preload = 'metadata';

			video.onloadedmetadata = function () {
				window.URL.revokeObjectURL(video.src);
				var duration = video.duration;
				// 				myVideos[myVideos.length - 1].duration = duration;
				files[0].duration = duration;
				updateInfos();
			}

			video.src = URL.createObjectURL(files[0]);;

		}

		function updateInfos() {
			var infos = document.getElementById('infos');
			// infos.textContent = "";
			// for (var i = 0; i < myVideos.length; i++) {
			// infos.textContent += myVideos[i].name + " duration: " + myVideos[i].duration + '\n';
			console.log(parseInt(files[0].duration));
			$("input[name=chapterlen]").val(parseInt(files[0].duration));
		}
	</script>

</body>

</html>