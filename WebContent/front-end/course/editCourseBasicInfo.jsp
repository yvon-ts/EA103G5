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

	<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/course/course.do" name="form1" enctype="multipart/form-data">
		<input type="hidden" name="courseno" value="${courseVO.courseno}">
		<input type="hidden" name="tchrno" value="${courseVO.tchrno}">
		<input type="hidden" name="ttltime" value="${courseVO.ttltime}">
		<input type="hidden" name="csstatus" value="${courseVO.csstatus}">
		<input type="hidden" name="csscore" value="${courseVO.csscore}">
		<input type="hidden" name="csscoretimes" value="${courseVO.csscoretimes}">
		
<!-- 		<table> -->
<%-- 			<jsp:useBean id="courseSvc" scope="page" class="com.course.model.CourseService"/> --%>
<!-- 			<tr> -->
<!-- 				<td>課程名稱:</td> -->
<!-- 				<td><input type="text" name="coursename" size="45" -->
<%-- 					value="${courseVO.coursename }"/></td> --%>
<!-- 			</tr> -->
<!-- 			<tr> -->
<%-- 				<jsp:useBean id="courseTypeSvc" scope="page" class="com.course_type.model.CourseTypeService" /> --%>
<!-- 				<td> -->
<!-- 					<span>課程類別：</span> -->
<!-- 				</td> -->
<!-- 				<td> -->
<!-- 					<select name="cstypeno"> -->
<%-- 						<c:forEach var="courseTypeVO" items="${courseTypeSvc.all}"> --%>
<%-- 							<option value="${courseTypeVO.cstypeno}" ${courseVO.cstypeno == courseTypeVO.cstypeno ? "selected" : ""}> --%>
<%-- 								${courseTypeVO.cstypename} --%>
<%-- 						</c:forEach> --%>
<!-- 					</select> -->
<!-- 				</td> -->
<!-- 			</li> -->
<!-- 			</tr> -->
<!-- 			<tr> -->
<!-- 				<td>課程單價:</td> -->
<!-- 				<td><input type="number" name="courseprice" size="45" -->
<%-- 					value="${courseVO.courseprice}" /></td> --%>
<!-- 			</tr> -->
<!-- 			<tr> -->
<!-- 				<td>課程資訊:</td> -->
<!-- 				<td> -->
<%-- 					<textarea name="courseinfo" rows="10" cols="50">${courseVO.courseinfo}</textarea> --%>
<!-- 				</td> -->
<!-- 			</tr> -->
<!-- 		</table> -->

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
								<input type="file" class="custom-file-input" id="fileUp"
									name="courseimg">
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
						<textarea name="courseinfo" class="form-control" aria-label="With textarea">${courseVO == null ? "<h1>你可以學到...</h1>" : courseVO.courseinfo}</textarea>
					</div>



		<br>
		<input type="hidden" name="action" value="update">
		<button type="submit" class="btn btn-lg btn-primary btn-block">送出修改</button>
<!-- 		<input type="submit" value="送出修改"> -->
	</FORM>
	
	
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
	
	
	<!-- 關於 CK EDITER -->
	<script src="https://cdn.ckeditor.com/4.7.3/basic/ckeditor.js"></script>
	<script>
		function init() {
			CKEDITOR.replace("courseinfo", {
				width: 800,
				height: 300
			});
			CKEDITOR.editorConfig = function (config) {
				config.enterMode = CKEDITOR.ENTER_BR; //br換行
			};
		}
		window.onload = init;
	</script>
	<!-- ========== JavaScript Area ========== -->

</body>
</html>