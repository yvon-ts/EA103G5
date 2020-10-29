<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="com.members.model.*"%>
<%@ page import="com.teacher.model.*"%>


<jsp:useBean id="teacherSvc" scope="page"
	class="com.teacher.model.TeacherService" />


<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>Xducation-會員修改</title>

<!-- Font Icon -->
<link rel="stylesheet"
	href="fonts/material-icon/css/material-design-iconic-font.min.css">

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/6.10.3/sweetalert2.css" />
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/6.10.3/sweetalert2.js"
	type="text/javascript"></script>

<!-- Main css -->
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/index/front-index/assets/fonts/line-icons.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/front-end/members/signIn&updateMembers_css/style.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/front-end/members/nav_css_ForUpdateMembers/css/bootstrap.min.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/front-end/members/nav_css_ForUpdateMembers/css/nivo-lightbox.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/front-end/members/nav_css_ForUpdateMembers/css/animate.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/front-end/members/nav_css_ForUpdateMembers/css/main.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/front-end/members/nav_css_ForUpdateMembers/css/responsive.css">
</head>
<style type="text/css">
textarea {
	width: 300px;
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
	margin-top: 50px;
}

div.signup-form {
	width: 600px;
	margin-right: 5px;
}

div.signup-content {
	height: 650px;
}

h5.h5 {
	color: black;
}

div#logo {
	padding-top: 12px;
}

input.input {
	padding: 0px;
	margin: auto;
}

img#mprofile {
	-webkit-box-shadow: 3px 3px 5px 5px #BEBEBE;
	-moz-box-shadow: 3px 3px 5px 5px #BEBEBE;
	box-shadow: 3px 3px 5px 5px #BEBEBE;
	width: 350px;
	height: 350px;
	margin-left: -50px;
	margin-top: 30px;
	boder-radius: 10px;
	border-radius: 60px;
}

div.signup-image {
	width: 500px;
	margin: 60px 0px 0px -60px;
}

.signup {
	margin-bottom: 50px;;
}

th#mpic {
	padding-top: 0px;
}

div#bg {
	-webkit-box-shadow: 0 0 15px #8E8E8E;
	-moz-box-shadow: 0 0 15px #8E8E8E;
	box-shadow: 0 0 15px #5B5B5B;
}

input#register.form-submit {
	margin-left: 70px;
}

h5#regdate {
	margin-left: -140px;
}

figure#a_mprofile {
	margin-left: 50px;
	margin-top: 30px;
}

img#nav_icon {
	width: 36px;
	height: 36px;
}

.toggle-wrapper {
	position: absolute;
	top: 50%;
	left: 50%;
	-webkit-transform: translate(-50%, -50%);
	transform: translate(-50%, -50%);
	width: 5rem;
	height: 2.5rem;
	font-family: sans-serif;
	font-size: 0.75rem;
	font-weight: 100;
}

.toggle {
	display: none;
}

.foux-toggle {
	position: relative;
	width: 5rem;
	height: 2.5rem;
	border-radius: 2.5rem;
	margin: -120px 0 0 -130px;
	border-width: 1px;
	border-style: solid;
	border-color: #E4E4E4;
	background-color: #F7F7F7;
	-webkit-transition: background-color 0.2s
		cubic-bezier(0.34, 0.93, 0.85, 0.91);
	transition: background-color 0.2s cubic-bezier(0.34, 0.93, 0.85, 0.91);
}

.foux-toggle:before {
	content: "";
	position: absolute;
	top: 0.25rem;
	left: 0.3125rem;
	display: block;
	width: 1.875rem;
	height: 1.875rem;
	border-radius: 1.875rem;
	background-color: white;
	box-shadow: 0 2px 4px 0 rgba(0, 0, 0, 0.2);
	-webkit-transition: left 0.2s cubic-bezier(0.34, 0.93, 0.85, 0.91);
	transition: left 0.2s cubic-bezier(0.34, 0.93, 0.85, 0.91);
}

.toggle:checked ~ .foux-toggle {
	border-color: #0099CC;
	background-color: #0099CC;
	margin: -120px 0 0 -130px;
}

.toggle:checked ~ .foux-toggle:before {
	left: 2.75rem;
}

.toggle--label:before, .toggle--label:after {
	position: absolute;
	top: 0;
	bottom: 0;
	-webkit-transition: opacity 0.4s linear;
	transition: opacity 0.4s linear;
}

.toggle--label {
	position: absolute;
	top: 0;
	right: 0;
	bottom: 0;
	left: 0;
	text-align: center;
	line-height: 2.5rem;
	cursor: pointer;
	z-index: 10;
	letter-spacing: 0.0625rem;
}

.toggle--label:before {
	content: 'On';
	right: 40%;
	left: 0;
	color: white;
	opacity: 0;
	margin: -101px 0 0 -250px;
}

.toggle:checked+.toggle--label:before {
	opacity: 1;
}

.toggle--label:after {
	content: 'Off';
	position: absolute;
	right: 0;
	left: 40%;
	opacity: 1;
	margin: -102px 0 0 -260px;
}

.toggle:checked+.toggle--label:after {
	opacity: 0;
	-webkit-transition-duration: 0.05s;
	transition-duration: 0.05s;
}

html {
	background-color: #FBFBFB;
}

body {
	font-family: 'Gochi Hand';
}

div.main {
	font-size: 15px;
	padding: 150px 0 0 0;
	background:
		url("<%=request.getContextPath()%>/front-end/members/assets/img/bgPic.png");
}
</style>
<body>
	<nav
		class="navbar navbar-expand-md bg-inverse fixed-top scrolling-navbar">
		<div class="container">
			<!-- Brand and toggle get grouped for better mobile display -->
			<a href="<%=request.getContextPath()%>/index/front-index/index.jsp"
				class="navbar-brand"><img
				src="<%=request.getContextPath()%>/front-end/members/assets/img/logo.svg"
				alt="">
				<div id="logo">Xducation</div> </a>
			<button class="navbar-toggler" type="button" data-toggle="collapse"
				data-target="#navbarCollapse" aria-controls="navbarCollapse"
				aria-expanded="false" aria-label="Toggle navigation">
				<i class="lni-menu"></i>
			</button>
			<div class="collapse navbar-collapse" id="navbarCollapse">
				<ul class="navbar-nav mr-auto w-100 justify-content-end clearfix">
					<li class="nav-item"><a class="nav-link"
						href="<%=request.getContextPath()%>/front-end/tracking_list/listTrackingListForUser.jsp">
							購物車&nbsp;<i class="lni lni-cart"></i>
					</a></li>
					<li class="nav-item"><a class="nav-link"
						href="<%=request.getContextPath()%>/front-end/course/listAllCourseForUser.jsp">
							搜尋課程&nbsp;<i class="lni-leaf"></i>
					</a></li>
					<li class="nav-item"><a class="nav-link"
						href="<%=request.getContextPath()%>/front-end/lecture/listAllLec.jsp">
							名人講座&nbsp;<i class="lni-bulb"></i>
					</a></li>
					<c:if
						test="${teacherSvc.getStatus(sessionScope.loginMembersVO.memno).tchrstatus eq '已通過'}">
						<li class="nav-item"><a class="nav-link"
							href="<%=request.getContextPath()%>/front-end/course/addCourse.jsp">
								我要開課&nbsp;<i class="lni lni-display"></i>
						</a></li>
					</c:if>





					<c:if test="${not empty sessionScope.loginMembersVO}">
						<li class="nav-item">
							<div class="dropdown" id="dropdown">
								<button class="btn btn-secondary dropdown-toggle" type="button"
									id="dropdownMenuButton" data-toggle="dropdown"
									aria-haspopup="true" aria-expanded="false">
									${sessionScope.loginMembersVO.memname}</button>
								<div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
									<a class="dropdown-item"
										href="<%=request.getContextPath()%>/front-end/members/updateMembersV2.jsp">個人檔案</a>

									<a class="dropdown-item"
										href='<%=request.getContextPath()%>/front-end/Order_Master/listAllByMemno.jsp'>課程訂單紀錄</a>

									<a class="dropdown-item"
										href='<%=request.getContextPath()%>/front-end/coup_code/listAllByMemno.jsp'>持有折扣券</a>


									<c:if
										test="${teacherSvc.getStatus(sessionScope.loginMembersVO.memno).tchrstatus eq '待審核'}">
										<a class="dropdown-item" onclick="status()">老師檔案</a>

									</c:if>
									<c:if
										test="${teacherSvc.getStatus(sessionScope.loginMembersVO.memno).tchrstatus eq '已通過'}">
										<a class="dropdown-item"
											href="<%=request.getContextPath()%>/front-end/teacher/teacherDisplay.jsp">老師檔案</a>

									</c:if>
									<c:if
										test="${teacherSvc.getStatus(sessionScope.loginMembersVO.memno).tchrstatus eq '未通過'}">
										<a class="dropdown-item"
											href="<%=request.getContextPath()%>/front-end/teacher/teacherUpdate.jsp">老師檔案</a>

									</c:if>
									<c:if test="${not empty sessionScope.loginMembersVO}">
										<a class="dropdown-item"
											href='<%=request.getContextPath()%>/members/members.do?action=signout'>會員登出</a>
									</c:if>






								</div>
							</div>

						</li>

					</c:if>
					<c:if test="${not empty sessionScope.loginMembersVO.memno}">

						<c:if
							test="${teacherSvc.getStatus(sessionScope.loginMembersVO.memno).tchrstatus eq '待審核'}">
							<img id="nav_icon"
								src='<%=request.getContextPath()%>/front-end/members/assets/img/students.svg'>
						</c:if>

						<c:if
							test="${teacherSvc.getStatus(sessionScope.loginMembersVO.memno).tchrstatus eq '已通過'}">
							<img id="nav_icon"
								src='<%=request.getContextPath()%>/front-end/members/assets/img/teacher.svg'>
						</c:if>
						<c:if
							test="${teacherSvc.getStatus(sessionScope.loginMembersVO.memno).tchrstatus eq '未通過'}">
							<img id="nav_icon"
								src='<%=request.getContextPath()%>/front-end/members/assets/img/students.svg'>

						</c:if>
					</c:if>


					<c:if test="${empty sessionScope.loginMembersVO}">
						<li class="nav-item"><a class='nav-link'
							href='<%=request.getContextPath()%>/front-end/members/signIn.jsp'>我要登入&nbsp;<i
								class="lni lni-rocket"></i></a></li>
					</c:if>


				</ul>
			</div>
		</div>
	</nav>

	<div class="main">

		<!-- Sign up form -->
		<section class="signup">
			<c:if test="${not empty errorMsgs}">
				<c:forEach var="message" items="${errorMsgs}">
					<input type="hidden" id="message" value="${message}">
				</c:forEach>

			</c:if>
			<form method='POST' class='register-form'
				ACTION='<%=request.getContextPath()%>/members/members.do'
				id='register-form' enctype='multipart/form-data'>

				<div class="container" id="bg">
					<div class="signup-content">
						<div class="signup-form">

							<h2 class="form-title">
								<img id="pic"
									src="<%=request.getContextPath()%>/front-end/members/signIn&updateMembers_css/images/membership.svg">${loginMembersVO.nkname}-個人檔案</h2>

							<!-- <div class="toggle-wrapper">
								<input id="provide-muffins" name="provide_muffins"
									class="toggle" type="checkbox" checked /><label
									for="provide-muffins" class="toggle--label"></label>
								<div class="foux-toggle"></div>
							</div> -->


							<table>
								<tr>
									<th>
										<div class="form-group">
											<h5 class="h5">
												會員姓名<img class="pic"
													src="<%=request.getContextPath()%>/front-end/members/signIn&updateMembers_css/images/id-card.svg">
											</h5>



										</div>
									</th>
									<th><div style="width: 100px"></div></th>
									<th>
										<div class="form-group">
											<h5 class="h5">
												會員電話<img class="pic"
													src="<%=request.getContextPath()%>/front-end/members/signIn&updateMembers_css/images/iphone.svg">
											</h5>
										</div>
									</th>
								</tr>
								<tr>
									<td>
										<p>${loginMembersVO.memname}</p>
									</td>
									<th></th>
									<td>
										<p>${loginMembersVO.mphone}</p>
									</td>

								</tr>
								<tr>
									<td style="color: #FFF">" "</td>
								</tr>
								<tr>
									<th>
										<div class="form-group">
											<h5 class="h5">
												會員生日<img class="pic"
													src="<%=request.getContextPath()%>/front-end/members/signIn&updateMembers_css/images/birthday-present.svg">
											</h5>



										</div>
									</th>
									<th><div style="width: 100px"></div></th>
									<th>
										<div class="form-group">
											<h5 class="h5">
												會員電郵<img class="pic"
													src="<%=request.getContextPath()%>/front-end/members/signIn&updateMembers_css/images/new-email.svg">
											</h5>
										</div>
									</th>
								</tr>
								<tr>
									<td>
										<p>${loginMembersVO.membday}</p>
									</td>
									<th></th>
									<td>
										<p>${loginMembersVO.memail}</p>
									</td>

								</tr>
								<tr>
									<td style="color: #FFF">" "</td>
								</tr>
								<tr>
									<th id="mpic"><div class="form-group">
											<h5 class="h5">
												<div style="color: #FFF">"</div>
												<label> <input onchange="readURL(this)"
													targetID="mprofile" style="display: none;" type="file"
													id="picture" name="picture" placeholder="Your Profile" />
													會員頭像<img class="pic"
													src="<%=request.getContextPath()%>/front-end/members/signIn&updateMembers_css/images/pictures.svg">
												</label>
											</h5>

										</div></th>
									<th><div style="width: 100px"></div></th>

									<th><div class="form-group">

											<h5 class="h5">
												會員暱稱<img class="pic"
													src="<%=request.getContextPath()%>/front-end/members/signIn&updateMembers_css/images/nickname.svg">
											</h5>
										</div> <input class="input" name='nkname' type="text"
										value="${loginMembersVO.nkname}" placeholder="Your nickname" /></th>
								<tr>
									<td>點選上傳.....⤴</td>
								</tr>
								<tr>
									<td style="color: #FFF">" "</td>
								</tr>
								<tr>
									<td style="color: #FFF">" "</td>
								</tr>



								<tr>
									<th>
										<div class="form-group">
											<h5 class="h5">
												會員密碼<img class="pic"
													src="<%=request.getContextPath()%>/front-end/members/signIn&updateMembers_css/images/password.svg">
											</h5>



										</div>
										<input class="input" name='mempwd' type="password"
										placeholder="Your password" />
									</th>
									<th><div style="width: 100px"></div></th>
									<th>
										<div class="form-group">
											<h5 class="h5">
												確認密碼<img class="pic"
													src="<%=request.getContextPath()%>/front-end/members/signIn&updateMembers_css/images/Rmempwd.svg">
											</h5>
										</div>
										<input class="input" name='Rmempwd' type="password"
										placeholder="Password again" />
									</th>
								</tr>

							</table>


						</div>
						<div class="signup-image">
							<figure id='a_mprofile'>
								<img id='mprofile' class="pimg"
									src="<%=request.getContextPath()%>/front-end/members/MprofileDisplayServlet?MEMNO=${loginMembersVO.memno}"
									alt="sing up image">
								<input type='hidden' name='action' value='updatemembers'>
								<input type="submit" style="font-family: 'Gochi Hand'"
									id="register" name="signup" id="signup" class="form-submit"
									value="Update" />

							</figure>



							<h5 id='regdate' style="text-align: center; color: black">
								<img class="pic"
									src="<%=request.getContextPath()%>/front-end/members/signIn&updateMembers_css/images/join.svg">註冊會員日期:
								<fmt:formatDate value="${loginMembersVO.regdate}" type="date"
									dateStyle="full" />
							</h5>

						</div>





					</div>

				</div>
			</form>

			<input type="hidden" id="inform4" value="${requestScope.inform4}">

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
     function status(){
 		
		 swal('老師資格審核中', '請耐心等候1~3個工作天，一但審核完畢，即會立刻通知', 'info');
	}
	
     var inform4 = document.getElementById('inform4').value;
  	if(inform4 ==='200'){
  		swal('已成功更新', '您的個人檔案!', 'success');
  	}
    
     var message = document.getElementById('message').value;
     if(message.length !== 0){
    	 swal('注意', message, 'warning');
     }
     $(function(){  
         $(".pimg").click(function(){  
             var _this = $(this);//將當前的pimg元素作為_this傳入函式  
             imgShow("#outerdiv", "#innerdiv", "#bigimg", _this);  
         });  
     });  

     function imgShow(outerdiv, innerdiv, bigimg, _this){  
         var src = _this.attr("src");//獲取當前點選的pimg元素中的src屬性  
         $(bigimg).attr("src", src);//設定#bigimg元素的src屬性  
       
             /*獲取當前點選圖片的真實大小，並顯示彈出層及大圖*/  
         $("<img/>").attr("src", src).load(function(){  
             var windowW = $(window).width();//獲取當前視窗寬度  
             var windowH = $(window).height();//獲取當前視窗高度  
             var realWidth = this.width;//獲取圖片真實寬度  
             var realHeight = this.height;//獲取圖片真實高度  
             var imgWidth, imgHeight;  
             var scale = 0.8;//縮放尺寸，當圖片真實寬度和高度大於視窗寬度和高度時進行縮放  
               
             if(realHeight>windowH*scale) {//判斷圖片高度  
                 imgHeight = windowH*scale;//如大於視窗高度，圖片高度進行縮放  
                 imgWidth = imgHeight/realHeight*realWidth;//等比例縮放寬度  
                 if(imgWidth>windowW*scale) {//如寬度扔大於視窗寬度  
                     imgWidth = windowW*scale;//再對寬度進行縮放  
                 }  
             } else if(realWidth>windowW*scale) {//如圖片高度合適，判斷圖片寬度  
                 imgWidth = windowW*scale;//如大於視窗寬度，圖片寬度進行縮放  
                             imgHeight = imgWidth/realWidth*realHeight;//等比例縮放高度  
             } else {//如果圖片真實高度和寬度都符合要求，高寬不變  
                 imgWidth = realWidth;  
                 imgHeight = realHeight;  
             }  
                     $(bigimg).css("width",imgWidth);//以最終的寬度對圖片縮放  
               
             var w = (windowW-imgWidth)/2;//計算圖片與視窗左邊距  
             var h = (windowH-imgHeight)/2;//計算圖片與視窗上邊距  
             $(innerdiv).css({"top":h, "left":w});//設定#innerdiv的top和left屬性  
             $(outerdiv).fadeIn("fast");//淡入顯示#outerdiv及.pimg  
         });  
           
         $(outerdiv).click(function(){//再次點選淡出消失彈出層  
             $(this).fadeOut("fast");  
         });  
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