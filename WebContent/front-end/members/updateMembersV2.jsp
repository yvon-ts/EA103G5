<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="com.members.model.*"%>
<%@ page import="com.teacher.model.*"%>

<%
MembersVO membersVO = (MembersVO) session.getAttribute("membersVO");
%>

<jsp:useBean id="teacherSvc" scope="page" class="com.teacher.model.TeacherService" />


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Sign Up Form by Colorlib</title>

    <!-- Font Icon -->
    <link rel="stylesheet" href="fonts/material-icon/css/material-design-iconic-font.min.css">

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/6.10.3/sweetalert2.css" />
    

    <!-- Main css -->
  <link rel="stylesheet" href="<%=request.getContextPath()%>/front-end/members/signIn&updateMembers_css/style.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/front-end/members/nav_css_ForUpdateMembers/css/bootstrap.min.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/front-end/members/nav_css_ForUpdateMembers/css/nivo-lightbox.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/front-end/members/nav_css_ForUpdateMembers/css/animate.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/front-end/members/nav_css_ForUpdateMembers/css/main.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/front-end/members/nav_css_ForUpdateMembers/css/responsive.css">
</head>
<style type="text/css">
    textarea{
        width: 300px;
        height: 100px;
    }
    #pic{
        width: 53px;
        height: 53px;

    }
    img.pic{
        width: 36px;
        height: 36px;
    }
    h2.form-title{
        width: 400px;
        margin-top:50px;
    }
    div.signup-form{
       width: 600px;
       margin-right:5px; 
    }
    div.signup-content{
    	height:650px;
    }
    h5.h5{
        color: black;
    }
    div#logo{
        padding-top: 12px;

    }
    input.input{
    	padding: 0px;
    	margin: auto;
    }
  img#mprofile{
  	-webkit-box-shadow: 3px 3px 5px 5px #BEBEBE;
	-moz-box-shadow: 3px 3px 5px 5px #BEBEBE;
	box-shadow: 3px 3px 5px 5px #BEBEBE;
	width:350px;
height:350px;

	  margin-left: -50px;
    margin-top: 30px;
    boder-radius: 10px;
    border-radius: 60px;
  	
  }
  div.signup-image{
  width:500px;
  margin:60px 0px 0px -60px;
  
  }
  th#mpic{
  padding-top:0px;
  
  }
  div.container{
box-shadow: 5px 10px #0099CC:
}
  
  input#register.form-submit{
  	margin-left:70px;
  }
  h5#regdate{
  margin-left:-140px;
  }
figure#a_mprofile{
margin-left:50px;
margin-top:30px;
}
img#nav_icon{
width:36px;
height:36px;
}
 section#copyright{
 height:400px;
 }
 body{
 font-family:'Gochi Hand';
 }
 
div.main{
background: url("<%=request.getContextPath()%>/front-end/members/assets/img/bgPic.png");
}

</style>
<body>
   <nav class="navbar navbar-expand-md bg-inverse fixed-top scrolling-navbar">
			<div class="container">
				<!-- Brand and toggle get grouped for better mobile display -->
				<a
					href="<%=request.getContextPath()%>/front-end/members/indexV1.jsp"
					class="navbar-brand"><img src="<%=request.getContextPath()%>/front-end/members/assets/img/logo.svg" alt="">
					<div id="logo">Xducation</div> </a>
				<button class="navbar-toggler" type="button" data-toggle="collapse"
					data-target="#navbarCollapse" aria-controls="navbarCollapse"
					aria-expanded="false" aria-label="Toggle navigation">
					<i class="lni-menu"></i>
				</button>
				<div class="collapse navbar-collapse" id="navbarCollapse">
					<ul class="navbar-nav mr-auto w-100 justify-content-end clearfix">
						<li class="nav-item"><a class="nav-link" href="#">
								進入搜尋&nbsp;<i class="lni-search"></i>
						</a></li>
						<li class="nav-item"><a class="nav-link" href="#">
								精選課程&nbsp;<i class="lni-leaf"></i>
						</a></li>
						<li class="nav-item"><a class="nav-link" href="#">
								名人講座&nbsp;<i class="lni-bulb"></i>
						</a></li>
						<c:if test="${teacherSvc.getStatus(membersVO.memno).tchrstatus eq '已通過'}">
						<li class="nav-item"><a class="nav-link" href="#">
								我要開課&nbsp;<i class="lni-bulb"></i>
						</a></li>
						</c:if>
						
						<c:if test="${not empty membersVO}">
							
							
							<li class="nav-item">
								<div class="dropdown" id="dropdown">
									<button class="btn btn-secondary dropdown-toggle" type="button"
										id="dropdownMenuButton" data-toggle="dropdown"
										aria-haspopup="true" aria-expanded="false">
										${membersVO.memname}</button>
									<div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
										<a class="dropdown-item"
											href="<%=request.getContextPath()%>/front-end/members/updateMembersV2.jsp">個人檔案</a>
											
										
										<c:if test="${teacherSvc.getStatus(membersVO.memno).tchrstatus eq '待審核'}">
										<a class="dropdown-item" onclick="status()" >老師檔案</a> 
											
										</c:if>
										<c:if test="${teacherSvc.getStatus(membersVO.memno).tchrstatus eq '已通過'}">
										<a class="dropdown-item"
											href="<%=request.getContextPath()%>/front-end/teacher/teacherDisplay.jsp">老師檔案</a> 
											
										</c:if>
											<c:if test="${teacherSvc.getStatus(membersVO.memno).tchrstatus eq '未通過'}">
										<a class="dropdown-item"
											href="<%=request.getContextPath()%>/front-end/teacher/teacherUpdate.jsp">老師檔案</a>
											
										</c:if>
										<c:if test="${not empty membersVO}">
										<a class="dropdown-item"
											href='<%=request.getContextPath()%>/members/members.do?action=signout'>會員登出</a> 
											
										</c:if>
											
											
										
											
											
											
									</div>
								</div>
								
							</li>
							
							</c:if>
							<c:if test="${not empty membersVO.memno}">
							<c:if test="${empty teacherSvc.getStatus(membersVO.memno)}">
							<img id="nav_icon" src='<%=request.getContextPath()%>/front-end/members/assets/img/students.svg'>
							</c:if>
							<c:if test="${teacherSvc.getStatus(membersVO.memno).tchrstatus eq '待審核'}">
							<img id="nav_icon" src='<%=request.getContextPath()%>/front-end/members/assets/img/students.svg'>
							</c:if>
							
							<c:if test="${teacherSvc.getStatus(membersVO.memno).tchrstatus eq '已通過'}">
							<img id="nav_icon" src='<%=request.getContextPath()%>/front-end/members/assets/img/teacher.svg'>
							</c:if>
							<c:if test="${teacherSvc.getStatus(membersVO.memno).tchrstatus eq '未通過'}">
							<img id="nav_icon" src='<%=request.getContextPath()%>/front-end/members/assets/img/students.svg'>
							
							</c:if>
							</c:if>
							

						<c:if test="${empty membersVO}">
							<li class="nav-item"><a class='nav-link'
								href='<%=request.getContextPath()%>/front-end/members/signIn.jsp'>我要登入&nbsp;<i
									class='lni-bulb'></i></a></li>
						</c:if>




					</ul>
				</div>
			</div>
		</nav>

    <div class="main">

        <!-- Sign up form -->
        <section class="signup">
        <form method='POST' class='register-form' ACTION='<%=request.getContextPath()%>/members/members.do' id='register-form' enctype='multipart/form-data'>
                      
            <div class="container">
                <div class="signup-content">
                    <div class="signup-form">

                        <h2  class="form-title"><img id="pic" src="<%=request.getContextPath()%>/front-end/members/signIn&updateMembers_css/images/membership.svg">${membersVO.nkname}-個人檔案</h2>
                        
                     
                        	 <table>
                        	 	<tr>
                        	 		<th>    <div class="form-group">
                                <h5 class="h5">會員姓名<img class="pic" src="<%=request.getContextPath()%>/front-end/members/signIn&updateMembers_css/images/id-card.svg"></h5>

                                
                                
                            </div></th>
                            <th><div style="width:100px"></div></th>
                        	 		<th>    <div class="form-group">
                                <h5 class="h5">會員電話<img class="pic" src="<%=request.getContextPath()%>/front-end/members/signIn&updateMembers_css/images/iphone.svg"></h5> 
                            </div></th>
                        	 	</tr>
                        	 	<tr>
                        	 		<td> <p>${membersVO.memname}</p></td>
                        	 		<th></th>
                        	 		<td> <p>${membersVO.mphone}</p></td>

                        	 	</tr>
                        	 	<tr><td style="color:#FFF">"    "</td></tr>
                        	 	<tr>
                        	 		<th>    <div class="form-group">
                                <h5 class="h5">會員生日<img class="pic" src="<%=request.getContextPath()%>/front-end/members/signIn&updateMembers_css/images/birthday-present.svg"></h5>

                                
                                
                            </div></th>
                            <th><div style="width:100px"></div></th>
                        	 		<th>    <div class="form-group">
                                <h5 class="h5">會員電郵<img class="pic" src="<%=request.getContextPath()%>/front-end/members/signIn&updateMembers_css/images/new-email.svg"></h5> 
                            </div></th>
                        	 	</tr>
                        	 	<tr>
                        	 		<td> <p>${membersVO.membday}</p></td>
                        	 		<th></th>
                        	 		<td> <p>${membersVO.memail}</p></td>

                        	 	</tr>
                        	 	 <tr><td style="color:#FFF">" "</td></tr>
                        	 	 <tr>
                        	 	 	<th id="mpic"><div class="form-group">
                        	 	 	<h5 class="h5"><div style="color:#FFF">"</div><label>
                                <input onchange="readURL(this)" targetID="mprofile" style="display:none;" type="file" id="picture" name="picture" placeholder="Your Profile"/>
                                會員頭像<img class="pic" src="<%=request.getContextPath()%>/front-end/members/signIn&updateMembers_css/images/pictures.svg">
                                </label></h5>
                               
                            </div></th>
                            <th><div style="width:100px"></div></th>
                        	 	 	
                        	 	 	<th><div class="form-group">
                        	 	 	  
                                <h5 class="h5">會員暱稱<img class="pic" src="<%=request.getContextPath()%>/front-end/members/signIn&updateMembers_css/images/nickname.svg"></h5> 
                            </div>
                            
                        <input class="input" name='nkname' type="text" value="${membersVO.nkname}" placeholder="Your nickname"/></th>
                           
                          <tr><td>點選上傳.....⤴</td></tr>
                           <tr><td style="color:#FFF">" "</td></tr>
                        <tr><td style="color:#FFF">" "</td></tr>
                        	 	 	
                        	 	

                        	 	 <tr>
                        	 		<th>    <div class="form-group">
                                <h5 class="h5">會員密碼<img class="pic" src="<%=request.getContextPath()%>/front-end/members/signIn&updateMembers_css/images/password.svg"></h5>

                                
                                
                            </div><input class="input" name='mempwd' type="password" placeholder="Your password"/></th>
                            <th><div style="width:100px"></div></th>
                        	 		<th>    <div class="form-group">
                                <h5 class="h5">確認密碼<img class="pic" src="<%=request.getContextPath()%>/front-end/members/signIn&updateMembers_css/images/Rmempwd.svg"></h5> 
                            </div><input class="input" name='Rmempwd' type="password" placeholder="Password again"/></th>
                        	 	</tr>
                        	
                        	 </table>
                            
                        
                    </div>
                    <div class="signup-image">
                        <figure id='a_mprofile'>
                        <img id='mprofile' src="<%=request.getContextPath()%>/front-end/members/MprofileDisplayServlet?MEMNO=${membersVO.memno}" alt="sing up image">
                        <input type='hidden' name='action' value='updatemembers'>
                         <input type="submit" style="font-family:'Gochi Hand'" id="register" name="signup" id="signup" class="form-submit" value="Update"/>
                       
                        </figure>
                        
                      
                       
  <h5 id='regdate' style="text-align: center;color:black"><img class="pic" src="<%=request.getContextPath()%>/front-end/members/signIn&updateMembers_css/images/join.svg">註冊會員日期:<fmt:formatDate value="${membersVO.regdate}" type="date" dateStyle="full"/></h5>
  
                    </div>
            


                 

                </div>
                
            </div>
 </form>
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
        </section>
        
</div>

    

    <!-- JS -->
     <script type="text/javascript">
    

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
    
</body><!-- This templates was made by Colorlib (https://colorlib.com) -->
</html>