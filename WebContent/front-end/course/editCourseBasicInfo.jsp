<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> <%@ page import="java.util.*"%>
<%@ page import="com.course.model.*"%>
<%@ page import="com.video.model.*"%>

<%
	CourseVO courseVO = (CourseVO) request.getAttribute("courseVO");
%>

<!DOCTYPE html>
<html>

<head>
	<!-- Ckeditor 的 CSS (for CourseInfo)-->
	<link rel="stylesheet" href="<%=request.getContextPath()%>/front-end\course\css\ckeditorForCourseInfo.css">

	<!-- This page's CSS -->
	<style type="text/css">
		#picturePreview {
			text-align: center;
		}
	</style>
</head>

<body>
	<%-- 錯誤表列 --%>
	<c:if test="${not empty errorMsgs}">
		<font style="color: red">請修正以下錯誤:</font>
		<ul>
			<c:forEach var="message" items="${errorMsgs}">
				<li style="color: red">${message}</li>
			</c:forEach>
		</ul>
	</c:if>

	<form METHOD="post" id="courseInfoForm" ACTION="<%=request.getContextPath()%>/course/course.do" name="form1" enctype="multipart/form-data">
		<input type="hidden" name="courseno" value="${courseVO.courseno}">
		<input type="hidden" name="tchrno" value="${courseVO.tchrno}">
		<input type="hidden" name="ttltime" value="${courseVO.ttltime}">
		<input type="hidden" name="csstatus" value="${courseVO.csstatus}">
		<input type="hidden" name="csscore" value="${courseVO.csscore}">
		<input type="hidden" name="csscoretimes" value="${courseVO.csscoretimes}">

		<jsp:useBean id="courseSvc" scope="page" class="com.course.model.CourseService" />
		<jsp:useBean id="courseTypeSvc" scope="page" class="com.course_type.model.CourseTypeService" />

		<div class="input-group mb-3">
			<div class="input-group-prepend">
				<span class="input-group-text">課程名稱</span>
			</div>
			<input type="text" class="form-control" aria-label="Sizing example input"
				name="coursename" value="<%=(courseVO == null) ? "老師很懶不取名" : courseVO.getCoursename()%>">
		</div>

		<div class="input-group mb-3">
			<div class="input-group-prepend">
				<label class="input-group-text">課程類別</label>
			</div>
			<select class="custom-select" name="cstypeno">
				<option value="">請選擇...</option>
				<c:forEach var="courseTypeVO" items="${courseTypeSvc.all}">
					<option value="${courseTypeVO.cstypeno}" ${courseVO.cstypeno==courseTypeVO.cstypeno ? 'selected' : '' }>
						${courseTypeVO.cstypename}
				</c:forEach>
			</select>
		</div>

		<div class="input-group mb-3">
			<div class="input-group-prepend">
				<span class="input-group-text">課程單價</span>
			</div>
			<input type="number" class="form-control"
				min="0" max="999999" step="1"
				name="courseprice" value="<%=(courseVO == null) ? 0 : courseVO.getCourseprice()%>">
		</div>

		<div class="input-group mb-3">
			<div class="input-group-prepend">
				<span class="input-group-text" id="inputGroupFileAddon01">課程圖片</span>
			</div>
			<div class="custom-file">
				<input type="file" class="custom-file-input" id="fileUp" name="courseimg">
				<label class="custom-file-label" for="fileUp"> 建議圖片比例 4 : 3</label>
			</div>
		</div>

		<div id="picturePreview">
			<img src="<%=request.getContextPath()%>/course/CoursePictureReaderFromDB?courseno=${courseVO.courseno}" style="max-width:100%;height:300px;">
		</div>
		<br>


		<div class="input-group mb-3">
			<div class="input-group-prepend">
				<span class="input-group-text">課程資訊</span>
			</div>
			<textarea id="ckeditor5" name="courseinfo" class="form-control" aria-label="With textarea">
				${courseVO.courseinfo}
			</textarea>
		</div>

		<br>
		<input type="hidden" name="action" value="update">
		<button type="submit" class="btn btn-lg btn-primary btn-block">送出修改</button>
		<!-- 		<input type="submit" value="送出修改"> -->
	</form>


	<!-- ========== JavaScript Area ========== -->
	<!-- 關於讀取圖片 -->
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

							var div = document.getElementById('picturePreview');
							div.innerHTML = "";
							var img = document.createElement('img');

							img.setAttribute('src', event.target.result);
							img.setAttribute('style', "max-width:100%;height:300px;");

							if (fileUp.nextElementSibling) { //只給上傳一張
								fileUp.nextElementSibling.remove();
							}

							div.append(img);
						});
						reader.readAsDataURL(file);
					} else {
						var div = document.getElementById('picturePreview');
						div.innerHTML = "";
						files = null;
						alert("僅支援圖片類型檔案");
					}
				}
			}
		});
	</script>

	<!-- =============== Ckeditor 5 =============== -->
	<script src="<%=request.getContextPath()%>\library\ckeditor5-build-classic\ckeditor.js"></script>
	<script>
		ClassicEditor
			.create(document.querySelector('#ckeditor5'), {
				toolbar: ['heading', '|', 'bold', 'italic', 'bulletedList', 'numberedList']
			})
			.then(editor => {
				console.log(editor);
			})
			.catch(error => {
				console.error(error);
			});
	</script>
	<!-- =============== Ckeditor 5 =============== -->

	<script>
		// 更新單一課程的基本資訊
		function updateCourseInfo() {
			var formData = new FormData($("#courseInfoForm")[0]);
			// 			for (var key of formData.keys()) {
			// 				console.log(key + " : " + formData.get(key));
			// 			}

			$.ajax({
				url: "<%=request.getContextPath()%>/course/course.do",
				type: "POST",
				data: formData,
				// 告訴jQuery不要去處理發送的資料
				processData: false,
				// 告訴jQuery不要去設定Content-Type請求頭
				contentType: false,
				success: function (data) { // 以上成功才執行
					console.log("成功");;
				},
				error: function (data) {
					console.log("失敗");
				},
				complete: function () {
					location.reload(true);
				}
			})
		}
	</script>

	<!-- ========== JavaScript Area ========== -->


</body>

</html>