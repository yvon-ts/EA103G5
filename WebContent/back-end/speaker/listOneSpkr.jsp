<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.speaker.model.*"%>

<%@ include file="/back-end/index/homepage.jsp" %>

<!DOCTYPE html>

<%
	SpkrVO spkrVO = (SpkrVO) request.getAttribute("spkrVO");
	String info = "資訊更新中";
	try{
		//CKeditor - Bytes to String
		byte[] b = spkrVO.getSpkrinfo();
		info = new String(b);
	} catch (Exception e){
		info = "資訊更新中";
	}

%>

<html>
<head>
<title>Xducation - 陪你成長的學習好夥伴</title>
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto|Varela+Round">
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
<link rel="stylesheet" href="<%=request.getContextPath()%>/library/bootstrap/4.5.3/css/bootstrap.min.css">
<link href="css/blog-post.css" rel="stylesheet">
<link rel="stylesheet" href="<%=request.getContextPath()%>/back-end/css/bootTable.css">
<style>
	#displayInfo{
		width: 100%;
		padding: 30px;
		background-color: #F3F3F3;
		border-radius: 5px;
	}
	#displayInfo img{
		max-height: 200px;
		width: auto;
	}
/* 	#btn1{ */
/* 		margin-left: 400px; */
/* 		margin-top: 150px; */
/* 		display: inline-block; */
/* 	} */
/* 	#btn2{ */
/* 		margin-top: 150px; */
/* 		display: inline-block; */
/* 	} */
</style>

</head>
<body>
<main class="app-content">
<div id="table-area" class="container-xl">
    <div class="table-responsive">
        <div class="table-wrapper">			
            <div class="table-title">
                <div class="row">
                    <div class="col-sm-3">
                    <div id="btn1">
<form method="post"	action="<%=request.getContextPath()%>/back-end/speaker/listAllSpkr.jsp">
		<input type="submit" value="回列表">
	</form></div>
	<div id="btn2">
	<form method="post"	action="<%=request.getContextPath()%>/back-end/speaker/select_page.jsp">
	<input type="submit" value="回首頁"></form></div>
	<br>
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
                        <th>修改</th>
                        <th>刪除</th>
                    </tr>
                </thead>
	<tr>
		<td>${spkrVO.spkrno}</td>
		<td>${spkrVO.spkrname}</td>
		<td>${spkrVO.spkrphone}</td>
		<td>${spkrVO.spkremail}</td>
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
</table>
</div>
</div>

<div id="displayInfo">
<div class="media mt-4">
              <img class="d-flex mr-3 rounded-circle" src="http://placehold.it/50x50" alt="">
              <div class="media-body">
                <h5 class="mt-0">${spkrVO.spkrname}</h5>
                <%=info %>
              </div>
            </div>
            </div>
            </div>

<br>
<img src="<%=request.getContextPath()%>/speaker/iconreader?spkrno=${spkrVO.spkrno}"><br><%=info %></div>
</div>	
</main>
</body>
</html>
