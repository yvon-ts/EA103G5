<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> <%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="com.course.model.*"%>
<%@ page import="com.video.model.*"%>

<jsp:useBean id="courseSvc" scope="page" class="com.course.model.CourseService" />
<jsp:useBean id="membersSvc" scope="page" class="com.members.model.MembersService" />
<jsp:useBean id="teacherSvc" scope="page" class="com.teacher.model.TeacherService" />
<jsp:useBean id="courseTypeSvc" scope="page" class="com.course_type.model.CourseTypeService" />

<%
	CourseVO courseVO = (CourseVO) request.getAttribute("courseVO");

// 	開玄修改
	if(courseVO == null){
		courseVO = new CourseService().getOneCourse(request.getParameter("courseno"));
		request.setAttribute("courseVO",courseVO);
	}
	
	// 處理課程評分精度以及分母為零的問題
	Integer csscore = courseVO.getCsscore();
	Integer csscoretimes = courseVO.getCsscoretimes();
	NumberFormat formatter = new DecimalFormat("#.#");
	String courseScore = "0";
	if (csscoretimes > 0) {
		courseScore = formatter.format(Double.valueOf(csscore) / Double.valueOf(csscoretimes));
	}
	
	//開玄-->爛方法 要把名字傳到題庫
	request.getSession().setAttribute("courseno", courseVO.getCourseno());
	
%>

<!DOCTYPE html>
<html lang="zh-Hant">

<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<!-- ========== CSS Area ========== -->
	<!-- Bootstrap CSS -->
	<link rel="stylesheet" href="<%=request.getContextPath()%>/library/bootstrap/4.5.3/css/bootstrap.min.css">
	<!-- Font Awesome CSS -->
	<link rel="stylesheet" href="<%=request.getContextPath()%>/library/font-awesome/5.15.1/css/all.min.css">
	<!-- 自己的 CSS 一定放在最下面 -->
	<link rel="stylesheet" href="<%=request.getContextPath()%>/front-end/course/css/editCourse.css">
	<%-- 	<link rel="stylesheet" href="<%=request.getContextPath()%>/front-end/course/css/editCourseChapter.css"> --%>
	<!-- ========== CSS Area ========== -->
	<title>課程管理 - ${courseVO.coursename}</title>
</head>

<body>
	<!-- include 前台頁面的 header -->
	<jsp:include page="/index/front-index/header.jsp" />

	<div class="container-fluid" style="margin-top: 90px;">

		<div class="row">
			<div class="col">
				<h1 id="pageTitle">課程管理 - ${courseVO.coursename}</h1>
			</div>
		</div>

		<div class="row">

			<div class="col-md-3 sideBar">


				<h2>基本資訊</h2>
				<h5>編號：${courseVO.courseno}</h5>
				<h5>老師：${membersSvc.getOneMembers(teacherSvc.getOneTeacher(courseVO.tchrno).memno).memname}</h5>
				<h5>類別：${courseTypeSvc.getOneCourseType(courseVO.cstypeno).cstypename}</h5>
				<h5>單價：${courseVO.courseprice}</h5>
	
				<% 
					// 將課程總時數換算為分鐘
                    Integer ttltimeInMin = ((CourseVO)request.getAttribute("courseVO")).getTtltime()/60;
                %>                            
                <h5>總時數：<%= ttltimeInMin %>分鐘</h5>
				<h5>狀態：${courseVO.csstatus}</h5>
				<h5>評分：<%= courseScore %></h5>

				<br>

				<h2>課程編輯</h2>
				<nav>
					<ul class="nav flex-column nav-pills">
						<li class="nav-item">
							<a class="nav-link active" data-toggle="pill" href="#editCourseChapter">
								<h5>課程單元編輯</h5>
							</a>
						</li>
						<li class="nav-item">
							<a class="nav-link" data-toggle="pill" href="#editCourseBasicInfo">
								<h5>基本資訊管理</h5>
							</a>
						</li>

						<li class="nav-item">
							<a class="nav-link" data-toggle="pill" href="#">
								<h5>附件上傳</h5>
							</a>
						</li>
						
					</ul>
				</nav>
				<h2>題庫管理</h2>
				<nav>
					<ul class="nav flex-column nav-pills">
						<li class="nav-item">
							<a class="nav-link " href="<%= request.getContextPath()%>/front-end/question/ListAllQuestion.jsp?coursename=${courseVO.coursename}">
								<h5>課程題目編輯</h5>
							</a>
						</li>
					
						
					</ul>
				</nav>
			</div>

			<div class="col-md-9">
				<div class="tab-content" id="subPage">
					<div id="editCourseChapter" class="tab-pane fade show active">
						<jsp:include page="/front-end/course/editCourseChapter.jsp" />
					</div>
					<div id="editCourseBasicInfo" class="tab-pane fade">
						<h2>基本資訊管理</h2>
						<jsp:include page="/front-end/course/editCourseBasicInfo.jsp" />
					</div>
					
					
				</div>
			</div>
			
		</div>
	</div>


	<!-- ========== JavaScript Area ========== -->
	<!-- jQuery JS -->
	<script src="<%=request.getContextPath()%>/library/jquery/jquery-3.5.1.js"></script>
	<!-- Bootstrap JS -->
	<script src="<%=request.getContextPath()%>/library/bootstrap/4.5.3/js/bootstrap.min.js"></script>
	<!-- 計算 video durarion 相關的 JS -->
	<script src="<%=request.getContextPath()%>/front-end/video/js/videoDurationCaculation.js"></script>
	<!-- ========== JavaScript Area ========== -->

	<!-- include 前台頁面的 footer -->
	<jsp:include page="/index/front-index/footer.jsp" />
	<!-- include 前台頁面的 footer -->



	<!-- Sortable API JS (放到 include 那邊會出事，且須放在 footer 之下)-->
	<script src="<%=request.getContextPath()%>/front-end/course/js/bootstrap-html5sortable-master/jquery.sortable.min.js"></script>
</body>

</html>