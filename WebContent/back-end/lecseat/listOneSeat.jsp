<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*" %>
<%@ page import="com.lecture.model.*" %>
<%@ page import="com.lecorder.model.*" %>
<%@ page import="com.lecseat.model.*" %>
<%@ include file="/back-end/index/homepage.jsp" %>

<%
	//lecseat
	String lodrno = request.getParameter("lodrno").trim();
	LecseatService seatSvc = new LecseatService();
	List<LecseatVO> list = seatSvc.getSeatsByOrder(lodrno);
	//lecorder
	LodrService lodrSvc = new LodrService();
	LodrVO lodrVO = lodrSvc.getOne(lodrno);
	String lecno = lodrVO.getLecno();
	String lodrseat = lodrVO.getLodrseat();
	//lecture
	LecService lecSvc = new LecService();
	LecVO lecVO = lecSvc.getOne(lecno);
	
	pageContext.setAttribute("list", list);
	pageContext.setAttribute("lodrVO", lodrVO);
	pageContext.setAttribute("lecVO", lecVO);
%>

<!DOCTYPE html>
<%
%>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>Xducation - 陪你成長的學習好夥伴</title>
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto|Varela+Round">
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
<link rel="stylesheet" href="<%=request.getContextPath()%>/library/bootstrap/4.5.3/css/bootstrap.min.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/back-end/css/bootTable.css">
<style>
body {
    color: #566787;
    background: #f5f5f5;
    font-family: 'Roboto', sans-serif;
}
</style>
<script>
</script>
</head>
<body>
<main class="app-content" style="background-color: #f3f3f3">
<div class="container-xl">
    <div class="table-responsive">
        <div class="table-wrapper">			
            <div class="table-title">
                <div class="row">
                    <div class="col-sm-2">
						<form method="post"	action="<%=request.getContextPath()%>/back-end/lecorder/listAllLodr.jsp">
						<button class="bttn" type="submit">回列表</button>
						</form>
					</div>
                    <div class="col-sm-8">
                        <h2 class="text-center">報名座位查詢</h2>
                    </div>
                </div>
            </div>
            <table class="table table-bordered">
                <thead>
                    <tr>
                        <th>訂單編號</th>
                        <th>講座名稱</th>
                        <th>講座票價</th>
                        <th>座位號碼</th>
                        <th>訂單狀態</th>
                    </tr>
                </thead>
                <tbody>
                <%@ include file="/back-end/pool/page1.file" %>
                <c:forEach var="seatVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
					<tr>
						<td>${seatVO.lodrno}</td>
						<td>${lecVO.lecname}</td>
						<td>${lecVO.lecprice}</td>
						<td>${seatVO.seatno}</td>
						<td>${seatVO.seatstatus}</td>
	            	</tr>
				</c:forEach>
                </tbody>
            </table>
            <div class="row">
            	<div class="col-sm-4"></div>
            	<div class="col-sm-8">
		            <div style="margin-left: 14%"><b>本訂單共預定<font color=#19B3D3><%=rowNumber%></font>個座位</b></div>
		            <%@ include file="/front-end/lecseat/bookedSeats.jsp" %>
            	</div>
            </div>
        </div>
    </div>
</div> 
</main>
</body>
</html>                                		