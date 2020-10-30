<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="com.classroom.model.*"%>
<%@ include file="/back-end/index/homepage.jsp" %>

<%
	ClassroomVO classroomVO = (ClassroomVO) request.getAttribute("classroomVO");
%>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>教室資料 - listOneClassroom.jsp</title>

    <!-- Bootstrap 的 CSS -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto|Varela+Round">
	<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/back-end/classroom/css/classroom.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/library/bootstrap/4.5.3/css/bootstrap.min.css">
	<link rel="stylesheet" href="<%=request.getContextPath()%>/back-end/css/bootTable.css">
	<link rel="stylesheet" href="<%=request.getContextPath()%>/back-end/classroom/css/classroom.css">
    <script src="https://code.jquery.com/jquery-1.12.4.js"></script>

</head>

<body>
<main class="app-content" style="background-color: #f3f3f3">
<div id="table-area" class="container-xl">
	<div class="table-responsive">
		<form method="post"	action="<%=request.getContextPath()%>/back-end/classroom/listAllClassroom.jsp">
				<button class="bttn" type="submit">回首頁</button>
		</form><p>
		<div class="table-wrapper">
        	<div class="row">
           		<div class="col-md-4">
            
	                <h3>教室資料：</h3>
	                	<p>教室編號：${classroomVO.roomno}</p>
	                    <p>教室名稱：${classroomVO.roomname}</p>
	                    <p>教室深度：${classroomVO.roomrow}</p>
	                    <p>教室寬度：${classroomVO.roomcolumn}</p>
	                    <p>座位數：<span id="seatCount"></span> / <span id="blockCount"></span> </p>
	                    <p>狀態：${(!classroomVO.roomdelete) ? '可用' : '註銷'}</p>
	                    <p>最後修改時間：<fmt:formatDate value="${classroomVO.roomlastmod}" pattern="yyyy-MM-dd HH:mm:ss" /></p>
	                    <br>
                    
                	<form>                    
	                    <p>預設座位狀態：(hidden)<input type="text" id="defaultseat" name="defaultseat" value="${classroomVO.defaultseat}" readonly></p>
	                    <input type="hidden" name="roomrow" id="roomrow" class="roomSpace" value="${classroomVO.roomrow}">
	                    <input type="hidden" name="roomcolumn" id="roomcolumn" class="roomSpace" value="${classroomVO.roomcolumn}">
	                </form>

            	</div>

           		<div class="col-md-8">
	                <h3>教室 Layout 預覽圖：</h3>
	                <div id="classroom">
	                    <div id="stage">
	                        Stage
	                    </div>
	                    <br>
	                    <div id="seatmapping">
	                    </div>
	                </div>
	            </div>
       		</div>
    	</div>
	</div>
</div>
</main>
 
	<script src="<%=request.getContextPath()%>/back-end/classroom/javascript/classroom.js"></script>
    <script>
    	let statusStr = $("#defaultseat").val();
    	setDefaultseatValue(statusStr);
        showSeatMapping();
    </script>
</body>

</html>