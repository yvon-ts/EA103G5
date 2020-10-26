<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="com.members.model.*"%>
<%@ page import="com.course_assess.model.*"%>
<%@ page import="com.teacher.model.*"%>
<%@ page import="java.util.*"%>

<%
Course_assessService course_assessSvc = new Course_assessService();
String avg = course_assessSvc.avgScore("COUR0001");
List<Course_assessVO> list = course_assessSvc.getAll("COUR0001");
pageContext.setAttribute("list", list);
pageContext.setAttribute("avg",avg);
pageContext.setAttribute("course_assessSvc",course_assessSvc);
String inform5 = (String)request.getAttribute("inform5");		
%>

<%@ include file="/index/front-index/header.jsp" %>
<jsp:useBean id="membersSvc" scope="page" class="com.members.model.MembersService" />


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Xducation-會員登入</title>

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/6.10.3/sweetalert2.css" />
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/6.10.3/sweetalert2.js"
	type="text/javascript"></script>
	<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
	<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/jquery.rateit/1.1.3/rateit.css" />
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
 img.icon1{
 width:36px;
 height:36px;
 margin:1px 0 0 10px;
 vertical-align:unset;
 
 }
 button.register{
  display: inline-block;
  background: #6dabe4;
  color: #fff;
  border-bottom: none;
  width: auto;
 border:1px;
  border-radius: 5px;
  margin-left: 5px;
  cursor: pointer; 
  
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
  padding:16px;
  text-align:center;

  }
 
/* Remove IE arrow */
 div#bg{
 width:850px;
 height:auto; 
 -webkit-box-shadow: 0 0 15px #8E8E8E;
	-moz-box-shadow: 0 0 15px #8E8E8E;
	box-shadow: 0 0 15px #5B5B5B;
	padding-top:100px;
	padding-bottom:50px;
 }
 section#copyright{
 height:200px;
 }
 input.input{
font-family:'Gochi Hand';
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
width:100%;
height:100%;
font-size:18px;

}
p.date{
width:100%;
text-align:center;
margin:25px 0 0 170px ;


}
h4.nkname{
width:200px;
height:50px;
margin:12px 0 0 25px ;

}
.signup-image-link {
    margin-top: 20px;
    margin-left:5px;
    }
    div,p{
    font-family:'Gochi Hand';
    }
    div#count{
    width:300px;
    height:100px;
    position:absolute;
    z-index:2;
    margin:-25px 0 0 140px;
    font-size:20px;
    color:#D0D0D0;
    
    }
    div#title{
     width:300px;
    height:50px;
    position:absolute;
    z-index:2;
    margin:-25px 0 0 23px;
    font-size:20px;
    color:#FF0000;
    
    }
    div#avg{
    width:300px;
    height:50px;
    position:absolute;
    z-index:2;
    margin:-130px 0 0 10px;
    font-size:80px;
    color:#0099CC;
    }
  
    
    
    
div.main{
padding:150px 0 0 0;
background: url("<%=request.getContextPath()%>/front-end/members/assets/img/bgPic.png");


}

</style>



<body>

      <div class="main">
<section class="sign-in">
            <div id="bg" class="container">
            
             <%@ include file="page1.file"%>
            <div id="avg">${avg}</div>
            <c:if test="${not empty sessionScope.membersVO}">
           <c:if test="${empty course_assessSvc.getOneCourse_assess(sessionScope.membersVO.memno)}">
				 <a id='add' href="<%=request.getContextPath()%>/front-end/course_assess/addCourse_assess.jsp">發表評價</a>							
		   </c:if>
            <c:if test="${not empty course_assessSvc.getOneCourse_assess(sessionScope.membersVO.memno)}">
				 <a id='add' href="<%=request.getContextPath()%>/front-end/course_assess/updateCourse_assess.jsp">修改評價</a>
		   </c:if>
		   </c:if>
            
            
            
					<div class="course_assessArea"></div>		
              
               
                
                
                <div>
                
                <input type="hidden" id="courseno" value="COUR0001" />
                <button class="register" id="js-load-more" >載入更多</button>
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
function status(){
	
	 swal('老師資格審核中', '請耐心等候1~3個工作天，一但審核完畢，即會立刻通知', 'info');
}

 var inform5 = ${inform5};

if(inform5 == 200){
	swal('新增成功', '感謝您撥空留下您寶貴的意見', 'success');
}else if(inform5 == 100){
	swal('修改成功', '感謝您撥空修改您寶貴的意見', 'success');
} 



$(document).ready(function(){
	
	
	var counter = 0; /*計數器*/
	var pageStart = 0; /*offset*/
	var pageSize = 2; /*size*/
	/*首次載入*/
	getData(pageStart, pageSize);
	/*監聽載入更多*/
	

	
	$(document).on('click', '#js-load-more', function(){
	counter++ ;
	pageStart = counter * pageSize;
	pageEnd = 	( counter + 1 ) * pageSize;
	getData(pageStart, pageEnd);
	});
	
});
function getData(offset,size){
	$.ajax({
		type: 'POST',
		url: "<%=request.getContextPath()%>/course_assess/course_assess.do", 
		data:{
			courseno:$('#courseno').val(),
			action:'getAll'
		},
		success: function(data){
			var JSONarray = JSON.parse(data);
			
//				console.log(JSONarray);
//				/****業務邏輯塊：實現拼接html內容並prepend到頁面*********/
			var sum = JSONarray.length;
			console.log(offset,size,sum);
//				/*如果剩下的記錄數不夠分頁，就讓分頁數取剩下的記錄數
//				* 例如分頁數是5，只剩2條，則只取2條
			var result = '';
			
			if(sum - offset < size ){
				size = sum - offset;
				}
			
			for(let i=offset; i< (offset+size); i ++){
				
				result +=   `<div class="signin-content">`;
				result += 	`<div class="signin-image">`;
				result +=	`<a href=''>`;
				result += `<img class="pic" src='<%=request.getContextPath()%>/back-end/members/MprofileDisplayServlet?MEMNO=` + JSONarray[i].memno  +`' alt='sing up image'></a>`;
				result +=	`<h4 style="font-family:Gochi Hand" class="nkname">`+JSONarray[i].nkname
				
				if(JSONarray[i].tchrstatus===null){
				result += `<img id="nav_icon" src='<%=request.getContextPath()%>/front-end/members/assets/img/students.svg'></h4></div>`;
				}else if(JSONarray[i].tchrstatus==='待審核'){
				result += `<img id="nav_icon" src='<%=request.getContextPath()%>/front-end/members/assets/img/students.svg'></h4></div>`;
				}else if(JSONarray[i].tchrstatus==='已通過'){
			    result += `<img id="nav_icon" src='<%=request.getContextPath()%>/front-end/members/assets/img/teacher.svg'></h4></div>`;
		        }else if(JSONarray[i].tchrstatus==='待審核'){
		        result += `<img id="nav_icon" src='<%=request.getContextPath()%>/front-end/members/assets/img/students.svg'></h4></div>`;
		        }
					
			    result += `<div class="signin-form">`;
			    result += `<div class="form-group">`;
			    
			    for(var x = JSONarray[i].coursescore;x >0;x-- ){
			    	 result += `<img class="icon" src="<%=request.getContextPath()%>/front-end/members/signIn&updateMembers_css/images/star.svg">`;
			    }
			    result += `</div>`;
			    result += ` <div class="form-group">`;
			    result += `<p class="text">`+JSONarray[i].comments+`</p>`;
			  
			    result += `<p class="date">`+JSONarray[i].string_commenttime +`</p></div></div></div>`;
			    
			
        		
			}
			
			
			$('.course_assessArea').append(result);
			


//			/*隱藏more按鈕*/
		if ( (offset + size) >= sum){
			$("#js-load-more").hide();
		}else{
			$("#js-load-more").show();
		}
		}	
		});
	}


























</script>

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.rateit/1.1.3/jquery.rateit.min.js"></script>
<%-- <script src="<%=request.getContextPath()%>/front-end/members/assets/js/members&teacher&course_assess.js"></script>

 --%>






</html>