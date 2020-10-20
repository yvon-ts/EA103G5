<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="com.classroom.model.*"%>

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
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/back-end/classroom/css/classroom.css">
    <script src="https://code.jquery.com/jquery-1.12.4.js"></script>

</head>

<body>
    <div class="container">
        <div class="row">
			<h1>教室資料 - listOneClassroom.jsp</h1>
		</div>
		<div class="row">
			<p><a href="<%=request.getContextPath()%>/back-end/classroom/select_page.jsp">回首頁</a></p>
		</div>

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
                    
                <from>                    
                    <p>預設座位狀態：(hidden)<input type="text" id="defaultseat" name="defaultseat" value="${classroomVO.defaultseat}" readonly></p>
                    <input type="hidden" name="roomrow" id="roomrow" class="roomSpace" value="${classroomVO.roomrow}">
                    <input type="hidden" name="roomcolumn" id="roomcolumn" class="roomSpace" value="${classroomVO.roomcolumn}">
                </from>

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

 
	<script src="<%=request.getContextPath()%>/back-end/classroom/javascript/classroom.js"></script>
    <script>
    	let statusStr = $("#defaultseat").val();
    	setDefaultseatValue(statusStr);
        showSeatMapping();
    </script>
</body>

</html>