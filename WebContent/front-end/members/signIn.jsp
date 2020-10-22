<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.members.model.*"%>

<%String inform3 = (String)request.getAttribute("inform3"); %>


<%@ include file="/index/front-index/headtest.jsp" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Xducation-會員登入</title>


    <!-- Main css -->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/front-end/members/signIn&updateMembers_css/style.css">
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
img.pic{
-webkit-box-shadow: 3px 3px 5px 5px #BEBEBE;
	-moz-box-shadow: 3px 3px 5px 5px #BEBEBE;
	box-shadow: 3px 3px 5px 5px #BEBEBE;
	width:350px;
height:350px;

position: absolute;
 z-index:1;
	  margin-left: -60px;
    margin-top: 85px;
    boder-radius: 10px;
    border-radius: 20px;

}
h2.form-title{
width:600px;
height:200px;
position: absolute;
 z-index:1;
font-size:120px;
font-family:'Gochi Hand';
margin:-240px 0 0 -30px;


}
input#signin{
margin:10px 0 0 70px ;

}



 img.icon{
 width:33px;
 height:33px;
 
 }
 input#your_pass{
 padding-left:40px;
 width:250px;
 }
 input#your_name{
 padding-left:40px;
  width:250px;

 }
 div#bg{
 width:850px;
 height:630px; 
 -webkit-box-shadow: 0 0 15px #8E8E8E;
	-moz-box-shadow: 0 0 15px #8E8E8E;
	box-shadow: 0 0 15px #5B5B5B;
 }
 section#copyright{
 height:400px;
 }
 input.input{
font-family:'Gochi Hand';
}
div.signin-form{
padding-top:200px;
padding-left:10px;

}
div.signin-content{
padding-top:70px;
padding-bottom:0px;
}
a.signup-image-link{
width:300px;
height:100px;
margin-top:470px;
margin-left:-40px;
} 
div.main{
background: url("<%=request.getContextPath()%>/front-end/members/assets/img/bgPic.png");


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
                        <a href="<%=request.getContextPath()%>/front-end/members/indexV1.jsp"><img class="pic" src="<%=request.getContextPath()%>/front-end/members/assets/img/head/02.png" alt="sing up image"></a>
                        <a href="<%=request.getContextPath()%>/front-end/members/addMembersV2.jsp" class="signup-image-link" style="font-family:'Gochi Hand';">Create an account</a>
                    </div>

                    <div class="signin-form">
                        <h2 class="form-title">Sign in</h2>
                        <form action="<%=request.getContextPath()%>/members/members.do" method="POST" class="register-form" id="login-form">
                            
                            <div class="form-group">
                                <label for="your_name"><img class="icon" src="<%=request.getContextPath()%>/front-end/members/signIn&updateMembers_css/images/memacc.svg"></label>
                                <input type="text" class="input" name="memacc" id="your_name" value="${membersVO.memacc}" placeholder="Account"/>
                            </div>
                            
                            
                            <div class="form-group">
                                <label for="your_pass"><img class="icon" src="<%=request.getContextPath()%>/front-end/members/signIn&updateMembers_css/images/password.svg"></label>
                                <input type="password" class="input" name="mempwd" id="your_pass" placeholder="Password"/>
                            </div>
                            
                            <div class="form-group form-button">
                            <input type="hidden" name="action" value="signin">
                               <input style="font-family:'Gochi Hand'" type="submit" name="signIn" id="signin" class="form-submit" value="Log in"/> 
                            </div>
                        </form>
                         <input type="hidden" id="inform3" value="${requestScope.inform3}">
                        <div class="social-login">
                            <span class="social-label">
                            
                            </span>
                            <ul class="socials">
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </section>
         <footer id="footer" >
        <section id="copyright" class="">
            <div >
                <div >
                    <div >
                        <div class="copyright-content">Xducation<p><a href="#">關於我們</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="#">其他服務</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="#">網站地圖</a></p>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </footer>

    </div>
    
  

    <!-- JS -->
    <%-- <%@ include file="/index/front-index/foottest.jsp" %> --%>
</body>



<script>


var message = document.getElementById('message').value;

if(message.length !== 0){
	 swal('注意', message, 'warning');
}






</script>










</html>