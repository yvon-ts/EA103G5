<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="com.members.model.*"%>
<%@ page import="com.course_assess.model.*"%>
<%@ page import="com.teacher.model.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.course.model.*"%>

<%
String courseno =(String)request.getParameter("courseno");
Course_assessService course_assessSvc = new Course_assessService();
String avg = course_assessSvc.avgScore(courseno);
List<Course_assessVO> list = course_assessSvc.getAll(courseno);
pageContext.setAttribute("courseno", courseno);
pageContext.setAttribute("list", list);
pageContext.setAttribute("avg",avg);
pageContext.setAttribute("course_assessSvc",course_assessSvc);
String inform5 = (String)request.getAttribute("inform5");
MembersVO membersVO = (MembersVO) session.getAttribute("membersVO");
%>

<jsp:useBean id="membersSvc" scope="page" class="com.members.model.MembersService" />
<jsp:useBean id="teacherSvc" scope="page" class="com.teacher.model.TeacherService" />


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Xducation-會員評價</title>

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/6.10.3/sweetalert2.css" />
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/6.10.3/sweetalert2.js"
	type="text/javascript"></script>
	<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
	
    <!-- Main css -->
    <%-- <link rel="stylesheet" href="<%=request.getContextPath()%>/front-end/members/signIn&updateMembers_css/style.css">
     <link rel="stylesheet" href="<%=request.getContextPath()%>/front-end/members/nav_css_ForSignIn&addMembers/css/bootstrap.min.css"> --%>
<%--     <link rel="stylesheet" href="<%=request.getContextPath()%>/front-end/members/nav_css_ForSignIn&addMembers/css/nivo-lightbox.css"> --%>
<%--     <link rel="stylesheet" href="<%=request.getContextPath()%>/front-end/members/nav_css_ForSignIn&addMembers/css/animate.css"> --%>
<%--     <link rel="stylesheet" href="<%=request.getContextPath()%>/front-end/members/nav_css_ForSignIn&addMembers/css/main.css"> --%>
<%--     <link rel="stylesheet" href="<%=request.getContextPath()%>/front-end/members/nav_css_ForSignIn&addMembers/css/responsive.css"> --%>

</head>

<style>
img.pic{
	box-shadow: 3px 3px 5px 5px #BEBEBE;
	width:100px;
height:100px;

	  margin-left: 30px;
    margin-top: 40px;
    border-radius: 20px;
    	position: sticky;

}
h2.form-title{
width:600px;
height:200px;

font-size:120px;
font-family:'Gochi Hand';
margin:-240px 0 0 -30px;


}

 img.icon{
 width:33px;
 height:33px;
 
 }
 img.nav_icon{
 width:36px;
 height:36px;
 margin:0px 0 0 5px;
 
 }
 button.register{
  display: inline-block;
  background: #6dabe4;
  color: #fff;
  border-bottom: none;
  width: auto;
 border:1px;
  border-radius: 5px;
  margin-left: 330px;
  cursor: pointer; 
  width:150px;
  height:50px;
  font-family:'Gochi Hand';
  border-radius:5px;
  
  }
  div.form-group1{
  width:500px;
  height:50px;
  margin:-150px 0 0 200px;
 }
  
  a#add{
   display: inline-block;
  background: #6dabe4;
  color: #fff;
  border-bottom: none;
  width: 200px;
 border:1px;
  border-radius: 5px;
  margin-left: 600px;
  cursor: pointer; 
  position: absolute;
  z-index:2;
  margin-top:-80px;
  height:80px;
  font-size:30px;
  padding:27px;
  text-align:center;

  }
 
 div#bg{
 width:850px;
 height:auto; 
 /* -webkit-box-shadow: 0 0 15px #8E8E8E;
	-moz-box-shadow: 0 0 15px #8E8E8E;
	box-shadow: 0 0 15px #5B5B5B; */
	padding-top:100px;
	padding-bottom:50px;
 }
 

div.signin-form{
margin-right: 10px;
margin-left:0px;
margin-top:-10px;
width:800px;
height:150px;


}
div.signin-image{
margin-left: 0px;
    margin-right: 20px;
    margin-top: -50px;
    height:200px;
    width:400px;
    
}
div.signin-content{
padding-top:40px;
padding-bottom:30px;
    height: 200px;
     border-radius: 20px;
     margin:20px 1px;
background:#F0F0F0;    
}
p.text{
width: 600px;
    height: 100%;
    font-size: 18px;
    text-align: left;
    padding-top: 10px;
    font-family: 'Gochi Hand';
    margin-left: 200px;
}
p.date{
width:100%;
text-align:center;
margin:30px 0 0 300px;
font-family:'Gochi Hand';


}
h4.nkname{
width:200px;
height:50px;
margin:12px 0 0 30px;


}
.signup-image-link {
    margin-top: 20px;
    margin-left:5px;
    }
   
    div#count{
    width:300px;
    height:100px;
    position:absolute;
    z-index:2;
    margin:-25px 0 0 140px;
    font-size:20px;
    color:#ADADAD;
    font-family:'Gochi Hand';
    
    }
    div#title{
     width:300px;
    height:50px;
    position:absolute;
    z-index:2;
    margin:-25px 0 0 23px;
    font-size:20px;
    color:#FF0000;
    font-family:'Gochi Hand';
    
    }
    div#avg{
    width:300px;
    height:50px;
    position:absolute;
    z-index:2;
    margin:-45px 0 0 10px;
    font-size:100px;
    color:#0099CC;
    font-family:'Gochi Hand';
    }
  
    
    
    
div.main{
padding:0px 0 0 0;


}

</style>



<body>
<jsp:include page="/index/front-index/header.jsp" />


<!-- 新增留言 -->
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
<!-- 修改留言 -->
















      <div class="main">
            <div id="bg" class="container">
            
             <%@ include file="page1.file"%>
            <div id="avg">${avg}</div>
            <c:if test="${not empty sessionScope.loginMembersVO}">
            
           <c:if test="${empty course_assessSvc.checkMembers(sessionScope.loginMembersVO.memno,courseno)}">
				 <a id='add' href="<%=request.getContextPath()%>/front-end/course_assess/addCourse_assess.jsp?courseno=${courseno}">發表評價</a>							
		   </c:if>
		   
		   
            <c:if test="${not empty course_assessSvc.checkMembers(sessionScope.loginMembersVO.memno,courseno)}">
				 <a id='add' href="<%=request.getContextPath()%>/front-end/course_assess/updateCourse_assess.jsp?courseno=${courseno}">修改評價</a>
		   </c:if>
		   </c:if>
            
            
            
					<div class="course_assessArea"></div>		
              
               
                
                
                <div>
                <input type="hidden" id="inform5" value="${requestScope.inform5}">
                <input type="hidden" id="courseno" value="${courseno}" />
                <button class="register" id="js-load-more" >More</button>
                </div>
                
                
                
                
                
                
                
                
                
            </div>
         

    </div>
    

    <!-- JS -->
    <%-- <%@ include file="/index/front-index/foottest.jsp" %> --%>
</body>



<script>
function status(){
	
	 swal('老師資格審核中', '請耐心等候1~3個工作天，一但審核完畢，即會立刻通知', 'info');
}

var inform5 = '${inform5}'

if(inform5 === '200'){
	swal('新增成功', '感謝您撥空留下您寶貴的意見', 'success');
}else if(inform5 === '100'){
	swal('修改成功', '感謝您撥空修改您寶貴的意見', 'success');
}else if(inform5.length!=0){
	swal(inform5+'的個人檔案', '是未公開的', 'warning');
}



$(document).ready(function(){
	var pageSize = 7;
	
	
	
	
	
	$(document).on('click','#course_assess',function(){
		 /*size*/
		/*首次載入*/
		getData(pageSize);
		/*監聽載入更多*/
	});
	
	

	
	$(document).on('click', '#js-load-more', function(){
	pageSize+=7 ;
	
	
	getData(pageSize);
	});
	
});
function getData(counter){
	$.ajax({
		type: 'POST',
		url: "<%=request.getContextPath()%>/course_assess/course_assess.do", 
		data:{
			courseno:$('#courseno').val(),
			pagesize:counter,
			action:'getAllForAjax'
		},
		success: function(data){
			console.log('ajax good!')
			var JSONarray = JSON.parse(data);
			if (JSONarray.length==0){
				$("#js-load-more").hide();
				swal('沒有評價囉', '就靠你拉朋友來衝我們的評價啦', 'info');				
			}
			
//				/****業務邏輯塊：實現拼接html內容並prepend到頁面*********/
			var sum = JSONarray.length;
			
//				/*如果剩下的記錄數不夠分頁，就讓分頁數取剩下的記錄數
//				* 例如分頁數是5，只剩2條，則只取2條
			
			var result ='';
			for(let i=0; i<sum; i ++){
				result +=   `<div class="signin-content">`;
				result += 	`<div class="signin-image">`;
				
				result += `<a  target="_blank" href="<%=request.getContextPath()%>/members/members.do?action=getOne_For_Display&courseno=`+$('#courseno').val()+`&memno=` + JSONarray[i].memno  +`&requestURL=<%=request.getServletPath()%>&whichPage=<%=whichPage%>"><img class="pic" src='<%=request.getContextPath()%>/front-end/members/MprofileDisplayServlet?MEMNO=` + JSONarray[i].memno  +`' alt='sing up image'></a>`;
				
				
				result +=	`<h4 style="font-family:Gochi Hand" class="nkname">`+JSONarray[i].nkname
				if(JSONarray[i].tchrstatus==='未申請'){
				result += `<img class="nav_icon" src='<%=request.getContextPath()%>/front-end/members/assets/img/students.svg'></h4></div>`;
				}else if(JSONarray[i].tchrstatus==='待審核'){
				result += `<img class="nav_icon" src='<%=request.getContextPath()%>/front-end/members/assets/img/students.svg'></h4></div>`;
				}else if(JSONarray[i].tchrstatus==='已通過'){
			    result += `<img class="nav_icon" src='<%=request.getContextPath()%>/front-end/members/assets/img/teacher.svg'></h4></div>`;
		        }else if(JSONarray[i].tchrstatus==='未通過'){
		        result += `<img class="nav_icon" src='<%=request.getContextPath()%>/front-end/members/assets/img/students.svg'></h4></div>`;
		        }
					
			    result += `<div class="signin-form">`;
			    result += `<div class="form-group1">`;
			    
			    for(var x = JSONarray[i].coursescore;x >0;x-- ){
			    	 result += `<img class="icon" src="<%=request.getContextPath()%>/front-end/members/signIn&updateMembers_css/images/star.svg">`;
			    }
			    result += `</div>`;
			    result += ` <div class="form-group2">`;
			    result += `<p class="text">`+JSONarray[i].comments+`</p>`;
			  
			    result += `<p class="date">`+JSONarray[i].string_commenttime +`</p></div></div></div>`;
			    
			
        		
			}
			
				$('.course_assessArea').append(result);
			
			


		
		}	
		});
	}


























</script>

<%-- <script src="<%=request.getContextPath()%>/front-end/members/assets/js/members&teacher&course_assess.js"></script>

 --%>






</html>