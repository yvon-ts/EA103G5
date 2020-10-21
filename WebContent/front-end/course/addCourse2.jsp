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
	<!-- Font Awesome CSS -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.12.1/css/all.min.css">
	<!-- 自己的 CSS 一定放在最下面 -->
	<%-- <link rel="stylesheet" href="<%=request.getContextPath()%>/front-end/course/css/course.css"> --%>

	<style type="text/css">
		main {
			margin-top: 90px;
		}
	</style>
	<!-- ========== CSS Area ========== -->

	<title>課程資料新增 - addCourse2.jsp</title>
</head>

<body>
	<!-- include 前台頁面的 header -->
	<jsp:include page="/index/front-index/header.jsp" />
	
	<main>
		<div class="container">
			<div class="row">
				<div class="col">
					<h1>課程資料新增 - addCourse2.jsp</h1>
					<p><a href="<%=request.getContextPath()%>/front-end/course/select_page.jsp">回首頁</a></p>
				</div>
			</div>

			<div class="row">
				<div class="col-md-6">
					<h2>資料新增：</h2>

					<%-- 錯誤表列 --%>
					<c:if test="${not empty errorMsgs}">
						<font style="color: red">請修正以下錯誤：</font>
						<ul>
							<c:forEach var="message" items="${errorMsgs}">
								<li style="color: red">${message}</li>
							</c:forEach>
						</ul>
					</c:if>


					<form METHOD="post" ACTION="<%=request.getContextPath()%>/course/course.do" name="form1" enctype="multipart/form-data">
						<jsp:useBean id="courseSvc" scope="page" class="com.course.model.CourseService" />

						<div>
							<span>課程類別：</span>
							<jsp:useBean id="courseTypeSvc" scope="page" class="com.course_type.model.CourseTypeService" />
							<select name="cstypeno" size="1">
								<c:forEach var="courseTypeVO" items="${courseTypeSvc.all}">
									<option value="${courseTypeVO.cstypeno}" ${courseVO.cstypeno==courseTypeVO.cstypeno ? 'selected' : '' }>
										${courseTypeVO.cstypename}
								</c:forEach>
							</select>
						</div>
						
						<div>
							<span>課程名稱：</span>
							<input type="text" name="coursename" size="45" value="<%=(courseVO == null) ? "真空吸引" : courseVO.getCoursename()%>" />
						</div>

						

						<div>
							<span>課程單價：</span>
							<input type="NUMBER" name="courseprice" size="45" value="<%=(courseVO == null) ? 787 : courseVO.getCourseprice()%>" />
						</div>

						<div>
							<span>課程圖片：</span>
							<input type="file" name="courseimg" size="45" id="fileUp"/>
						</div>

					</div>

					<div class="col-md-6">
						<div>
							<span>課程資訊：</span>
							<input type="TEXT" name="courseinfo" size="45" value="<%=(courseVO == null) ? "這是一堂騙錢的課" : courseVO.getCourseinfo()%>" />
						</div>
						
						
						<input type="hidden" name="action" value="insert">
						<input type="submit" value="送出新增">
						
						
						
						
						<h2>不該給開課者填寫的東西</h2>
						<!-- 教師編號應該要自己抓到 -->
						<input type="text" name="tchrno" size="45" value="TCHR0001" />
						<input type="hidden" name="ttltime" value=0 />
						<input type="hidden" name=csstatus value="審核中" >
						<input type="hidden" name="csscore" value=3 />
						<input type="hidden" name="csscoretimes" value=1 />
					</form>

				</div>
			</div>
		</div>
	</main>

	<script type="text/javascript">
		var fileUp = document.getElementById("fileUp");

		fileUp.addEventListener('change', function () {
			var files = fileUp.files;
			if (files) {
				for (var i = 0; i < files.length; i++) {
					var file = files[i];

					if (file.type.indexOf('image') > -1) {
						var reader = new FileReader();
						reader.addEventListener('load', function () {

							var div = document.createElement('div');

							var img = document.createElement('img');

							img.setAttribute('src', event.target.result);

							div.append(img);

							if (fileUp.nextElementSibling) { //只給上傳一張
								fileUp.nextElementSibling.remove();
							}

							fileUp.after(div);
						});
						reader.readAsDataURL(file);
					} else {
						alert("請上圖檔");
					}
				}

				//             fileUp.setAttribute('type', 'text');
				//             fileUp.setAttribute('type', 'file');
			}
		});
	</script>

</body>

</html>