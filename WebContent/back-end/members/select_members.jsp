<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.members.model.*"%>










<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>Sign Up Form by Colorlib</title>
<style type="text/css">
div.main{
background-color:#FFFFCE;
}
h2.form-title {
	text-align: center;
	margin-bottom: 0px;
}

div.signup-content {
	padding-top: 0px;
}

div.signup-form {
	margin-left: 0px;
}

input#name {
	padding: 0px 0px 0px 30px;
	width: 260px;
}
td{
width:10px;
}
</style>
<!-- Font Icon -->
<link rel="stylesheet"
	href="fonts/material-icon/css/material-design-iconic-font.min.css">

<!-- Main css -->
<link rel="stylesheet" href="<%=request.getContextPath()%>/back-end/members/css/style.css">
</head>
<body>

	<div class="main">

		<!-- Sign up form -->
		<section class="signup">
			<div class="container">
				<h2 class="form-title">Members managerment</h2>
				<div class="signup-content">

					<div class="signup-form">
						<table>
							<tr>
								<th><h2>會員資料查詢:</h2></th>
							</tr>
							<tr>
								<td><a class="form-submit" href="<%=request.getContextPath()%>/back-end/members/listAllMembers.jsp">查詢平台所有會員</a></td>
							</tr>
							<tr>
								<td><hr></td>
							</tr>
							<tr>
							
								<td>
									<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/members/members.do">



										<div class="form-group">
											<label for="name"><i
												class="zmdi zmdi-account material-icons-name"></i></label> <input
												type="text" name="memno" id="name"
												placeholder="輸入欲查詢的會員編號(ex:MEM0001)" />
										</div>
								</td>
								<td class="td1"><input type="hidden" name="action"
									value="getOne_For_Display"> <input type="submit"
									class="form-submit" value="送出">
									</form></td>

							</tr>

							<jsp:useBean id="membersSvc" scope="page"
								class="com.members.model.MembersService" />


							<tr>
								<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/members/members.do">
									<td>
									<b>選擇會員編號:</b>
									<select size="1" name="memno">
											<c:forEach var="membersVO" items="${membersSvc.all}">
												<option value="${membersVO.memno}">
												${membersVO.memno} ${membersVO.memname}
													</c:forEach> 
									</select>
									
									
										</td>
									<td class="td1">
									<input type="hidden" name="action"
										value="getOne_For_Display"> <input type="submit"
										class="form-submit" value="送出"></td>
								</form>
								
							</tr>
							<tr>
								<td><hr></td>
							</tr>

						</table>
						 <c:if test="${not empty errorMsgs}">
    <font style="color:red">請修正以下錯誤:</font>
    <ul>
        <c:forEach var="message" items="${errorMsgs}">
            <li style="color:red">${message}</li>
        </c:forEach>
    </ul>
</c:if>
				</div>
				<%-- <img style='width:350px;height:300px;margin-right:70px;margin-top:50px;' alt="" src="<%=request.getContextPath()%>/back-end/members/css/select_members.jpeg">
				 --%>
				 <iframe style='width:430px;height:300px;margin-right:50px;margin-top:50px;' src="https://www.youtube.com/embed/KlhbQy6LT_Y" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen autoplay controls muted loop></iframe>
				
			</div>
			
	</div>
	
	</section>
	
	</div>
	



	<!-- JS -->
						<script src="vendor/jquery/jquery.min.js"></script>
						<script src="js/main.js"></script>
</body>
<!-- This templates was made by Colorlib (https://colorlib.com) -->
</html>