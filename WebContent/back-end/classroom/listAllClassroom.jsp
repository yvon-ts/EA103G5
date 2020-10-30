<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="com.classroom.model.*"%>
<%@ include file="/back-end/index/homepage.jsp" %>

<%
	ClassroomService classroomSvc = new ClassroomService();
	List<ClassroomVO> list = classroomSvc.getAll();
	pageContext.setAttribute("list", list);
%>

<!DOCTYPE html>

<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>所有教室列表 - listAllClassroom.jsp</title>
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto|Varela+Round">
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
<link rel="stylesheet" href="<%=request.getContextPath()%>/library/bootstrap/4.5.3/css/bootstrap.min.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/back-end/css/bootTable.css">
<style>
table, th, td {
	border: 1px solid black;
}
</style>
</head>

<body>
<main class="app-content" style="background-color: #f3f3f3">
	<%-- 錯誤表列 --%>
	<c:if test="${not empty errorMsgs}">
		<font style="color: red">請修正以下錯誤:</font>
		<ul>
			<c:forEach var="message" items="${errorMsgs}">
				<li style="color: red">${message}</li>
			</c:forEach>
		</ul>
	</c:if>

<div id="table-area" class="container-xl">
    <div class="table-responsive">
        <div class="table-wrapper">			
            <div class="table-title">
                <div class="row">
                    <div class="col-sm-2">
						<form method="post"	action="<%=request.getContextPath()%>/back-end/classroom/addClassroom.jsp">
						<button class="bttn" type="submit">新增教室</button>
						</form>
					</div>
                    <div class="col-sm-7">
                        <h2 class="text-center">所有教室列表 </h2>
                    </div>
                    <!-- search box start -->
                    <div class="col-sm-3">
                        <div class="search-box">
                            <div class="input-group">
                                <span class="input-group-addon"><i class="material-icons">&#xE8B6;</i></span>
                                <input id="query" name="query" type="text" class="form-control" placeholder="Search&hellip;">
                            </div>
                        </div>
                    </div>
                    <!-- search box end -->
                </div>
            </div>
	        <table id="table" class="table table-bordered">
	            <thead>
					<tr>
						<th>教室編號</th>
						<th>教室名稱</th>
						<th>教室深度</th>
						<th>教室寬度</th>
						<th>教室空間數</th>
			<!-- 			<th>預設座位狀態</th> -->
						<th>教室是否註銷</th>
						<th>最後修改時間</th>
						<th>檢視</th>
						<th>修改</th>
						<th>註銷</th>
					</tr>
				<tbody>
				<c:forEach var="classroomVO" items="${list}">
					<tr>
						<td>${classroomVO.roomno}</td>
						<td>${classroomVO.roomname}</td>
						<td>${classroomVO.roomrow}</td>
						<td>${classroomVO.roomcolumn}</td>
						<td>${classroomVO.roomrow * classroomVO.roomcolumn}</td>
		<%-- 				<td>${classroomVO.defaultseat}</td> --%>
						<td>${classroomVO.roomdelete}</td>
						<td><fmt:formatDate value="${classroomVO.roomlastmod}"
								pattern="yyyy-MM-dd HH:mm:ss" /></td>
						<td>
							<FORM METHOD="post" ACTION="#" style="margin-bottom: 0px;">
					     	<button class="btn view" style="color: #03A9F4"><i class="material-icons">&#xE417;</i></button>
					     	<input type="hidden" name="roomno"  value="${classroomVO.roomno}">
					     	<input type="hidden" name="action"	value="getOne_For_Update"></FORM>
						</td>
						<td>
							<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/classroom/classroom.do" style="margin-bottom: 0px;">
					     	<button class="btn edit" style="color: orange"><i class="material-icons">&#xE254;</i></button>
					     	<input type="hidden" name="roomno"  value="${classroomVO.roomno}">
					     	<input type="hidden" name="action"	value="getOne_For_Update"></FORM>
						</td>
						<td>
							<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/classroom/classroom.do" style="margin-bottom: 0px;">
					     	<button class="btn delete" style="color: red"><i class="material-icons">&#xE872;</i></button>
					     	<input type="hidden" name="roomno"  value="${classroomVO.roomno}">
					     	<input type="hidden" name="action"	value="delete"></FORM>
						</td>
					</tr>
				</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
</div>
</main>
</body>

</html>