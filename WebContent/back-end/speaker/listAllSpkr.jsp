<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.speaker.model.*"%>

<%@ include file="/back-end/index/homepage.jsp" %>

<!DOCTYPE html>

<%
	SpkrService spkrSvc = new SpkrService(); 
	List<SpkrVO> list = spkrSvc.getList();
	pageContext.setAttribute("list", list);
	
%>

<html>
<head>
<title>Xducation - 陪你成長的學習好夥伴</title>
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto|Varela+Round">
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
<link rel="stylesheet" href="<%=request.getContextPath()%>/library/bootstrap/4.5.3/css/bootstrap.min.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/back-end/css/bootTable.css">
<style>
/* 	h1{ */
/* 		margin-top: 150px; */
/* 		margin-left: 400px; */
/* 	} */
/* 	#include{ */
/* 		margin-left: 400px; */
/* 		padding: 30px; */
/* 		background-color: #F3F3F3; */
/* 		border-radius: 1%; */
/* 	} */
</style>
</head>

<body>
<main class="app-content">
<div id="include">
<%if (list == null || list.size() == 0){%>
	<b style="color: red">查無資料</b>		
<%}%>
<div id="table-area" class="container-xl">
    <div class="table-responsive">
        <div class="table-wrapper">			
            <div class="table-title">
                <div class="row">
                    <div class="col-sm-3">
                    </div>
                    <div class="col-sm-4">
                        <h2 class="text-center">講師清單</h2>
                    </div>
                </div>
            </div>
            <table class="table table-bordered">
                <thead>
                    <tr>
                        <th>講師編號</th>
                        <th>講師姓名</th>
                        <th>講師電話</th>
                        <th>講師信箱</th>
                        <th>檢視</th>
                        <th>修改</th>
                        <th>刪除</th>
                    </tr>
                </thead>
                <tbody>

	<%@ include file="/back-end/pool/page1.file" %>
	<c:forEach var="spkrVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
		<tr>
			<td>${spkrVO.spkrno}</td>
			<td>${spkrVO.spkrname}</td>
			<td>${spkrVO.spkrphone}</td>
			<td>${spkrVO.spkremail}</td>
			<td>
			<form method="post" action="<%=request.getContextPath()%>/speaker/speaker.do">
			
<!-- 			<input type="submit" value="資訊"> -->
			<button type="submit" class="btn view"><i class="material-icons">&#xE417;</i></button>
			<input type="hidden" name="spkrno" value="${spkrVO.spkrno}">
			<input type="hidden" name="action" value="display_fromList"></form>
			</td>
			<td>
				<form method="post"	action="<%=request.getContextPath()%>/speaker/speaker.do">
<!-- 				<input type="submit" value="修改"> -->
				<button class="btn edit" style="color: orange"><i class="material-icons">&#xE254;</i></button>
				<input type="hidden" name="spkrno" value="${spkrVO.spkrno}">
				<input type="hidden" name="action" value="update_fromList"></form>
			</td>
			<td>
				<form method="post"	action="<%=request.getContextPath()%>/speaker/speaker.do">
<!-- 				<input type="submit" value="刪除"> -->
				<button class="btn delete" style="color: red"><i class="material-icons">&#xE872;</i></button>
				<input type="hidden" name="spkrno" value="${spkrVO.spkrno}">
				<input type="hidden" name="action" value="delete"></form>
			</td>
		</tr>
	</c:forEach>
		</tbody>
	</table>
	<%@ include file="/back-end/pool/page2.file" %>
	<form method="post"	action="<%=request.getContextPath()%>/back-end/speaker/select_page.jsp">
	<input type="submit" value="回首頁"></form>
	</div>
	</div>
	</div>
	</div>
	</main>
</body>
</html>

