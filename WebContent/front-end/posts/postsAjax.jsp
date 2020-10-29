<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="com.posts.model.*"%>
<%@ page import="com.course.model.*"%>
<%@ page import="com.members.model.*"%>
<%@ page import="com.report_detail.model.*"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	PostsService postsSvc = new PostsService();
	List<PostsVO> list = postsSvc.getAll();
	request.setAttribute("list", list);
%>

<%
MembersVO membersVO = (MembersVO) session.getAttribute("loginMembersVO");
// CourseVO courseVO = (CourseVO) request.getAttribute("courseVO");


boolean flag = true;

if(membersVO == null){
	flag = false;
	System.out.println("我是訪客");
	
}
else{
	System.out.println("目前登入的是:" + membersVO.getMemno());
}

%>



<%
// String courseno = (String)request.getParameter("courseno");

//須由前端給值
String courseno = "COUR0001";
pageContext.setAttribute("courseno", courseno);
pageContext.setAttribute("membersVO", membersVO);

// CourseService courseSrv = new CourseService();
// CourseVO courseVO = courseSrv.getOneCourse(courseno);
// pageContext.setAttribute("courseVO", courseVO);
// System.out.println("測試的課程編號=" + courseno + "，課程名稱=" + courseVO.getCoursename() );

%>



<jsp:useBean id="postSvc" scope="page" class="com.posts.model.PostsService"/>
<jsp:useBean id="memSvc" scope="page" class="com.members.model.MembersService"/>
<jsp:useBean id="reportSvc" scope="page" class="com.report_detail.model.ReportDetailService"/>

<!DOCTYPE html>
<html>
<head>	
		
<meta charset="UTF-8">
<title>Insert title here</title>

</head>
	<link rel="stylesheet" href="<%=request.getContextPath()%>/library/bootstrap/4.5.3/css/bootstrap.min.css">

<style>
.button1{
	display:inline-block;
	color: -internal-light-dark(white);
}
/* #btn{ */
/* width:60px; */
/* height: 44px; */
/* background-color:#0099CC; */
/* color:white; */
/* font-weight: bolder; */
/* border-radius:10px; */

/* } */

</style>
<style>
/**
 * Oscuro: #283035
 * Azul: #03658c
 * Detalle: #c7cacb
 * Fondo: #dee1e3
 ----------------------------------*/
* {
	margin: 0;
	padding: 0;
	-webkit-box-sizing: border-box;
	-moz-box-sizing: border-box;
	box-sizing: border-box;
}
a {
	color: #03658c;
	text-decoration: none;
}
ul {
	list-style-type: none;
}
body {
	font-family: 'Roboto', Arial, Helvetica, Sans-serif, Verdana;
	background: #ffffff;
}
/** ====================
 * Lista de Comentarios
 =======================*/
.comments-container {
	margin: 60px auto 15px;
	width: 768px;
}
.comments-container h1 {
	font-size: 36px;
	color: #283035;
	font-weight: 400;
}
.comments-container h1 a {
	font-size: 18px;
	font-weight: 700;
}
.comments-list {
	margin-top: 30px;
	position: relative;
}
/**
 * Lineas / Detalles
 -----------------------*/
.comments-list:before {
	
	width: 2px;
	height: 100%;
	background: #c7cacb;
	position: absolute;
	left: 32px;
	top: 0;
}
.comments-list:after {
	
	position: absolute;
	background: #c7cacb;
	bottom: 0;
	left: 27px;
	width: 7px;
	height: 7px;
	border: 3px solid #dee1e3;
	-webkit-border-radius: 50%;
	-moz-border-radius: 50%;
	border-radius: 50%;
}
.reply-list:before, .reply-list:after {
	display: none;
}
.reply-list li:before {
	
	width: 60px;
	height: 2px;
	background: #c7cacb;
	position: absolute;
	top: 25px;
	left: -55px;
}
.comments-list li {
	margin-bottom: 15px;
	display: block;
	position: relative;
}
.comments-list li:after {
	content: '';
	display: block;
	clear: both;
	height: 0;
	width: 0;
}
.reply-list {
	padding-left: 88px;
	clear: both;
	margin-top: 15px;
}
/**
 * Avatar
 ---------------------------*/
.comments-list .comment-avatar {
	width: 65px;
	height: 65px;
	position: relative;
	z-index: 99;
	float: left;
	border: 3px solid #FFF;
	-webkit-border-radius: 4px;
	-moz-border-radius: 4px;
	border-radius: 4px;
	-webkit-box-shadow: 0 1px 2px rgba(0, 0, 0, 1);
	-moz-box-shadow: 0 1px 2px rgba(0, 0, 0, 1);
	box-shadow: 0 1px 2px rgba(0, 0, 0, 1);
	overflow: hidden;
}
.comments-list .comment-avatar img {
	width: 100%;
	height: 100%;
}
.reply-list .comment-avatar {
	width: 50px;
	height: 50px;
}
.comment-main-level:after {
	content: '';
	width: 0;
	height: 0;
	display: block;
	clear: both;
}
#postcontent{
width: 100%;
resize:none;
border: 0px;
outline: none;
}

.postcontent1{
width: 100%;
resize:none;
border: 0px;
outline: none;
}
/**
 * Caja del Comentario
 ---------------------------*/
.comments-list .comment-box {
    border-width: 1px;
    border-style: groove;
    border-radius: 5px;
	width: 680px;
	float: right;
	position: relative;
/*   	-webkit-box-shadow: 0px 0px 0px 0px rgba(0, 1, 0, 1);   */
/*   	-moz-box-shadow: 1px 1px 1px 1px rgba(0, 1, 0, 1);   */
/*    	box-shadow: 1px 1px 1px 1px rgba(1, 1, 1, 1);    */
}
.comments-list .comment-box:before, .comments-list .comment-box:after {
	
	height: 0;
	width: 0;
	position: absolute;
	display: block;
	border-width: 10px 12px 10px 0;
	border-style: solid;
	border-color: transparent #A2D9FF;
	top: 8px;
	left: -11px;
}
.comments-list .comment-box:before {
	border-width: 11px 13px 11px 0;
	border-color: transparent rgba(0, 0, 0, 0);
	left: -12px;
}
.reply-list .comment-box {
	width: 610px;
}
.comment-box .comment-head {
	background: #A2D9FF;
	padding: 10px 12px;
 	border-bottom: 4px solid #E5E5E5;
	overflow: hidden;
	-webkit-border-radius: 4px 4px 0 4px;
	-moz-border-radius: 4px 4px 0 4px;
	border-radius: 4px 4px 0 4px;
}
.comment-box .comment-head i {
	float: right;
	margin-left: 14px;
	position: relative;
	top: 2px;
	color: #42d7f5;
	cursor: pointer;
	-webkit-transition: color 0.3s ease;
	-o-transition: color 0.3s ease;
	transition: color 0.3s ease;
}
.comment-box .comment-head i:hover {
	color: #03658c;
}
.comment-box .comment-name {
	color: #283035;
	font-size: 14px;
	font-weight: 700;
	float: left;
	margin-right: 10px;
}
.comment-box .comment-name a {
	color: #283035;
}
.comment-box .comment-head span {
	float: left;
	color: #999;
	font-size: 13px;
	position: relative;
	top: 1px;
}
.comment-box .comment-content {
	background: #fff;
	padding: 12px;
	font-size: 15px;
	color: #595959;
	-webkit-border-radius: 0 0 4px 4px;
	-moz-border-radius: 0 0 4px 4px;
	border-radius: 0 0 4px 4px;
}
.comment-box .comment-name.by-author, .comment-box .comment-name.by-author a
	{
	color: #03658c;
}
.comment-box .comment-name.by-author:after {
	content: 'autor';
	background: #03658c;
	color: #FFF;
	font-size: 12px;
	padding: 3px 5px;
	font-weight: 700;
	margin-left: 10px;
	-webkit-border-radius: 4px;
	-moz-border-radius: 4px;
	border-radius: 4px;
}
.add {
	postion: absolute;
	left: 500px;
}
/** =====================
 * Responsive
 ========================*/
@media only screen and (max-width: 766px) {
	.comments-container {
		width: 480px;
	}
	.comments-list .comment-box {
		width: 390px;
	}
	.reply-list .comment-box {
		width: 320px;
	}
}

.comments-list .comment-avatar {
margin-top: 0px;
    margin-left: 105px;
    width: 90px;
    height: 90px;
    position: relative;
    z-index: 99;
    float: left;
    border: 3px solid #FFF;
    -webkit-border-radius: 4px;
    -moz-border-radius: 4px;
    border-radius: 4px;
    -webkit-box-shadow: 0 1px 2px rgba(0, 0, 0, 1);
    -moz-box-shadow: 0 1px 2px rgba(0, 0, 0, 1);
    box-shadow: 0 1px 2px rgba(0, 0, 0, 1);
    overflow: hidden;
}
.com-ava{
margin-left: 87px !important;

}
</style>
<body>

	<!--上方留言區塊 -->

		<div class="container-fluid">
			<ul id="comments-list" class="comments-list">
				<li>
					<div class="comment-main-level">
						<!-- 新增留言  -->
							<c:if test="${sessionScope.loginMembersVO.memno != null}">
						<div class="comment-avatar">
							<img id='mprofile' src="<%=request.getContextPath()%>/front-end/members/MprofileDisplayServlet?MEMNO=${membersVO.memno}" alt="sing up image">
						</div>
						<input type="hidden" name="action" value="insert"/>
						<input type="hidden" name="memno" value="${membersVO.memno}"/>
						<input type="hidden" name="courseno" value="${courseVO.courseno}"/>
						<input type="hidden" name="superpostno" value=""/>
						<!-- textarea -->
						<div class="comment-box">
							<textarea rows="4" cols="50"  id="postcontent" name="postcontent" placeholder="please leave a message...">${memVO.memno}</textarea>
						
							<div align="right">
								<button id = "btn" class="btn btn-primary btn-sm">送出</button>
							</div>
						</div>
						</c:if>
					</div>
				</li>
			</ul>


	<!-- 課程留言 -->
	


	<c:forEach var="postsVO" items="${list}">
	
		<c:if test="${empty postsVO.superpostno}">
	
			<!-- 取得每位留言者的membersVO -->
			<c:set var="memVO" value="${memSvc.getOneMembers(postsVO.memno)}" scope="page"/>
		
<%-- 		<c:forEach var="memVO" items="${memSvc.all}"> --%>
<%-- 			<c:if test="${postsVO.memno == membersVO.memno}"> --%>
			
			<!-- 第一層留言內容 -->
			<div class="comment-main-level">
				<ul  class="comments-list">
					<li>
						<!-- 父文章 -->
						<div class="comment-avatar">
							<img id='mprofile' src="<%=request.getContextPath()%>/front-end/members/MprofileDisplayServlet?MEMNO=${postsVO.memno}" alt="sing up image">
						</div>
	
						<div class="comment-box">
							<div class="comment-head">
							
							
								<h6 class="comment-name">						
									${memVO.memname}&nbsp;&nbsp;|&nbsp;&nbsp;<fmt:formatDate value="${postsVO.posttime}" pattern="yyyy-MM-dd HH:mm"/>
								</h6>
								
								<span></span>
								<div align="right">
									<c:if test="${membersVO.memno == memVO.memno}">
<%-- 										<input type="button" onclick="toggleA('${postsVO.postno}_reply')" class="button1" value="修改"></input> --%>
									
											<img onclick="toggleA('${postsVO.postno}_reply')" src="<%=request.getContextPath() %>/front-end/posts/images/edit.png" style="width:15px;height:15px;"/>
											
											<a href="<%=request.getContextPath()%>/posts/posts.do?postno=${postsVO.postno}&action=update_Status_Remove"><img src="<%=request.getContextPath() %>/front-end/posts/images/delete.png" style="width:15px;height:15px"></a>
											
<%-- 											<form METHOD="post"  ACTION="<%=request.getContextPath()%>/posts/posts.do" class="button1" accept-charset="utf-8"> --%>
<!-- 											<input type="submit"  value="刪除"></input> -->
<!-- 											<input type="hidden" name="action" value="update_Status_Remove" /> -->
<%-- 											<input type="hidden" name="postno" value="${postsVO.postno}"/> --%>
<!-- 											</form> -->
									</c:if>
									<!--檢舉 -->
<%-- 									<button onclick="report()"><img src="<%=request.getContextPath() %>/front-end/posts/images/flag.png" style="width:15px;height:15px"></button> --%>
									<a href="<%=request.getContextPath()%>/report_detail/report_detail.do?memno=${memVO.memno}&postno=${postsVO.postno}&action=getOne_For_Update_AddReport"><img src="<%=request.getContextPath() %>/front-end/posts/images/flag.png" style="width:15px;height:15px"></a>
<%-- 									<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/report_detail/report_detail.do"> --%>
<%-- 										<input type="hidden" name="memno" value="${memVO.memno}"/> --%>
<%-- 										<input type="hidden" name="postno" value="${postsVO.postno}"/> --%>
<!-- 										<input type="hidden" name="action"	value="getOne_For_Update_AddReport"> -->
<!-- 										<input id="reportBtn" type="submit" value="檢舉"> -->
<!-- 										</FORM> -->
									
									<%--<input type="button" onclick="toggleA('${postsVO.postno }')" value="回覆"> --%>
<%-- 									<button id="btn" onclick="toggleA('${postsVO.postno}')" type="button"><img onclick="toggleA('${postsVO.postno}'" src="<%=request.getContextPath() %>/front-end/posts/images/reply.png" style="width:15px;height:15px;"></button> --%>
<%-- 										<button id="btn" onclick="toggleA('${postsVO.postno}')" type="button">cancel</button> --%>
										<img onclick="toggleA('${postsVO.postno}')" src="<%=request.getContextPath() %>/front-end/posts/images/message.png" style="width:15px;height:15px;"/>
									</div>				
								</div>				
							<div class="comment-content">${postsVO.postcontent}</div>
							<div class="comment-content">
								<form METHOD="post" id="${postsVO.postno}_reply" ACTION="<%=request.getContextPath()%>/posts/posts.do" style="display:none" accept-charset="utf-8">
									<input type="hidden" name="action" value="update" />
									<textarea name="postcontent" style="width:100%">${postsVO.postcontent}</textarea>
									<input type="hidden" name="postno" value="${postsVO.postno}"/>
									<input type="hidden" name="superpostno" value="${postsVO.superpostno}"/>
									<input type="hidden" name="memno" value="${postsVO.memno}"/>
									<input type="hidden" name="courseno" value="${postsVO.courseno}"/>
									<input id = btn type="submit" value="送出"/> 
								
								</form>
								</div>
						</div>
					</li>
				</ul>
			</div>
			
			</c:if>
				<!-- 第一層留言內容  END-->
	
		
				<!-- 第二層留言 -->	
				<c:forEach var="postsVOSub" items="${list}">
					<c:forEach var="memVOSub" items="${memSvc.all}">
					<c:if test="${postsVOSub.memno == memVOSub.memno && postsVOSub.superpostno == postsVO.postno}">
						<!-- 回覆留言 -->
						<ul class="comments-list reply-list">
							<li>
								<!-- Avatar -->
								<div class="comment-avatar com-ava">
									<img id='mprofile' src="<%=request.getContextPath()%>/front-end/members/MprofileDisplayServlet?MEMNO=${postsVOSub.memno}" alt="sing up image">
								</div> <!-- Contenedor del Comentario -->
								<div class="comment-box">
									<div class="comment-head">
										<h6 class="comment-name">
											${memVOSub.memname}&nbsp;&nbsp;|&nbsp;&nbsp;<fmt:formatDate value="${postsVOSub.posttime}" pattern="yyyy-MM-dd HH:mm"/>
					
										</h6>
										<div align="right">
											<c:if test="${membersVO.memno == memVOSub.memno}">
<%-- 												<input type="button" onclick="toggleA('${postsVOSub.postno}_reply')" class="button1" value="修改"></input> --%>
												
												<img onclick="toggleA('${postsVOSub.postno}_reply')" src="<%=request.getContextPath() %>/front-end/posts/images/edit.png" style="width:15px;height:15px;"/>
												
												
												<a href="<%=request.getContextPath()%>/posts/posts.do?postno=${postsVOSub.postno}&action=update_Status_Remove"><img src="<%=request.getContextPath() %>/front-end/posts/images/delete.png" style="width:15px;height:15px"></a>
												
<%-- 												<form METHOD="post" ACTION="<%=request.getContextPath()%>/posts/posts.do" class="button1" accept-charset="utf-8"> --%>
<!-- 												<input type="submit"  value="刪除"></input> -->
<!-- 												<input type="hidden" name="action" value="update_Status_Remove" /> -->
<%-- 												<input type="hidden" name="postno" value="${postsVOSub.postno}"/> --%>
<!-- 												</form> -->
											</c:if>
											<!--檢舉 -->
<%-- 											<button type ="button" onclick="report()"><img src="<%=request.getContextPath() %>/front-end/posts/images/flag.png" style="width:15px;height:15px"></button> --%>
										<a href="<%=request.getContextPath()%>/report_detail/report_detail.do?memno=${memVO.memno}&postno=${postsVO.postno}&action=getOne_For_Update_AddReport"><img src="<%=request.getContextPath() %>/front-end/posts/images/flag.png" style="width:15px;height:15px"></a>
										</div>
									</div>
									<div class="comment-content">${postsVOSub.postcontent}</div>
									<div class="comment-content">
										<form METHOD="post"  id="${postsVOSub.postno}_reply" ACTION="<%=request.getContextPath()%>/posts/posts.do" style="display:none" accept-charset="utf-8">
											<input type="hidden" name="action" value="update" />
											<textarea name="postcontent" style="width:100%">${postsVOSub.postcontent}</textarea>
											<input type="hidden" name="postno" value="${postsVOSub.postno}"/>
											<input type="hidden" name="superpostno" value="${postsVOSub.superpostno}"/>
											<input type="hidden" name="memno" value="${postsVOSub.memno}"/>
											<input type="hidden" name="courseno" value="${postsVOSub.courseno}"/>
											<input id = btn type="submit" value="送出"/> 
<!-- 										<input id ="${postsVOSub.postno}" btn type="submit" value="送出"/>  -->
										
										</form>
									</div>
									</div>
							</li>
						</ul>	
						</c:if>
					</c:forEach>
				</c:forEach>
		
				<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/posts/posts.do" name="form1"  accept-charset="utf-8" id="${postsVO.postno }" style="display:none">
				
					<ul  class="comments-list"  id="${postsVO.postno }">
						<li>
							<div class="comment-main-level">
								<!-- 新增留言  -->
								<div class="comment-avatar">
									<img id='mprofile' src="<%=request.getContextPath()%>/front-end/members/MprofileDisplayServlet?MEMNO=${membersVO.memno}" alt="sing up image">
								</div>
								<input type="hidden" name="action" value="insert"/>
								<input type="hidden" name="memno" value="${membersVO.memno }"/>
								<input type="hidden" name="courseno" value="${courseVO.courseno }"/>
								<input type="hidden" name="superpostno" value="${postsVO.postno }"/>
								
								<!-- textarea -->
								<div class="comment-box">
									<textarea rows="4" cols="50" class="postcontent1" name="postcontent"></textarea>
									<div align="right">
										<button id = btn>新增回覆</button>
									</div>
								</div>
							</div>
						</li>
					</ul>
				</form>
<%-- 		</c:if> --%>
<%-- 		</c:forEach> --%>
	</c:forEach>
	
	</div>
	
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
	<script src="<%=request.getContextPath()%>/library/jquery/jquery-3.5.1.js"></script>
			<script src="<%=request.getContextPath()%>/library/bootstrap/4.5.3/js/bootstrap.bundle.min.js"></script>
		
<script>
	
// 	function init(){
	
// 	var reportBtn = document.getElementById("reportBtn");
// 	reportBtn.addEventListener('click',function (){
// 		confirm('test');
// 		swal("檢舉成功!", "1", "success");
// 		alert('111');
// 	});
	
	
	function toggleA(name){
		if	(document.getElementById(name).style.display=="none"){
			document.getElementById(name).style.display = "block";
		} else{
			document.getElementById(name).style.display = "none";
		}
	}
	
	
	$("#btn").click(function(){
		console.log("BTN點擊")
		$.ajax({
			url:"<%=request.getContextPath()%>/posts/posts.do",
			type:"POST",
			data:{
				action:"insert",
				memno:"MEM0002",
				courseno:"COUR0001",
				superpostno:"",
				postcontent:$("#postcontent").val()
			},
		
		success:function(data){
// 			$("element").remove();
			var day= new Date();
			 value=JSON.parse(data);

	$("#comments-list").after(
	"<div class='comment-main-level'>"+
	"<ul  class='comments-list'>"+
		"<li>"+
			"<div class='comment-avatar'>"+
				"<img id='mprofile' src='<%=request.getContextPath()%>/front-end/members/MprofileDisplayServlet?MEMNO="+value.memno+"' alt='sing up image'>"+
			"</div>"+
			"<div class='comment-box'>"+
				"<div class='comment-head'>"+	
					"<h6 class='comment-name'>"+					
						"${memVO.memname}&nbsp;&nbsp;|&nbsp;&nbsp;"+day.getFullYear()+"-"+(day.getMonth()+1)+"-"+day.getDate()+" "+day.getHours()+":"+day.getMinutes()+
					"</h6>"+
					"<span></span>"+
					"<div align='right'>"+										
								"<img onclick='toggleA('"+value.postno+"_reply')' src='<%=request.getContextPath()%>/front-end/posts/images/edit.png' style='width:15px;height:15px;'/>"+
								"<a href='<%=request.getContextPath()%>/posts/posts.do?postno="+value.postno+"&action=update_Status_Remove'><img src='<%=request.getContextPath()%>/front-end/posts/images/delete.png' style='width:15px;height:15px'></a>"+							
						"<a href='<%=request.getContextPath()%>/report_detail/report_detail.do?memno="+value.memno+"&postno="+value.postno+"&action=getOne_For_Update_AddReport'><img src='<%=request.getContextPath()%>/front-end/posts/images/flag.png' style='width:15px;height:15px'></a>"+
							"<img onclick='toggleA('"+value.postno+"')' src='<%=request.getContextPath()%>/front-end/posts/images/message.png' style='width:15px;height:15px;'/>"+
						"</div>"+				
					"</div>"+	
				"<div class='comment-content'>"+value.postcontent+"</div>"+
				"<div class='comment-content'>"+
					"<form METHOD='post' id='"+value.postno+"_reply' ACTION='<%=request.getContextPath()%>/posts/posts.do' style='display:none' accept-charset='utf-8'>"+
						"<input type='hidden' name='action' value='update' />"+
						"<textarea name='postcontent' style='width:100%'>"+value.postcontent+"</textarea>"+
						"<input type='hidden' name='postno' value='"+value.postno+"'/>"+
						"<input type='hidden' name='superpostno' value='"+value.superpostno+"'/>"+
						"<input type='hidden' name='memno' value='"+value.memno+"'/>"+
						"<input type='hidden' name='courseno' value='"+value.courseno+"'/>"+
						"<input id = btn type='submit' value='送出'/> "+
					"</form>"+
					"</div>"+
			"</div>"+
		"</li>"+
	"</ul>"+
"</div>"
);
			console.log("成功"+value);
		},
		error:function(data){
			console.log("失敗");
		}
	
		});
	})
	
	
	
// 	};
// 	 btn.click{
// 		 var pst=this.findid
// 		 pst="'"+pst+"'";
// 		 $(pst).append{
// 			 div
// 		 }
// 	 }
//   	window.onload = init;

</script>
</body>
</html>