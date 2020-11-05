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
		info = new String(b, "UTF-8");
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
		background-color: #fff;
		border-radius: 5px;
	}
	#displayInfo img{
		height: 100px;
		width: 100px;
		border: 2px solid #999;
	}
	}
</style>

</head>
<body>
<main class="app-content" style="background-color: #f3f3f3">
<div id="table-area" class="container-xl">
    <div class="table-responsive">
        <div class="table-wrapper">			
            <div class="table-title">
                <div class="row">
                    <div class="col-sm-2">
						<form method="post"	action="<%=request.getContextPath()%>/back-end/speaker/listAllSpkr.jsp">
						<button class="bttn" type="submit">回列表</button>
						</form>
					</div>
                    <div class="col-sm-7">
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
							<button class="btn edit" style="color: orange"><i class="material-icons">&#xE254;</i></button>
							<input type="hidden" name="spkrno" value="${spkrVO.spkrno}">
							<input type="hidden" name="action" value="update_fromList"></form>
						</td>
						<td>
							<form method="post"	action="<%=request.getContextPath()%>/speaker/speaker.do">
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
	         <img class="d-flex mr-3 rounded-circle" src="<%=request.getContextPath()%>/speaker/iconreader?spkrno=${spkrVO.spkrno}" alt="">
	         	<div class="media-body">
	           		<h5 class="mt-0" style="font-weight: 600">${spkrVO.spkrname}</h5>
	           		<%=info %>
	         	</div>
	     </div>
	</div>
</div>
</main>
</body>
</html>
