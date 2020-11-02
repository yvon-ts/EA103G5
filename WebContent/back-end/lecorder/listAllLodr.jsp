<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.lecorder.model.*" %>
<%@ page import="java.util.*" %>
<%@ include file="/back-end/index/homepage.jsp" %>

<%
	LodrService lodrSvc = new LodrService();
	List<LodrVO> list = lodrSvc.getList();
	pageContext.setAttribute("list", list);
%>
<!DOCTYPE html>
<jsp:useBean id="memSvc" scope="page" class="com.members.model.MembersService" />
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
</head>
<body>
<main class="app-content" style="background-color: #f3f3f3">
<%@ include file="/back-end/pool/page1.file" %>
<div class="container-xl">
    <div class="table-responsive">
        <div class="table-wrapper">			
            <div class="table-title">
                <div class="row">
                    <div class="col-sm-3">
                    <div><b style="font-size: 1.2em;">查詢結果共有<font color=#19B3D3><%=rowNumber%></font>筆資料</b></div>
                    </div>
                    <div class="col-sm-5">
                        <h2 class="text-center">講座報名清單</h2>
                    </div>
                    <div class="col-sm-4">
                        <div class="search-box">
                            <div class="input-group">
                                <span class="input-group-addon"><i class="material-icons">&#xE8B6;</i></span>
                                <input type="text" class="form-control" placeholder="Search&hellip;">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <table class="table table-bordered">
                <thead>
                    <tr>
                        <th>訂單編號</th>
                        <th>會員姓名</th>
                        <th>訂單金額</th>
                        <th>訂單狀態</th>
                        <th>成立時間</th>
                        <th>更新時間</th>
                        <th>檢視</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="lodrVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
						<tr><td>${lodrVO.lodrno}</td>
						<c:forEach var="memVO" items="${memSvc.all}">
							<c:if test="${lodrVO.memno == memVO.memno}">
								<td>${memVO.memname}</td>
							</c:if>
						</c:forEach>
						<td>${lodrVO.lecamt}</td>
						<td>${lodrVO.lodrstatus}</td>
						<td>${lodrVO.lodrtime}</td>
						<td>${lodrVO.lodrlmod}</td>
                        <td>
                        	<form id="formGetOne" method="post" action="<%=request.getContextPath()%>/back-end/lecseat/listOneSeat.jsp">
                        		<input type="hidden" name="lodrno" value="${lodrVO.lodrno}">
								<button type="submit" class="btn view"><i class="material-icons">&#xE417;</i></button>
                            </form>
                        </td>
                        </tr>
		</c:forEach>
                    
                          
                </tbody>
            </table>
            <%@ include file="/back-end/pool/page2.file" %>
        </div>
    </div>        
</div> 
</main>
</body>
</html>                                		