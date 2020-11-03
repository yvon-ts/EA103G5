<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="com.anwser_list.model.*,java.util.*,com.posts.model.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

	
<%
PostsService PostsSVC = new PostsService();
	List<PostsVO>  fatherList = PostsSVC.getAll("father");

	pageContext.setAttribute("fatherList", fatherList);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="BIG5">
<title>Insert title here</title>
<style>
	.statement{
		display: block;
    	background: white;
    	border: 1px solid rgba(0, 0, 0, 0.12);
    	margin: 10px 0px ;
	}
	.statementTitle{
		padding-left: 8px;
    	border-left: 2px solid #14bdcc;
    	font-weight: 700;
    	margin-bottom: 4px;
    	line-height: 20px;
    	font-size: 20px;
	}
	.statementContent{
		padding-left: 10px;
    	font-size: 20px;
    	color: rgba(0,0,0,.6);
	}
	img.pic{
	box-shadow: 3px 3px 5px 5px #BEBEBE;
	width:100px;
	height:100px;

    margin-top: 30px;
   	position: sticky;

}
</style>
</head>

<body>

<%-- <jsp:useBean id="PostsSvc" scope="page" class="com.posts.model.PostsService" /> --%>


<jsp:include page="/index/front-index/header.jsp" />


	<div class="container-fluid" style="margin-top: 90px; width:50%;">
		<div class="statement">
				<div class="container">
				<c:if test="${not empty loginMembersVO}">
					<div class="row ">		
						<div class="col-2">
							<a target="_blank" href="<%=request.getContextPath()%>/members/members.do?action=getOne_For_Display&courseno=${courseVO.courseno}&memno=${loginMembersVO.memno}"><img class="pic" src='<%=request.getContextPath()%>/front-end/members/MprofileDisplayServlet?MEMNO=${loginMembersVO.memno}' alt='sing up image'></a>
							<div style="margin-top:13px;margin-left:40px;">${loginMembersVO.memname}</div>
						</div>
						<div class="col-9" style = "margin:28px 0;">
						
							<textarea style="resize:none;width:600px;height:100px;" placeholder="留言"></textarea>
							<div style="text-align:right"><button class="btn btn-common">留言</button></div>
						</div>
					</div>
				</c:if>
		</div>
		</div>	
		<c:set var='data1' value='father'/>
		<c:set var='data2' value='children'/>
		<div class="statement">
				<div class="container">
					
						<c:forEach var="PostsVO" items="${fatherList}">
						
							
						</c:forEach>
				</div>
		</div>	
		</div>
			
<!-- 					<div class="row ">		 -->
<!-- 						<div class="col-2"> -->
<%-- 							<a target="_blank" href="<%=request.getContextPath()%>/members/members.do?action=getOne_For_Display&courseno=${courseVO.courseno}&memno=${loginMembersVO.memno}"><img class="pic" src='<%=request.getContextPath()%>/front-end/members/MprofileDisplayServlet?MEMNO=${loginMembersVO.memno}' alt='sing up image'></a> --%>
<%-- 							<div style="margin-top:13px;margin-left:40px;">${loginMembersVO.memname}</div> --%>
<!-- 						</div> -->
<!-- 						<div class="col-9" style = "margin:28px 0;"> -->
						
<!-- 							<textarea style="resize:none;width:600px;height:100px;" placeholder="留言"></textarea> -->
<!-- 							<div style="text-align:right"><button class="btn btn-common">留言</button></div> -->
<!-- 						</div> -->
<!-- 					</div> -->
				
	</div>
		
</body>
</html>