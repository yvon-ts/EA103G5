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
	width: 300px;
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
				<h2 class="form-title">Teacher managerment</h2>
				<div class="signup-content">

					<div class="signup-form">
						<table>
							<tr>
								<th><h2>老師資料查詢:</h2></th>
							</tr>
							<tr>
								<td><a class="form-submit" href="<%=request.getContextPath()%>/back-end/teacher/listAllPendingTeachers.jsp">待審核老師名單</a></td>
							</tr>
							<tr>
								<td><hr></td>
							</tr>
							<tr>
							
								<td>
									<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/teacher/teacher.do">



										<div class="form-group">
											<label for="name"><i
												class="zmdi zmdi-account material-icons-name"></i></label> <input
												type="text" name="tchrno" id="name"
												placeholder="輸入欲查詢的老師編號(ex:TCH0001)" />
										</div>
								</td>
								<td>
								<input type="hidden" name="action" value="getOne_For_Display"> 
								<input type="submit" class="form-submit" value="送出">
									
									</td></form>

							</tr>

							<jsp:useBean id="teacherSvc" scope="page"
								class="com.teacher.model.TeacherService" />
								<jsp:useBean id="membersSvc" scope="page"
								class="com.members.model.MembersService" />


							<tr>
								<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/teacher/teacher.do">
									<td>
									<b>選擇老師編號:</b>
									<select size="1" name="tchrno">
											<c:forEach var="teacherVO" items="${teacherSvc.all}">
												<option value="${teacherVO.tchrno}">
												
												${teacherVO.tchrno}
												<c:forEach var="membersVO" items="${membersSvc.all}">
                    <c:if test="${teacherVO.memno==membersVO.memno}">
	                    ${membersVO.memname}
                    </c:if>
                </c:forEach>
												
													</c:forEach> 
									</select>
									
										</div>
										</td>
									<td>
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