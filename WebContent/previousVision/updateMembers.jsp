<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="com.members.model.*"%>

<%
MembersVO membersVO = (MembersVO) session.getAttribute("membersVO");
%>





<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>Sign Up Form by Colorlib</title>


<!-- Font Icon -->
<link rel="stylesheet"
    href="fonts/material-icon/css/material-design-iconic-font.min.css">

<!-- Main css -->
<link rel="stylesheet" href="signIn&updateMembers_css/style.css">
    <link rel="stylesheet" href="nav_css_ForUpdateMembers/css/bootstrap.min.css">
    <link rel="stylesheet" href="nav_css_ForUpdateMembers/css/nivo-lightbox.css">
    <link rel="stylesheet" href="nav_css_ForUpdateMembers/css/animate.css">
    <link rel="stylesheet" href="nav_css_ForUpdateMembers/css/main.css">
    <link rel="stylesheet" href="nav_css_ForUpdateMembers/css/responsive.css">
<style>
#pic {
   
    max-width: 300px;
    height: 300px;
    border-radius: 50%;
}

#singup-image {
    /*  border: 1px solid red; */
    width: 500px;
    height: 500px;
    }

#memail {
    margin: auto 40px;
}
#regdate{
    width: 100%;
    height: 90px;

    
}
#regdate h3{
   width: 400px;
    height: 80px;
    margin:auto;
    text-align: center;
  
}
div.signup-content{
width:900px;
height:550px;
}



</style>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/6.10.3/sweetalert2.css" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/6.10.3/sweetalert2.js" type="text/javascript"></script>
</head>
<body>
<!-- <nav class="navbar navbar-expand-md bg-inverse fixed-top scrolling-navbar"> -->
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
        <!-- Sign up form -->
        <section class="signup">
            <div class="container">
                <div class="signup-content">
                    <div class="signup-form">
                        <h1 class="form-title">${membersVO.nkname}の個人檔案</h1>
                        <form method='POST' class='register-form' ACTION='<%=request.getContextPath()%>/front-end/members/members.do' id='register-form' enctype='multipart/form-data'>
                       <table id="table"> 
                        <tr>
                            
                               <th> <h3>會員姓名:</h3></th>
                        </tr>
                        <tr>
                          <td><img id="icon" src="images/memname.png"></td> 
                           <td>
                                <h3>${membersVO.memname}</h3>                            
                           </td>
                       </tr>
                       <tr>
                            
                               <th> <h3>聯絡電話:</h3></th>
                        </tr>
                        <tr>
                          <td><img id="icon" src="images/mphone.png"></td> 
                           <td>
                                <h3>${membersVO.mphone}</h3>                            
                           </td>
                       </tr>
                       <tr>
                               <th> <h3>生辰大壽:</h3></th>
                        </tr>
                        <tr>
                          <td><img id="icon" src="images/membday.png"></td> 
                           <td>
                                <h3>${membersVO.membday}</h3>                            
                           </td>
                       </tr>
                    
                       
                         </table>
                           <!-- <form method='POST' class='register-form' ACTION='MembersServlet' id='register-form' enctype='multipart/form-data'>
                          <img src='images/mprofile.png'><input type='file' onchange='readURL(this)' targetID='pic' id='picture' name='picture' placeholder='Your Profile'/>
                             <input type='hidden' name='action' value='photo'>
                         <input type='submit' name='signup' id='signup'class='form-submit' value='更新'/>
                             </form> -->

                       </form> 
                        <c:if test="${not empty errorMsgs}">
    <font style="color:red">請修正以下錯誤:</font>
    <ul>
        <c:forEach var="message" items="${errorMsgs}">
            <li style="color:red">${message}</li>
        </c:forEach>
    </ul>
</c:if>

                    </div>

                          
                    <div class="signup-image" id="singup-image">
                        <figure>
                         
                      
                            <img id="pic"
                                src="<%=request.getContextPath()%>/front-end/members/MprofileDisplayServlet?MEMNO=${membersVO.memno}"
                                alt="sing up image">
                           
                           
                              <h3>
                                <img src="images/memail.png" alt=""> ${membersVO.memail}
                                </h3> 
                               
                                     
                                     <a class="form-submit" onclick="update()">修改</a>
                                     <a class="form-submit" href='indexV1.jsp'>首頁</a>
                                  
                                     
                                     


                           

                        </figure>

                    </div>

 

                </div>
<div id="regdate" >
                        <h3>加入平台時間:<fmt:formatDate value="${membersVO.regdate}" type="date" dateStyle="full"/></h3>                                   
                            </div>
            </div>
 
        </section>
    </div>













    <script type="text/javascript">
        function update(){
            var table = document.getElementById('table');
            
            table.innerHTML ="<div class='form-group'><label for='pass'><img src='images/mempwd.png'></label><input type='password' id='mempwd' name='mempwd' placeholder='Password' /></div><div class='form-group'><label for='re-pass'><img src='images/re-mempwd.png'></label><input type='password' id='Rmempwd' name='Rmempwd' placeholder='password again'/></div><div class='form-group'><label for='name'><img src='images/nkname.png'></label><input value='${membersVO.nkname}' type='text' id='nkname' name='nkname' placeholder='Your Nickname'/></div><div class='form-group'><label for='name'><img src='images/mphone.png'></label><input value='${membersVO.mphone}' type='text' id='mphone' name='mphone' placeholder='Phone Number'/></div><img src='images/mprofile.png'><input type='file' onchange='readURL(this)' targetID='pic' id='picture' name='picture' placeholder='Your Profile'/><input type='hidden' name='action' value='updatemembers'><input type='submit' name='signup' id='signup'class='form-submit' value='更新'/>";
           
           // table.innerHTML ="<div class='form-group'><label for='pass'><img src='images/mempwd.png'></label><input type='password' id='mempwd' name='mempwd' placeholder='Password' /></div><div class='form-group'><label for='re-pass'><img src='images/re-mempwd.png'></label><input type='password' id='Rmempwd' name='Rmempwd' placeholder='password again'/></div><div class='form-group'><label for='name'><img src='images/nkname.png'></label><input value='${membersVO.nkname}' type='text' id='nkname' name='nkname' placeholder='Your Nickname'/></div><div class='form-group'><label for='name'><img src='images/mphone.png'></label><input value='${membersVO.mphone}' type='text' id='mphone' name='mphone' placeholder='Phone Number'/></div>";
            
            
        

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
              if(str=="true"){
                var msg = document.getElementById("msg").innerHTML ="<span style='color:#00cc00'>此帳號可以使用</span>" ;
              }else{
                var msg = document.getElementById("msg").innerHTML ="<span style='color:#cc0000'>此帳號已被註冊</span>" ;
              }

            }
          }
        function sendRequest() {
        	swal('干得漂亮！', '你点击了按钮！', 'success');
            createXMLHttpRequest();
            request.onreadystatechange = processResult;
            var updatemembers ='updatemembers'
            var mempwd = document.getElementById("mempwd").value;
            console.log(mempwd);
            var nkname = document.getElementById("nkname").value;
            console.log(nkname);
            var mphone = document.getElementById("mphone").value;
            console.log(mphone);
            var rmempwd = document.getElementById("Rmempwd").value;
            console.log(rmempwd);
            

             /* request.open("GET", "AccountCheckServlet?username="+username, true);  */
            request.open("POST", "MembersUpdate", true);
            request.setRequestHeader("Content-Type",
                "application/x-www-form-urlencoded");
            request.send("mphone=" + mphone + "&nkname=" + nkname + "&mempwd=" + mempwd + "&rmempwd="+ rmempwd);
            
          }  
    </script>

</body>
<!-- This templates was made by Colorlib (https://colorlib.com) -->
</html>