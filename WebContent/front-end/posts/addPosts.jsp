<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.posts.model.*"%>

<%
//   PostsVO postsVO = (PostsVO) request.getAttribute("postsVO");
	

	PostsVO postsVO2 = new PostsVO();//假資料
	postsVO2.setMemno("MEM0005");//假資料
	postsVO2.setSuperpostno("POST0001");//假資料
	postsVO2.setCourseno("COUR0001");//假資料
%>

<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<title>貼文新增 - addPosts.jsp</title>

<script src="<%=request.getContextPath()%>/ckeditor/ckeditor.js"></script>
<!-- bootstrap -->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
<script src="${pageContext.request.contextPath}/js/jquery_3.5.1.min.js"></script>

<!-- 驗證code -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script> 
<script src="https://cdn.jsdelivr.net/npm/jquery-validation@1.19.2/dist/jquery.validate.js"></script> 


<!-- 自訂CSS -->
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/messageboard/replyMessage.css">



<style>
  table#table-1 {
	background-color: #CCCCFF;
    border: 2px solid black;
    text-align: center;
  }
  table#table-1 h4 {
    color: red;
    display: block;
    margin-bottom: 1px;
  }
  h4 {
    color: blue;
    display: inline;
  }
</style>

<style>
  table {
	width: auto;
	margin-top: 1px;
	margin-bottom: 1px;
  }
  table, th, td {
    border: 0px solid #CCCCFF;
  }
  th, td {
    padding: 1px;
  }
  textarea{
  resize:none;
  }
</style>

</head>
<body bgcolor='white'>

<table id="table-1">
	<tr><td>
		 <h3>貼文新增 - addPosts.jsp</h3></td><td>
		 <h4><a href="select_page.jsp"><img src="images/tomcat.png" width="100" height="100" border="0">回首頁</a></h4>
	</td></tr>
</table>

<h3>資料新增:</h3>



<%-- <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/posts/posts.do" name="form1"> --%>
<!-- <table> -->

	

<!-- 	<tr> -->
<!-- 		<td>課程編號:</td> -->
<%-- 		<td><%=postsVO2.getCourseno()%></td> --%>
<!-- 	</tr> -->
	
<!-- 	<tr> -->
<!-- 		<td>會員編號:</td> -->
<%-- 		<td><%=postsVO2.getMemno()%></td> --%>
<!-- 	</tr> -->
	
<!-- 	<tr> -->
<!-- 		<td>內容:</td> -->
	
<!-- 	</tr> -->
	
<!-- 		<tr> -->
	<!-- 	<td><textarea cols="45" rows="5" name="postcontent" placeholder ="請輸入文字"></textarea></td> -->
	<!-- 		</tr>	  -->
		
		


<!-- </table> -->

<!-- <br> -->
<!-- <input type="hidden" name="action" value="insert"> -->
<%-- <input type="hidden" name="courseno" value="<%=postsVO2.getCourseno()%>"/> --%>
<%-- <input type="hidden" name="memno" value="<%=postsVO2.getMemno()%>"/> --%>
<!-- <input type="submit" value="送出新增"></FORM> -->

<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/posts/posts.do" name="form1"  accept-charset="utf-8">
<!-- <form  name="replyform" id="reply_form" -->
<!-- 		action="messageboard.do" method="post" accept-charset="utf-8" > -->

<table>

	

	<tr>
		<td>課程編號:</td>
		<td><%=postsVO2.getCourseno()%></td>
	</tr>
	
	<tr>
		<td>會員編號:</td>
		<td><%=postsVO2.getMemno()%></td>
	</tr>
	
	<tr>
		<td>內容:</td>
		<td><div class ="container" id="main">
			<section id ="row" >
				<div class="wrapper">
					<div class="post_page_form rounded">										
						<div class="form-row">
						  	<div class="col formlist text-center">
						   		<p>請於下方輸入留言內容:</p>
						   		<%-- 錯誤表列 --%>
									<div class="errormsgs" style="padding-left:2%;text-align:center">
										<c:if test="${not empty errorMsgs}">
										
										
											<c:forEach var="message" items="${errorMsgs}">
												<p style="color: red ;font-weight:bold; background-color:white; width:40%">${message}</p>
											</c:forEach>
										
										</c:if>
									</div>
						   		<div id="invalid-feedback" style="color:red;">
							   		<div class="postdetail">
							      		<textarea name="postcontent" id="postdetail" type="text" required></textarea>								     							       	
									</div>
							    </div>
						    </div>   
						 </div>	
						
						
						<div class="text-center" >
<%-- 							<input type="hidden" name="parentno" value="${mbVO.postno}">						 --%>
<!-- 							於頁尾被inlude:故mbVO.postno一定是主留言 -->
<%-- 							<input type="hidden" name="memno" value="${sessionScope.memVO.memno}"> --%>
<!-- 							<input type="hidden" name="action" value="replyMessage"> -->
<!-- 							<input class="btn btn-info" id="submit" type="submit" value="送出"> -->
								<input type="hidden" name="action" value="insert">
								<input type="hidden" name="courseno" value="<%=postsVO2.getCourseno()%>"/>
								<input type="hidden" name="memno" value="<%=postsVO2.getMemno()%>"/>
								<input type="submit" value="送出新增">							
						</div>
					</div>	
				</div>
			</section>
		</div>			
	
	</td>
	</tr>
	
<!-- 		<tr> -->
<!-- 	<td><textarea cols="45" rows="5" name="postcontent" placeholder ="請輸入文字"></textarea></td> -->
<!-- 		</tr>	  -->



</table>
	</form>	
	<script>
		$('#submit').click(function(){
			var btn = this;
			setTimeout(function(){
				btn.disabled = true;
			},50);
		});
</script>

<script type="text/javascript"> CKEDITOR.replace( 'postdetail' );</script>
</body>




</html>