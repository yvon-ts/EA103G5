<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.members.model.*"%>
<%@ page import="com.course_assess.model.*"%>
<%@ page import="java.util.*"%>
<%
String courseno = (String)request.getParameter("courseno");
pageContext.setAttribute("courseno", courseno);
%>

<%@ include file="/index/front-index/header.jsp" %>
<jsp:useBean id="course_assessSvc" scope="page" class="com.course_assess.model.Course_assessService" />


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Xducation-新增評價</title>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/6.10.3/sweetalert2.css" />
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/6.10.3/sweetalert2.js"
	type="text/javascript"></script>
    <!-- Main css -->
    <link href="//netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.css" rel="stylesheet">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/front-end/members/signIn&updateMembers_css/style.css">
<%--     <link rel="stylesheet" href="<%=request.getContextPath()%>/front-end/members/nav_css_ForSignIn&addMembers/css/bootstrap.min.css"> --%>
<%--     <link rel="stylesheet" href="<%=request.getContextPath()%>/front-end/members/nav_css_ForSignIn&addMembers/css/nivo-lightbox.css"> --%>
<%--     <link rel="stylesheet" href="<%=request.getContextPath()%>/front-end/members/nav_css_ForSignIn&addMembers/css/animate.css"> --%>
<%--     <link rel="stylesheet" href="<%=request.getContextPath()%>/front-end/members/nav_css_ForSignIn&addMembers/css/main.css"> --%>
<%--     <link rel="stylesheet" href="<%=request.getContextPath()%>/front-end/members/nav_css_ForSignIn&addMembers/css/responsive.css"> --%>
</head>

<style>
@import url(https://fonts.googleapis.com/css?family=Francois+One);
@import url(https://fonts.googleapis.com/css?family=PT+Sans);
.ratingControl {
  position: relative;
  width: 375px;
  height: 65px;
  -webkit-user-select: none;
     -moz-user-select: none;
      -ms-user-select: none;
          user-select: none;
  margin: 0 auto;
}
.ratingControl input {
  visibility: hidden;
}

.ratingControl-stars {
  position: absolute;
  top: 0;
  width: 75px;
  height: 65px;
  background-image: url("data:image/svg+xml;charset=US-ASCII,%3C%3Fxml%20version%3D%221.0%22%20encoding%3D%22UTF-8%22%20standalone%3D%22no%22%3F%3E%3Csvg%20width%3D%2215px%22%20height%3D%2214px%22%20viewBox%3D%220%200%2015%2014%22%20version%3D%221.1%22%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg%22%20xmlns%3Axlink%3D%22http%3A%2F%2Fwww.w3.org%2F1999%2Fxlink%22%3E%20%20%20%20%3Ctitle%3EEmpty%20Star%3C%2Ftitle%3E%20%20%20%20%3Cdefs%3E%3C%2Fdefs%3E%20%20%20%20%3Cg%20id%3D%22Page-1%22%20stroke%3D%22none%22%20stroke-width%3D%221%22%20fill%3D%22none%22%20fill-rule%3D%22evenodd%22%3E%20%20%20%20%20%20%20%20%3Cg%20id%3D%22Order-Details---Order-final---Not-reviewed%22%20transform%3D%22translate%28-108.000000%2C%20-385.000000%29%22%20fill%3D%22%23D5D5D5%22%3E%20%20%20%20%20%20%20%20%20%20%20%20%3Cg%20id%3D%22Group%22%20transform%3D%22translate%28108.000000%2C%20316.000000%29%22%3E%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%3Cg%20transform%3D%22translate%280.000000%2C%2069.000000%29%22%20id%3D%22Star-7%22%3E%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%3Cpolygon%20points%3D%227.5%2011.25%203.09161061%2013.5676275%203.93353806%208.65881373%200.367076128%205.18237254%205.2958053%204.46618627%207.5%200%209.7041947%204.46618627%2014.6329239%205.18237254%2011.0664619%208.65881373%2011.9083894%2013.5676275%20%22%3E%3C%2Fpolygon%3E%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%3C%2Fg%3E%20%20%20%20%20%20%20%20%20%20%20%20%3C%2Fg%3E%20%20%20%20%20%20%20%20%3C%2Fg%3E%20%20%20%20%3C%2Fg%3E%3C%2Fsvg%3E");
  background-size: auto 65px;
  background-repeat: no-repeat;
  cursor: pointer;
  text-indent: 100%;
  white-space: nowrap;
  overflow: hidden;
}
.ratingControl-stars:hover, .ratingControl-stars:hover ~ .ratingControl-stars, input:checked ~ .ratingControl-stars {
  background-image: url("data:image/svg+xml;charset=US-ASCII,%3C%3Fxml%20version%3D%221.0%22%20encoding%3D%22UTF-8%22%20standalone%3D%22no%22%3F%3E%3Csvg%20width%3D%2215px%22%20height%3D%2214px%22%20viewBox%3D%220%200%2015%2014%22%20version%3D%221.1%22%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg%22%20xmlns%3Axlink%3D%22http%3A%2F%2Fwww.w3.org%2F1999%2Fxlink%22%3E%20%20%20%20%3Ctitle%3ESolid%20Star%3C%2Ftitle%3E%20%20%20%20%3Cdefs%3E%3C%2Fdefs%3E%20%20%20%20%3Cg%20id%3D%22Page-1%22%20stroke%3D%22none%22%20stroke-width%3D%221%22%20fill%3D%22none%22%20fill-rule%3D%22evenodd%22%3E%20%20%20%20%20%20%20%20%3Cg%20id%3D%22Order-Details---Order-final---Not-reviewed%22%20transform%3D%22translate%28-108.000000%2C%20-385.000000%29%22%20fill%3D%22%23FEC844%22%3E%20%20%20%20%20%20%20%20%20%20%20%20%3Cg%20id%3D%22Group%22%20transform%3D%22translate%28108.000000%2C%20316.000000%29%22%3E%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%3Cg%20transform%3D%22translate%280.000000%2C%2069.000000%29%22%20id%3D%22Star-7%22%3E%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%3Cpolygon%20points%3D%227.5%2011.25%203.09161061%2013.5676275%203.93353806%208.65881373%200.367076128%205.18237254%205.2958053%204.46618627%207.5%200%209.7041947%204.46618627%2014.6329239%205.18237254%2011.0664619%208.65881373%2011.9083894%2013.5676275%20%22%3E%3C%2Fpolygon%3E%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%3C%2Fg%3E%20%20%20%20%20%20%20%20%20%20%20%20%3C%2Fg%3E%20%20%20%20%20%20%20%20%3C%2Fg%3E%20%20%20%20%3C%2Fg%3E%3C%2Fsvg%3E");
}
.ratingControl-stars:active, .ratingControl-stars:active ~ .ratingControl-stars, input:checked ~ .ratingControl-stars:active {
  background-image: url("data:image/svg+xml;charset=US-ASCII,%3C%3Fxml%20version%3D%221.0%22%20encoding%3D%22UTF-8%22%20standalone%3D%22no%22%3F%3E%3Csvg%20width%3D%2215px%22%20height%3D%2214px%22%20viewBox%3D%220%200%2015%2014%22%20version%3D%221.1%22%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg%22%20xmlns%3Axlink%3D%22http%3A%2F%2Fwww.w3.org%2F1999%2Fxlink%22%3E%20%20%20%20%3Ctitle%3ESolid%20Star%20%E2%80%93%20Light%3C%2Ftitle%3E%20%20%20%20%3Cdefs%3E%3C%2Fdefs%3E%20%20%20%20%3Cg%20id%3D%22Page-1%22%20stroke%3D%22none%22%20stroke-width%3D%221%22%20fill%3D%22none%22%20fill-rule%3D%22evenodd%22%3E%20%20%20%20%20%20%20%20%3Cg%20id%3D%22Order-Details---Order-final---Not-reviewed%22%20transform%3D%22translate%28-108.000000%2C%20-385.000000%29%22%20fill%3D%22%23FFE39C%22%3E%20%20%20%20%20%20%20%20%20%20%20%20%3Cg%20id%3D%22Group%22%20transform%3D%22translate%28108.000000%2C%20316.000000%29%22%3E%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%3Cg%20transform%3D%22translate%280.000000%2C%2069.000000%29%22%20id%3D%22Star-7%22%3E%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%3Cpolygon%20points%3D%227.5%2011.25%203.09161061%2013.5676275%203.93353806%208.65881373%200.367076128%205.18237254%205.2958053%204.46618627%207.5%200%209.7041947%204.46618627%2014.6329239%205.18237254%2011.0664619%208.65881373%2011.9083894%2013.5676275%20%22%3E%3C%2Fpolygon%3E%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%3C%2Fg%3E%20%20%20%20%20%20%20%20%20%20%20%20%3C%2Fg%3E%20%20%20%20%20%20%20%20%3C%2Fg%3E%20%20%20%20%3C%2Fg%3E%3C%2Fsvg%3E");
}

.ratingControl-stars--05 {
  left: 0px;
}

.ratingControl-stars--1 {
  left: 0px;
}



.ratingControl-stars--2 {
  left: 75px;
}



.ratingControl-stars--3 {
  left: 150px;
}



.ratingControl-stars--4 {
  left: 225px;
}



.ratingControl-stars--5 {
  left: 300px;
}



@font-face {
  font-family: 'Audiowide';
  font-style: normal;
  font-weight: 400;
  src: local("Audiowide"), local("Audiowide-Regular"), url(http://themes.googleusercontent.com/static/fonts/audiowide/v2/8XtYtNKEyyZh481XVWfVOj8E0i7KZn-EPnyo3HZu7kw.woff) format("woff");
}
body {
  font-size: 62.5%;
  background-color: #fff;
  margin: 10px;
  
}

h1, h2, h3 {
  font-family:Gochi Hand;
  text-transform: uppercase;
}

h1 {
  font-size: 2.4em;
  background-color: #0099CC;
  text-align: center;
  padding: 20px;
  margin: 0;
  color: #fff;
  border-radius:10px;
}
h1 a {
  display: block;
  margin-top: 10px;
  text-transform: none;
  color: #aaa;
  font-size: 16px;
  text-decoration: none;
}

.demo {
width:100%;
height:100px;
}


 
 
 
 


 div#bg{
 width:850px;
 height:530px; 
 padding:0;
 -webkit-box-shadow: 0 0 15px #8E8E8E;
	-moz-box-shadow: 0 0 15px #8E8E8E;
	box-shadow: 0 0 15px #5B5B5B;
 }
 div#content{
 width:100%;
 height:200px;
 background-color:red;
 
 }
 div.form-item{
 width:500px;
 height:200px;
 }
 div.ratingControl{
 width:400px;
 height:300px;
 position:absolute;
 margin:50px 0 0 225px;
 
 
 }
 textarea.text{
 width:510px;
 height:150px;
 margin:0 0px 0 -58px;
 display:block;
 letter-spacing:1px;
 }
 input#register{
 margin:320px 0 0 360px;
 position:absolute;
 z-index:2;
 
 }
 p{
 width:100%;
 text-align:center;
 color:#FF5151;
 }
/* img.icon{
width:120px;
height:120px;
border-radius:10px;
margin-left:40px;
margin-top:40px;
} */
 
div.main{
background: url("<%=request.getContextPath()%>/front-end/members/assets/img/bgPic.png");


}

</style>
 


<body>

      <div class="main">
              

<!-- RATING - Form -->
<form class="rating-form" action="<%=request.getContextPath()%>/course_assess/course_assess.do" method="post" name="">
  
  <div class="content">
  
  
  
 <div id="bg" class="container">
  <h1>修改課程評價 & 上課心得回饋</h1><br>
  <p>歡迎你給予鼓勵、提出建議，你的心得與想法，都將是尚未加入課程同學們的最佳參考！</p>
  
  <div class="demo">
 
    <div class="ratingControl">
   
        <input type="radio" id="rating-5" name="coursescore" value="5">
        <label class="ratingControl-stars ratingControl-stars--5" for="rating-5">5</label>
       
        <input type="radio" id="rating-4" name="coursescore" value="4">
        <label class="ratingControl-stars ratingControl-stars--4" for="rating-4">4</label>
        
        <input type="radio" id="rating-3" name="coursescore" value="3">
        <label class="ratingControl-stars ratingControl-stars--3" for="rating-3">3</label>
        
        <input type="radio" id="rating-2" name="coursescore" value="2">
        <label class="ratingControl-stars ratingControl-stars--2" for="rating-2">2</label>
        
        <input type="radio" id="rating-1" name="coursescore" value="1">
        <label class="ratingControl-stars ratingControl-stars--1" for="rating-1">1</label>
        <p>課程評分（點一下星星來評等，若未點選，則預設五顆星)</p>
        <textarea class="text" name="comments" placeholder="有什麼想對這門課程說的話呢" maxlength="30" >${course_assessSvc.checkMembers(sessionScope.loginMembersVO.memno,courseno).comments}</textarea>
        
    </div>
     <input type="hidden" name="asesno" value="${course_assessSvc.getOneCourse_assess(sessionScope.loginMembersVO.memno).asesno}">
    <input type="hidden" name="courseno" value="${courseno}">
    <input type="hidden" name="action" value="update">
    <input type="submit" style="font-family:'Gochi Hand'" id="register" name="signup" id="signup" class="form-submit" value="Submit"/>
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
                    
                    
                </div>
        

    
  

    <!-- JS -->
    <%-- <%@ include file="/index/front-index/foottest.jsp" %> --%>
</body>
<script>
$(document).ready(function(){
	var type = ${course_assessSvc.getOneCourse_assess(sessionScope.loginMembersVO.memno).coursescore}
	if(type==1){
		$("input[name='coursescore'][value=1]").attr("checked", true);
	}else if(type ==2){
		$("input[name='coursescore'][value=2]").attr("checked", true);
	}else if(type ==3){
		$("input[name='coursescore'][value=3]").attr("checked", true);
	}else if(type ==4){
		$("input[name='coursescore'][value=4]").attr("checked", true);
	}else{
		$("input[name='coursescore'][value=5]").attr("checked", true);
	}
	
});


</script>


<script src="<%=request.getContextPath()%>/front-end/members/assets/js/members&teacher&course_assess.js"></script>



</html>