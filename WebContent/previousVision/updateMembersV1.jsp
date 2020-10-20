<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
<link rel="stylesheet" href="css/style.css">
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


</style>
</head>
<body>


    <div class="main" id="mainSwich">
        <!-- Sign up form -->
        <section class="signup">
            <div class="container">
                <div class="signup-content">
                    <div class="signup-form">
                        <h1 class="form-title">${membersVO.nkname}の個人檔案</h1>
                         <form method='POST' class='register-form' ACTION='MembersServlet'id='register-form' enctype='multipart/form-data'>
<div class='form-group'><label for='pass'><img src='images/mempwd.png'></label><input type='password' id='mempwd' name='mempwd' placeholder='Password' /></div><div class='form-group'><label for='re-pass'><img src='images/re-mempwd.png'></label><input type='password' id='Rmempwd' name='Rmempwd' placeholder='password again'/></div><div class='form-group'><label for='name'><img src='images/nkname.png'></label><input type='text' id='nkname' name='nkname' placeholder='Your Nickname'/></div><div class='form-group'><label for='name'><img src='images/mphone.png'></label><input type='text' id='mphone' name='mphone' placeholder='Phone Number'/></div><input type='file' id='picture' name='picture' placeholder='Your Profile'/><input type='hidden' name='action' value='updatemembers'><input type='submit' name='signup' id='signup'class='form-submit' value='更新' />
                        
                        </form>>

                    </div>

                          
                    <div class="signup-image" id="singup-image">
                        <figure>
                            <img id="pic"
                                src="<%=request.getContextPath()%>/front-end/members/MprofileDisplay?MEMNO=${membersVO.memno}"
                                alt="sing up image">
                            
                            
                            <p id='memail'><h3><img id="icon"src="images/memail.png" alt=""> 
                                ${membersVO.memail}
                                </h3>
                                 <button id="btn1" onclick="swich()" class="form-submit">修改</button>
                                
                                </p>
                        </figure>

                    </div>

 

                </div>
<div id="regdate" >
                        <h3>加入平台時間:${membersVO.regdate}</h3>                                   
                            </div>
            </div>
 
        </section>
   
    </div>













    <script type="text/javascript">
    
   
    
    
    
    
    
        // var request;
        //   function createXMLHttpRequest() {
        //     if (window.ActiveXObject) {
        //       request = new ActiveXObject("Microsoft.XMLHTTP");
        //     } else if (window.XMLHttpRequest) {
        //       request = new XMLHttpRequest();
        //     } else {
        //       window.alert("建議使用GOOGLE CHROME瀏覽器");
        //     }
        //   }

        // function processResult() {
        //     if ((request.readyState == 4) && (request.status == 200)) {
        //       var str = request.responseText;
        //       if(str=="true"){
        //         var msg = document.getElementById("msg").innerHTML ="<span style='color:#00cc00'>此帳號可以使用</span>" ;
        //       }else{
        //         var msg = document.getElementById("msg").innerHTML ="<span style='color:#cc0000'>此帳號已被註冊</span>" ;
        //       }

        //     }
        //   }
        // function sendRequest() {
        //     createXMLHttpRequest();
        //     request.onreadystatechange = processResult;
        //     var memacc = document.getElementById("memacc").value;

        //     // request.open("GET", "AccountCheckServlet?username="+username, true); 
        //     request.open("POST", "MemaccCheckServlet", true);
        //     request.setRequestHeader("Content-Type",
        //         "application/x-www-form-urlencoded");
        //     request.send("memacc=" + memacc);
        //   }
    </script>

</body>
<!-- This templates was made by Colorlib (https://colorlib.com) -->
</html>