<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.members.model.*"%>

<%@ include file="/index/front-index/header.jsp"%>



<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>Xducation-老師修改</title>

<!-- Font Icon -->
<link rel="stylesheet"
	href="fonts/material-icon/css/material-design-iconic-font.min.css">

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/6.10.3/sweetalert2.css" />
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/6.10.3/sweetalert2.js"
	type="text/javascript"></script>
<script
	src="https://cdn.ckeditor.com/ckeditor5/23.0.0/classic/ckeditor.js"></script>


<link rel="stylesheet"
	href="<%=request.getContextPath()%>/front-end/teacher/teacherRegister_css/style.css">
<%--     <link rel="stylesheet" href="<%=request.getContextPath()%>/front-end/teacher/nav_css_ForTeacherRegister/css/bootstrap.min.css"> --%>
<%--     <link rel="stylesheet" href="<%=request.getContextPath()%>/front-end/teacher/nav_css_ForTeacherRegister/css/nivo-lightbox.css"> --%>
<%--     <link rel="stylesheet" href="<%=request.getContextPath()%>/front-end/teacher/nav_css_ForTeacherRegister/css/animate.css"> --%>
<%--     <link rel="stylesheet" href="<%=request.getContextPath()%>/front-end/teacher/nav_css_ForTeacherRegister/css/main.css"> --%>
<%--     <link rel="stylesheet" href="<%=request.getContextPath()%>/front-end/teacher/nav_css_ForTeacherRegister/css/responsive.css"> --%>
</head>
<style type="text/css">
textarea {
	width: 280px;
	height: 100px;
}

#pic {
	width: 53px;
	height: 53px;
}

img.pic {
	width: 36px;
	height: 36px;
}

h2.form-title {
	width: 400px;
}

div.signup-form {
	width: 400px;
	margin-right: 5px;
}

h5.h5 {
	color: black;
}
div.ck-rounded-corners .ck.ck-editor__main>.ck-editor__editable, .ck.ck-editor__main>.ck-editor__editable.ck-rounded-corners {
    height: 200px;
    width:300px;
}
 .ck-rounded-corners .ck.ck-editor__top .ck-sticky-panel .ck-toolbar, .ck.ck-editor__top .ck-sticky-panel .ck-toolbar.ck-rounded-corners {
    border-radius: var(--ck-border-radius);
    border-bottom-left-radius: 0;
    border-bottom-right-radius: 0;
    width: 300px;
}

div#form-group {
	height: 35px;
}

input#name {
	width: 230px;
}

label#cert {
	width: 250px;
}

div#bg {
	-webkit-box-shadow: 0 0 15px #8E8E8E;
	-moz-box-shadow: 0 0 15px #8E8E8E;
	box-shadow: 0 0 15px #5B5B5B;
}

figure.license {
	width: 200px;
	height: 200px;
	margin: auto;
}

img#license1 {
	margin-bottom: 40px;
	margin-top: 0px;
	-webkit-box-shadow: 3px 3px 5px 5px #BEBEBE;
	-moz-box-shadow: 3px 3px 5px 5px #BEBEBE;
	box-shadow: 3px 3px 5px 5px #BEBEBE;
}

img#license2 {
	margin-top: 40px;
	-webkit-box-shadow: 3px 3px 5px 5px #BEBEBE;
	-moz-box-shadow: 3px 3px 5px 5px #BEBEBE;
	box-shadow: 3px 3px 5px 5px #BEBEBE;
}

div.signup-image {
	margin: 0px 50px;
}

input#signup.form-submit {
	margin-top: 75px;
	margin-left: 125px;
}

.signup {
	margin-bottom: 50px;;
}

div.main {
	padding: 150px 0 0 0;
	background:
		url("<%=request.getContextPath()%>/front-end/members/assets/img/bgPic.png");
}
</style>
<body>
	<!--     <nav class="navbar navbar-expand-md bg-inverse fixed-top scrolling-navbar"> -->
	<!--             <div class="container"> -->
	<!--                 左上角LOGO Start -->
	<%--                 <a href="<%=request.getContextPath()%>/front-end/members/indexV1.jsp" class="navbar-brand"><img src="nav_css_ForTeacherRegister/img/logo.svg" alt=""> --%>
	<!--                     <div id="logo">Xducation</div> -->
	<!--                 </a> -->
	<!--                 左上角LOGO End -->
	<!--                 <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarCollapse" aria-controls="navbarCollapse" aria-expanded="false" aria-label="Toggle navigation"> -->
	<!--                     <i class="lni-menu"></i> -->
	<!--                 </button> -->
	<!--                 <div class="collapse navbar-collapse" id="navbarCollapse"> -->
	<!--                     <ul class="navbar-nav mr-auto w-100 justify-content-end clearfix"> -->
	<!--                         <li class="nav-item"> -->
	<!--                             <a class="nav-link" href="#"> -->
	<!--                                 進入搜尋&nbsp;<i class="lni-search"></i> -->
	<!--                             </a> -->
	<!--                         </li> -->
	<!--                         <li class="nav-item"> -->
	<!--                             <a class="nav-link" href="#"> -->
	<!--                                 精選課程&nbsp;<i class="lni-leaf"></i> -->
	<!--                             </a> -->
	<!--                         </li> -->
	<!--                         <li class="nav-item"> -->
	<!--                             <a class="nav-link" href="#"> -->
	<!--                                 名人講座&nbsp;<i class="lni-bulb"></i> -->
	<!--                             </a> -->
	<!--                         </li> -->

	<!--                        <li class="nav-item"> -->
	<%--                             <a class="nav-link" href="<%=request.getContextPath()%>/front-end/members/signIn.jsp" style="color: #0099CC"> --%>
	<!--                                 我要登入&nbsp;<i class="lni-home"></i> -->
	<!--                             </a> -->
	<!--                         </li> -->
	<!--                         已登入 End -->
	<!--                     </ul> -->
	<!--                 </div> -->
	<!--             </div> -->
	<!--         </nav> -->

	<div class="main">
		<input type="hidden" id="starter"
			value="${teacherSvc.getOneTeacher(teacherSvc.getStatus(membersVO.memno).tchrno).rejreason}">


		<!-- Sign up form -->
		<section class="signup">
			<div class="container" id="bg">
				<div class="signup-content">


					<div class="signup-form">

						<h2 class="form-title">
							再次遞交申請<img id="pic"
								src="<%=request.getContextPath()%>/front-end/teacher/teacherRegister_css/images/teacher.svg">
						</h2>
						<form method="POST"
							action="<%=request.getContextPath()%>/teacher/teacher.do"
							enctype='multipart/form-data'>
							<div class="form-group">
								<h5 class="h5">
									你的銀行帳號<img class="pic"
										src="<%=request.getContextPath()%>/front-end/teacher/teacherRegister_css/images//bank-account.svg">
								</h5>

								<input type="text" name="bankacc" id="name"
									placeholder="只能輸入數字，限制20字"
									value="${teacherSvc.getOneTeacher(teacherSvc.getStatus(membersVO.memno).tchrno).bankacc}" />


							</div>
							<div class="form-group">
								<h5 class="h5">
									你的專業證照<img class="pic"
										src="<%=request.getContextPath()%>/front-end/teacher/teacherRegister_css/images/certification.svg">
								</h5>


							</div>
							<div class="form-group" id="form-group">
								<label id="cert">點選上傳證照1 <img class="pic"
									src="<%=request.getContextPath()%>/front-end/teacher/teacherRegister_css/images/pictures.svg"><input
									onchange="readURL(this)" targetID="license1"
									style="display: none;" type="file" name="tchrcert1"
									style="display:none;" id="tchrcert" /></label>
							</div>
							<div class="form-group" id="form-group">
								<label id="cert">點選上傳證照2 <img class="pic"
									src="<%=request.getContextPath()%>/front-end/teacher/teacherRegister_css/images/pictures.svg"><input
									onchange="readURL(this)" targetID="license2"
									style="display: none;" type="file" name="tchrcert2"
									style="display:none;" id="tchrcert" /></label>
							</div>
							<div class="form-group">
								<h5 class="h5">
									你的個人介紹<img class="pic"
										src="<%=request.getContextPath()%>/front-end/teacher/teacherRegister_css/images/reunion.svg">
								</h5>

								<div id="text">
									<textarea id="editor" name="tchrintro"
										placeholder="資料的詳細度將會影響審核成功的機率，祝好運">${sessionScope.teacherVO.tchrintro}</textarea>
								</div>
							</div>

							<div class="form-group">
								<c:if test="${not empty errorMsgs}">
									<ul>
										<c:forEach var="message" items="${errorMsgs}">
											<li style="color: red">${message}</li>
										</c:forEach>
									</ul>
								</c:if>

							</div>
					</div>


					<div class="signup-image">

						<figure class='license'>
							<img id="license1" class="certification"
								src="<%=request.getContextPath()%>/front-end/teacher/TchrcertDisplayServlet1?TCHRNO=${teacherSvc.getStatus(membersVO.memno).tchrno}">
						</figure>
						<figure class='license'>
							<img id="license2" class="certification"
								src="<%=request.getContextPath()%>/front-end/teacher/TchrcertDisplayServlet2?TCHRNO=${teacherSvc.getStatus(membersVO.memno).tchrno}">
						</figure>
						<input type="hidden" name="action" value="updateTeacher">
						<input type='hidden' name='tchrno'
							value='${teacherSvc.getOneTeacher(teacherSvc.getStatus(membersVO.memno).tchrno).tchrno}'>
						<input type="submit" name="signup" id="signup" class="form-submit"
							value="提交" />
						</form>
					</div>


				</div>

			</div>


		</section>
		<footer id="footer">
			<section id="copyright" class="">
				<div>
					<div>
						<div>
							<div class="copyright-content">
								Xducation
								<p>
									<a href="#">關於我們</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="#">其他服務</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a
										href="#">網站地圖</a>
								</p>
							</div>
						</div>
					</div>
				</div>
			</section>
		</footer>


	</div>

	<!-- JS -->
	<script type="text/javascript">
    ClassicEditor
    .create(document.querySelector('#editor'))
    .then(editor => {
        console.log(editor);
    })
    
    
    
    
    var starter = document.getElementById("starter").value;
    if(starter.length!==0){
    	console.log(starter);
    	swal('審核結果:條件不符', '原因:' + starter, 'error');
    }
  
   
    
    
    
        function readURL(input){

        	  if(input.files && input.files[0]){

        	    var imageTagID = input.getAttribute("targetID");

        	    var reader = new FileReader();

        	    reader.onload = function (e) {

        	       var img = document.getElementById(imageTagID);

        	       img.setAttribute("src", e.target.result)

        	    }

        	    reader.readAsDataURL(input.files[0]);

        	  }

        	}
    </script>

</body>
<!-- This templates was made by Colorlib (https://colorlib.com) -->
</html>