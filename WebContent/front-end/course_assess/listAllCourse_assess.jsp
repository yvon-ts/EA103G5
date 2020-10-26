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
input#signin{
margin:10px 0 0 70px ;

}

select {
  -webkit-appearance: none;
  -moz-appearance: none;
  -ms-appearance: none;
  appearance: none;
  outline: 0;
  box-shadow: none;
  border: 0 !important;
  background: #2c3e50;
  background-image: none;
}
/* Remove IE arrow */
select::-ms-expand {
  display: none;
}
/* Custom Select */
.select {
  position: relative;
  display: flex;
  width: 20em;
  height: 3em;
  line-height: 3;
  background: #2c3e50;
  overflow: hidden;
  border-radius: .25em;
 
}
select {
  flex: 1;
  padding: 0 .5em;
  color: #fff;
  cursor: pointer;
}
/* Arrow */
.select::after {
  content: '\25BC';
  position: absolute;
  top: 0;
  right: 0;
  padding: 0 1em;
  background: #34495e;
  cursor: pointer;
  pointer-events: none;
  -webkit-transition: .25s all ease;
  -o-transition: .25s all ease;
  transition: .25s all ease;
   margin-left:10px;
}
/* Transition */
.select:hover::after {
  color: #f39c12;
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
 input.register{
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
margin:25px 0 0 200px ;


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
            
            
            
							<c:forEach var="course_assessVO" items="${list}" begin="<%=pageIndex%>"
								end="<%=pageIndex+rowsPerPage-1%>" varStatus="s">
                <div class="signin-content">
                    <div class="signin-image">
                        <a href=""><img class="pic" src="<%=request.getContextPath()%>/back-end/members/MprofileDisplayServlet?MEMNO=${course_assessVO.memno}" alt="sing up image"></a>
                        
                        <h4 style="font-family:Gochi Hand" class="nkname">${membersSvc.getOneMembers(course_assessVO.memno).nkname}
                        
                            <c:if test="${empty teacherSvc.getStatus(course_assessVO.memno)}">
							<img id="nav_icon" src='<%=request.getContextPath()%>/front-end/members/assets/img/students.svg'>
							</c:if>
							
							<c:if test="${teacherSvc.getStatus(course_assessVO.memno).tchrstatus eq '待審核'}">
							<img id="nav_icon" src='<%=request.getContextPath()%>/front-end/members/assets/img/students.svg'>
							</c:if>
							
							<c:if test="${teacherSvc.getStatus(course_assessVO.memno).tchrstatus eq '已通過'}">
							<img id="nav_icon" src='<%=request.getContextPath()%>/front-end/members/assets/img/teacher.svg'>
							</c:if>
							
							<c:if test="${teacherSvc.getStatus(course_assessVO.memno).tchrstatus eq '未通過'}">
							<img id="nav_icon" src='<%=request.getContextPath()%>/front-end/members/assets/img/students.svg'>
							
							</c:if>
                        
                        
                        
                        
                          </h4>
                        
                    </div>
                    <div class="signin-form">
                           <div class="form-group">
                           <c:forEach var="num" begin="1" end="${course_assessVO.coursescore}" step="1">

                           <img class="icon" src="<%=request.getContextPath()%>/front-end/members/signIn&updateMembers_css/images/star.svg">
                              
                           </c:forEach> 
                           
                        	   
                           
                           
                                </div>
                            <div class="form-group">
                                <p class="text">${course_assessVO.comments}</p>
                                <p class="date"><fmt:formatDate value="${course_assessVO.commenttime}" type="date" dateStyle="full"/></p>
                            </div>
                    </div>
                </div>
                </c:forEach>
                <%@ include file="page2.file"%>
                <%if (pageNumber>1) {%>
                <div>
    <FORM METHOD="post" ACTION="<%=request.getRequestURI()%>">  
       <select size="1"  name="whichPage">
       <option selected disabled>Choose an option</option>
         <%for (int i=1; i<=pageNumber; i++){%>
            <option value="<%=i%>">跳至第<%=i%>頁
         <%}%> 
       </select>
       <input class="register" type="submit" value="確定" >  
    </FORM>
    </div>
  <%}%>
                
                
                
                
                
                
                
                
                
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
var inform5 = ${inform5};

if(inform5 == 200){
	swal('新增成功', '感謝您撥空留下您寶貴的意見', 'success');
}else if(inform5 == 100){
	swal('修改成功', '感謝您撥空修改您寶貴的意見', 'success');
}



$(document).ready(function(){
	
	
	var counter = 0; /*計數器*/
	var pageStart = 0; /*offset*/
	var pageSize = 3; /*size*/
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
			memno:$('#memno').val(),
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
				
				
				result += 	`<div class="col-md-6 col-lg-4 col-xs-12">`;
				result +=	`<div class="services-item wow fadeInRight" data-wow-delay="0.3s">`;
				result +=	`<div class="icon">`
				result +=	`<img src="<%=request.getContextPath()%>/course/CoursePictureReaderFromDB?courseno=` + JSONarray[i].courseno  +`" style="width: 200px; height: 150px;" class="pic"></div>`;
        			
				result +=   `<div class="services-content">`;
        		result += 	`&nbsp;&nbsp;&nbsp;<div class="rateit" data-rateit-value="`+ JSONarray[i].csscore / JSONarray[i].csscoretimes + `" data-rateit-ispreset="true" data-rateit-readonly="true"></div> `; 
  	
        		result +=	`<br>&nbsp;&nbsp;&nbsp;`+ JSONarray[i].csscoretimes  + `則評價`;
        		result +=   `<h3><a href="#">`+ JSONarray[i].coursename + `</a></h3>`;
        		result +=   `<p>課程共` + JSONarray[i].ttltime + `分鐘</p>`;
            
        		result += 	`<label class="shoppingcart">
								<i class="fa fa-shopping-cart" aria-hidden="true">
									<input type ="hidden" name="courseno" 	 id="courseno"   value ="${courseVO.courseno}"/>
									<input type ="hidden" name="courseprice" id="courseprice" value ="${courseVO.courseprice}"/>
									<input type ="hidden" name="courseinfo"  id="courseinfo"  value ="${courseVO.courseinfo}"/>
								</i>&nbsp;加入購物車
							</label>`;
				result += `<h5>NT$` + JSONarray[i].courseprice + `</h5></div></div></div></div>`;
        
			}
			
			
			$('.trackingArea').append(result);
			
			$("div.rateit, span.rateit").rateit();


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


<script src="<%=request.getContextPath()%>/front-end/members/assets/js/members&teacher&course_assess.js"></script>








</html>