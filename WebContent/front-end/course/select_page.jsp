<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<title>Course: Home</title>
</head>

<body>

	<h1>Course: Home</h1>
	<p>This is the Home Page for EA103G5 Course: Home</p>
	<h3>資料查詢：</h3>

	<%-- 錯誤處理 --%>
	<c:if test="${not empty errorMsgs}">
		<h3 style="color:red">請修正以下錯誤：</h3>
		<ul>
			<c:forEach var="message" items="${errorMsgs}">
				<li style="color:red">${message}</li>
			</c:forEach>
		</ul>
	</c:if>
	
	<ul>
		<li><a href="<%=request.getContextPath()%>/front-end/course/listAllCourse.jsp"> List </a> all Courses.</li>

		<li>
			<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/course/course.do">
				<span> 請輸入課程編號 (如 COUR0001)：</span> <input type="text" name="courseno">
				<input type="hidden" name="action" value="getOne_For_Display">
				<input type="submit" value="送出">
			</FORM>
		</li>

		<jsp:useBean id="courseSvc" scope="page" class="com.course.model.CourseService" />
		<li>
			<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/course/course.do">
				<span> 請選擇課程編號：</span> <select name="courseno">
					<c:forEach var="courseVO" items="${courseSvc.allForEmployee}">
						<option value="${courseVO.courseno}">
							${courseVO.courseno}
					</c:forEach>
				</select> <input type="hidden" name="action" value="getOne_For_Display">
				<input type="submit" value="送出">
			</FORM>
		</li>

		<li>
			<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/course/course.do">
				<span> 請選擇課程名稱：</span> <select name="courseno">
					<c:forEach var="courseVO" items="${courseSvc.allForEmployee}">
						<option value="${courseVO.courseno}">
							${courseVO.coursename}
					</c:forEach>
				</select>
				<input type="hidden" name="action" value="getOne_For_Display">
				<input type="submit" value="送出">
			</FORM>
		</li>
	</ul>
	
	<h3>課程管理</h3>
	<ul>
		<li> <a href="<%=request.getContextPath()%>/front-end/course/addCourse.jsp"> Add </a> a new Course.</li>
	</ul>
	
	<li>
			<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/course/course.do">
				<span> 編輯課程編號：</span> <select name="courseno">
					<c:forEach var="courseVO" items="${courseSvc.allForEmployee}">
						<option value="${courseVO.courseno}">
							${courseVO.courseno}
					</c:forEach>
				</select> <input type="hidden" name="action" value="getOneCourseForUpdate">
				<input type="submit" value="送出">
			</FORM>
		</li>

	
</body>
</html>