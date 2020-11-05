<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.members.model.*"%>
<%@ page import="java.util.*"%>

<%
	Object account = session.getAttribute("loginMembersVO");
if (account != null) {
	session.setAttribute("location", request.getRequestURI());
	response.sendRedirect(request.getContextPath() + "/index/front-index/index.jsp");
}
%>


<%@ include file="/index/front-index/header.jsp"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>Xducation-會員登入</title>


<!-- Main css -->
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/front-end/members/signIn&updateMembers_css/style.css">
<%--     <link rel="stylesheet" href="<%=request.getContextPath()%>/front-end/members/nav_css_ForSignIn&addMembers/css/bootstrap.min.css"> --%>
<%--     <link rel="stylesheet" href="<%=request.getContextPath()%>/front-end/members/nav_css_ForSignIn&addMembers/css/nivo-lightbox.css"> --%>
<%--     <link rel="stylesheet" href="<%=request.getContextPath()%>/front-end/members/nav_css_ForSignIn&addMembers/css/animate.css"> --%>
<%--     <link rel="stylesheet" href="<%=request.getContextPath()%>/front-end/members/nav_css_ForSignIn&addMembers/css/main.css"> --%>
<%--     <link rel="stylesheet" href="<%=request.getContextPath()%>/front-end/members/nav_css_ForSignIn&addMembers/css/responsive.css"> --%>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/6.10.3/sweetalert2.css" />
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/6.10.3/sweetalert2.js"
	type="text/javascript"></script>
</head>

<style>
img.pic {
	-webkit-box-shadow: 3px 3px 5px 5px #BEBEBE;
	-moz-box-shadow: 3px 3px 5px 5px #BEBEBE;
	box-shadow: 3px 3px 5px 5px #BEBEBE;
	width: 350px;
	height: 350px;
	position: absolute;
	z-index: 1;
	margin-left: 30px;
	margin-top: 60px;
	boder-radius: 10px;
	border-radius: 20px;
}

.form-group {
	position: relative;
	margin-bottom: 10px;
	overflow: hidden;
}

h2.form-title {
	width: 600px;
	height: 200px;
	position: absolute;
	z-index: 1;
	font-size: 120px;
	font-family: 'Gochi Hand';
	margin: -240px 0 0 -30px;
}

.signup-image-link {
	font-size: 20px;
}

img.icon1 {
	width: 33px;
	height: 33px;
}

input.input {
	padding-left: 40px;
	width: 250px;
}

div#bg {
	width: -webkit-fill-available;
	height: 630px;
	-webkit-box-shadow: 0 0 15px #8E8E8E;
	-moz-box-shadow: 0 0 15px #8E8E8E;
	box-shadow: 0 0 15px #5B5B5B;
}

.signup {
	margin-bottom: 50px;;
}

input.input {
	font-family: 'Gochi Hand';
	font-size: 30px;
}
input.inputpwd {
	font-family: 'Gochi Hand';
	font-size: 30px;
	width: -webkit-fill-available;
	text-align:center;
}



div.signin-form {
	padding-top: 200px;
	padding-left: 10px;
}

div.signin-content {
	padding-top: 70px;
	padding-bottom: 0px;
}

a.signup-image-link {
	width: 300px;
	height: 100px;
	margin-top: 440px;
	margin-left: 45px;
}

#forgotpwd {
	padding: 10px;
	width: 125.66px;
	height: 66px;
	position: absolute;
	margin: -33px 0 0 215px;
	border: 1px;
	font-family: 'Gochi Hand';
	font-size: 20px;
	-webkit-transform: translate(-50%, -50%);
	-ms-transform: translate(-50%, -50%);
	-o-transform: translate(-50%, -50%);
	transform: translate(-50%, -50%);
	transition: ease .2s;
}

#add {
	margin: 15px 0 0 -3px;
	width: 130px;
	height: 40px;
	background: #0099CC;
	border: 1px;
	color: white;
	border-radius: 20px;
	cursor: pointer;
	font-family: 'Gochi Hand';
}

#add1 {
	margin: 15px 0 0 20px;
	width: 130px;
	height: 40px;
	background: #0099CC;
	border: 1px;
	color: white;
	border-radius: 20px;
	cursor: pointer;
	font-family: 'Gochi Hand';
}

.modal, .modal-box {
	z-index: 900;
}

.modal-sandbox {
	position: fixed;
	width: 100%;
	height: 100%;
	top: 0;
	left: 0;
	background: transparent;
}

.modal {
	display: none;
	position: fixed;
	width: 100%;
	height: 100%;
	left: 0;
	top: 0;
	background: rgb(0, 0, 0);
	background: rgba(0, 0, 0, .8);
	overflow: auto;
}

.modal-box {
	position: relative;
	width: 80%;
	max-width: 920px;
	margin: 100px auto;
	animation-name: modalbox;
	animation-duration: .4s;
	animation-timing-function: cubic-bezier(0, 0, .3, 1.6);
}

.modal-header {
	padding: 20px 40px;
	background: #0099CC;
	color: #ffffff;
}

.modal-body {
	background: #ECEFF1;
	padding: 60px 40px;
}

/* Close Button */
.close-modal {
	text-align: right;
	cursor: pointer;
}

/* Animation */
@
-webkit-keyframes modalbox { 0% {
	top: -250px;
	opacity: 0;
}

100
%
{
top
:
0;
opacity
:
1;
}
}
@
keyframes modalbox { 0% {
	top: -250px;
	opacity: 0;
}

100
%
{
top
:
0;
opacity
:
1;
}
}
div.main {
	padding: 150px 0 0 0;
	background:
		url("<%=request.getContextPath()%>/front-end/members/assets/img/bgPic.png");
}
</style>



<body>
	<!-- <nav class="navbar navbar-expand-md bg-inverse fixed-top scrolling-navbar"> -->
	<!--             <div class="container"> -->
	<!--                 左上角LOGO Start -->
	<%--                 <a href="<%=request.getContextPath()%>/front-end/members/indexV1.jsp" class="navbar-brand"><img src="<%=request.getContextPath()%>/front-end/members/nav_css_ForSignIn&addMembers/img/logo.svg" alt=""> --%>
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
		<section class="sign-in">
			<c:if test="${not empty errorMsgs}">
				<c:forEach var="message" items="${errorMsgs}">
					<input type="hidden" id="message" value="${message}">
				</c:forEach>

			</c:if>
			<div id="bg" class="container">
				<div class="signin-content">
					<div class="signin-image">
						<a
							href="<%=request.getContextPath()%>/index/front-index/index.jsp"><img
							class="pic"
							src="<%=request.getContextPath()%>/front-end/members/assets/img/head/02.png"
							alt="sing up image"></a> <a
							href="<%=request.getContextPath()%>/front-end/members/addMembersV2.jsp"
							class="signup-image-link" style="font-family: 'Gochi Hand'">Create
							an account</a>
					</div>

					<div class="signin-form">
						<h2 class="form-title">Sign in</h2>
						<form action="<%=request.getContextPath()%>/members/members.do"
							method="POST" class="register-form" id="login-form">

							<div class="form-group">
								<label for="your_name"><img class="icon1"
									src="<%=request.getContextPath()%>/front-end/members/signIn&updateMembers_css/images/memacc.svg"></label>
								<input type="text" class="input" name="memacc" id="memacc"
									value="${membersVO.memacc}" placeholder="Account" />
							</div>


							<div class="form-group">
								<label for="your_pass"><img class="icon1"
									src="<%=request.getContextPath()%>/front-end/members/signIn&updateMembers_css/images/password.svg"></label>
								<input type="password" class="input" name="mempwd" id="mempwd"
									placeholder="Password" />
							</div>

							<div class="form-group form-button">
								<input type="hidden" name="action" value="signin"> <input
									style="font-family: 'Gochi Hand'; font-size: 20px;"
									type="submit" name="signIn" id="signin" class="form-submit"
									value="Log in" />
						</form>
					</div>
					<button data-modal="modal-name" class="form-submit" id="forgotpwd"
						type="button">Forgot pwd</button>

					<button type="button" id="add">Peter</button>
					<button type="button" id="add1">David</button>
				</div>
			</div>
	</div>
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
	</section>


	</div>

	<div class="modal" id="modal-name">
		<div class="modal-sandbox"></div>
		<div class="modal-box">
			<div class="modal-header">
				<div class="close-modal">&#10006;</div>
				<h1 style="color: white;">找回密碼</h1>
			</div>
			<div class="modal-body">
				<div class="form-group">
					<label for="your_name"><img class="icon1"
						src="<%=request.getContextPath()%>/front-end/members/signIn&updateMembers_css/images/memacc.svg"></label>
					<input type="text" class="inputpwd" id="memacc1"
						style="background: #ECEFF1;"
						placeholder="Your account" />
				</div>


				<div class="form-group">
					<label for="your_pass"><img class="icon1"
						src="<%=request.getContextPath()%>/front-end/members/signIn&updateMembers_css/images/new-email.svg"></label>
					<input class="inputpwd" id="memail1" style="background: #ECEFF1;"
						placeholder="Your email" />
				</div>
				<input type="hidden" name="action" value="getpwd">
				<button style="border: 1px;" class="form-submit" id="getpwd" type="submit" onclick="sendRequest()">Submit</button>

			</div>
		</div>
	</div>



	<!-- JS -->
	<%-- <%@ include file="/index/front-index/foottest.jsp" %> --%>
</body>



<script>
	

	var message = '${errorMsgs.get(0)}';
	if (message.length !== 0) {
		swal('注意', message, 'warning');
	}

	

	$("#forgotpwd").click(function(e) {
		e.preventDefault();
		dataModal = $(this).attr("data-modal");
		$("#" + dataModal).css({
			"display" : "block"
		});
		// $("body").css({"overflow-y": "hidden"}); //Prevent double scrollbar.
	});
	$(".close-modal, .modal-sandbox").click(function() {
		$(".modal").css({
			"display" : "none"
		});
		// $("body").css({"overflow-y": "auto"}); //Prevent double scrollbar.
	});

	$("#add").click(function(e) {
		e.preventDefault();
		$("#memacc").val("M00031");
		$("#mempwd").val("123456");

	})

	$("#add1").click(function(e) {
		e.preventDefault();
		$("#memacc").val("M00001");
		$("#mempwd").val("123456");

	})
	
	
var request;
  function createXMLHttpRequest() {
    if (window.ActiveXObject) {
      request = new ActiveXObject("Microsoft.XMLHTTP");
    } else if (window.XMLHttpRequest) {
      request = new XMLHttpRequest();
    } else {
      window.alert("建議使用GOOGLE CHROME瀏覽器");
    }
  }

function processResult() {
    if ((request.readyState == 4) && (request.status == 200)) {
      var str = request.responseText;
      if(str==="non"){
    	  
    	  swal('查無此帳號', '請檢查您剛剛輸入的帳號及電郵', 'error');
       
      }else{
    	  swal('查詢成功', '已寄送您的密碼到您的電郵囉', 'success');
      }
      
    }
  }
function sendRequest() {
    createXMLHttpRequest();
    request.onreadystatechange = processResult;
    var memacc = document.getElementById("memacc1").value;
    var memail = document.getElementById("memail1").value;
    console.log('帳號'+memacc);
    console.log('電郵'+memail);
    
    if(memacc.length ===0 ||memail.length === 0 ){
    	console.log('123');
    	swal('注意', '欄位不可空白', 'warning');
    	
    }else{
    	var action = 'getpwd';
    	request.open("POST", "<%=request.getContextPath()%>/front-end/members/MemaccCheckServlet", true);
	    request.setRequestHeader("Content-Type",
	        "application/x-www-form-urlencoded");
	   
	    	request.send("action="+action+"&memacc=" + memacc+"&memail=" + memail);
    }
}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
</script>










</html>