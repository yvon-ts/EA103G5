<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="com.teacher.model.*"%>

<%@ include file="/back-end/index/homepage.jsp"%>

<!DOCTYPE html>

<%
	TeacherService teacherSvc = new TeacherService();
List<TeacherVO> list = teacherSvc.getAll();
pageContext.setAttribute("list", list);
%>
<jsp:useBean id="membersSvc" scope="page"
	class="com.members.model.MembersService" />

<html>
<head>
<title>Xducation - 陪你成長的學習好夥伴</title>
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Roboto|Varela+Round">
<link rel="stylesheet"
	href="https://fonts.googleapis.com/icon?family=Material+Icons">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/library/bootstrap/4.5.3/css/bootstrap.min.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/back-end/css/bootTable.css">
<style>
#pic {
	width: 80px;
	height: 80px;
}

table {
	text-align: center;
}

table.td.number {
	padding: 20px;
	height: 30px;
}

.bttn {
	display: inline-block;
	background-color: #fff;
	outline: none;
	border: 1px solid #0099cc;
	color: #0099cc;
	font-size: 16px;
	padding: 5px 30px;
	cursor: pointer;
	font-weight: 550;
	border-radius: 30px;
	-webkit-transition: all 0.2s linear;
	-moz-transition: all 0.2s linear;
	-o-transition: all 0.2s linear;
	transition: all 0.2s linear;
	display: inline-block;
}

.bttn:hover {
	background-color: #0099cc;
	outline: none;
	border: 1px solid #0099cc;
	color: #fff;
}

button#bt1 {
	position: absolute;
	z-index: 3;
	margin: 0 0 0 0;
}

button#bt2 {
	position: absolute;
	z-index: 3;
	margin: 0 0 0 130px;
}

button#bt3 {
	position: absolute;
	z-index: 3;
	margin: 0 0 0 260px;
}
</style>
</head>

<body>
	<main class="app-content" style="background-color: #f3f3f3">
		<div id="include">
			<%
				if (list == null || list.size() == 0) {
			%>
			<b style="color: red">查無資料</b>
			<%}%>
			<div id="table-area" class="container-xl">
				<div class="table-responsive">
					<div class="table-wrapper">
						<div class="table-title">
							<div class="row">
								<div class="col-sm-2">
									<form method="post"
										action="<%=request.getContextPath()%>/teacher/teacher.do">
										<button id="bt1" class="bttn" name="TCHRSTATUS" value="待審核"
											type="submit">待審核</button>
										<button id="bt2" class="bttn" name="TCHRSTATUS" value="已通過"
											type="submit">已通過</button>
										<button id="bt3" class="bttn" name="TCHRSTATUS" value="未通過"
											type="submit">未通過</button>
										<input type="hidden" name="action"
											value="listTeacher_ByCompositeQuery">
									</form>
								</div>
								<div class="col-sm-7">
									<h2 class="text-center">不分類老師名單</h2>
								</div>
								<!-- search box start -->
								<div class="col-sm-3">
									<div class="search-box">
										<div class="input-group">
											<span class="input-group-addon"><i
												class="material-icons">&#xE8B6;</i></span> <input type="text"
												class="form-control" placeholder="Search&hellip;">
										</div>
									</div>
								</div>
								<!-- search box end -->
							</div>
						</div>
						<table class="table table-bordered">
							<thead>
								<tr>
									<th>老師頭像</th>
									<th>老師編號</th>
									<th>會員編號</th>
									<th>老師姓名</th>
									<th>審核狀態</th>
									<th>檢視</th>
								</tr>
							</thead>
							<tbody>

								<%@ include file="/back-end/teacher/page1.file"%>
								<c:forEach var="teacherVO" items="${list}"
									begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>"
									varStatus="s">
									<tr>
										<td class="number"><img id="pic"
											src="<%=request.getContextPath()%>/back-end/members/MprofileDisplayServlet?MEMNO=${teacherVO.memno}"
											alt="No Image Uploaded"></td>
										<td class="number">${teacherVO.tchrno}</td>
										<td class="number">${teacherVO.memno}</td>
										<td class="number"><c:forEach var="membersVO"
												items="${membersSvc.all}">
												<c:if test="${teacherVO.memno==membersVO.memno}">
                                              ${membersVO.memname}
                                                </c:if>
											</c:forEach></td>
											
											
										
										
										<c:if test="${teacherVO.tchrstatus eq '待審核'}">
										<td class="number" style="color:#E1E100">
											${teacherVO.tchrstatus}
										</td>
										</c:if>
										<c:if test="${teacherVO.tchrstatus eq '已通過'}">
										<td class="number" style="color:#00BB00">
											${teacherVO.tchrstatus}
										</td>
										</c:if>
										<c:if test="${teacherVO.tchrstatus eq '未通過'}">
										<td class="number" style="color:#EA0000">
											${teacherVO.tchrstatus}
										</td>
										</c:if>
										
									




										<td class="number">
											<FORM METHOD="post"
												ACTION="<%=request.getContextPath()%>/teacher/teacher.do">

												<!-- 			<input type="submit" value="資訊"> -->
												<button type="submit" class="btn view"
													style="color: #03A9F4">
													<i class="material-icons">&#xE417;</i>
												</button>
												<input type="hidden" name="tchrno"
													value="${teacherVO.tchrno}"> <input type="hidden"
													name="action" value="getOne_For_Display">
											</form>
										</td>
										<%-- <td class="number">
				<form method="post"	action="<%=request.getContextPath()%>/speaker/speaker.do">
<!-- 				<input type="submit" value="修改"> -->
				<button class="btn edit" style="color: orange"><i class="material-icons">&#xE254;</i></button>
				<input type="hidden" name="spkrno" value="${spkrVO.spkrno}">
				<input type="hidden" name="action" value="update_fromList"></form>
			</td> --%>

									</tr>
								</c:forEach>
							</tbody>
						</table>
						<%@ include file="/back-end/teacher/page2.file"%>
						<form method="post"
							action="<%=request.getContextPath()%>/back-end/teacher/listAllTeachers.jsp">
							<input type="submit" value="回首頁">
						</form>
					</div>
				</div>
			</div>
		</div>
	</main>
</body>
</html>

