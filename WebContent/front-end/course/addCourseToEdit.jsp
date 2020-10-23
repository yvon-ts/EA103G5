<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> <%@ page import="java.util.*"%>
<%@ page import="com.course.model.*"%>

<%
	CourseVO courseVO = (CourseVO) request.getAttribute("courseVO");
%>

<!DOCTYPE html>
<html lang="zh-Hant">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">

	<!-- ========== CSS Area ========== -->
	<!-- Bootstrap 的 CSS -->
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

	<!-- This page's CSS -->
	<style>
		#content {
			margin-top: 80px;
			height:70vh;
		}
		#picturePreview {
			text-align: center;
		}
	</style>
	<!-- ========== CSS Area ========== -->

	<title>申請成功 - Xducation 陪你成長的學習好夥伴</title>
</head>

<body>
	<!-- include 前台頁面的 header -->
	<jsp:include page="/index/front-index/header.jsp" />

		<div class="container">
			<div id="content" class="row align-items-center">
				<div class="col text-center">
					<h1>${courseVO.coursename}</h1>
					<br>
					<h2>申請成功</h2>
					<br>
					<h5>繼續編輯課程內容...</h5>
					<br>
					<%-- <p><a href="<%=request.getContextPath()%>/front-end/course/select_page.jsp">回首頁</a></p> --%>
					<form METHOD="post" ACTION="<%=request.getContextPath()%>/course/course.do" name="form1" enctype="multipart/form-data">
						<input type="hidden" name="courseno" value="${courseVO.courseno}">
						<input type="hidden" name="action" value="getOneCourseForUpdate">
						<button type="submit" class="btn btn-lg btn-primary btn-block">編輯課程</button>
					</form>
				</div>
			</div>
		</div>
	<!-- include 前台頁面的 footer -->
	<jsp:include page="/index/front-index/footer.jsp" />
</body>

</html>