<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.members.model.*"%>
<%
MembersVO memVO = (MembersVO)request.getAttribute("memVO");

%>




<%@ include file="/index/front-index/headtest.jsp" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Sign Up Form by Colorlib</title>


    <!-- Main css -->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/front-end/members/signIn&updateMembers_css/style.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/front-end/members/nav_css_ForSignIn&addMembers/css/bootstrap.min.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/front-end/members/nav_css_ForSignIn&addMembers/css/nivo-lightbox.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/front-end/members/nav_css_ForSignIn&addMembers/css/animate.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/front-end/members/nav_css_ForSignIn&addMembers/css/main.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/front-end/members/nav_css_ForSignIn&addMembers/css/responsive.css">
</head>

<style>
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
 div.container{
 width:850px;
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
            <div class="container">
                <div class="signin-content">
                    <div class="signin-image">
                        <a href="<%=request.getContextPath()%>/front-end/members/indexV1.jsp"><img src="<%=request.getContextPath()%>/front-end/members/signIn&updateMembers_css/images/signin-image.jpg" alt="sing up image"></a>
                        <a href="<%=request.getContextPath()%>/front-end/members/addMembersV2.jsp" class="signup-image-link">Create an account</a>
                    </div>

                    <div class="signin-form">
                        <h2 class="form-title">Sign in</h2>
                        <form action="<%=request.getContextPath()%>/members/members.do" method="POST" class="register-form" id="login-form">
                            <div class="form-group">
                                <label for="your_name"><div style="width:100px"><img class="icon" src="<%=request.getContextPath()%>/front-end/members/signIn&updateMembers_css/images/memacc.svg"></div></label>
                                <input type="text" name="memacc" id="your_name" value="${memVO.memacc}" placeholder="Account"/>
                            </div>
                            <div class="form-group">
                                <label for="your_pass"><img class="icon" src="<%=request.getContextPath()%>/front-end/members/signIn&updateMembers_css/images/password.svg"></label>
                                <input type="password" name="mempwd" id="your_pass" placeholder="Password"/>
                            </div>
                            <div class="form-group form-button">
                            <input type="hidden" name="action" value="signin">
                               <input type="submit" name="signIn" id="signin" class="form-submit" value="登入"/> 
                            </div>
                        </form>
                        <div class="social-login">
                            <span class="social-label">
                            <c:if test="${not empty errorMsgs}">
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	
</c:if>
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
</html>