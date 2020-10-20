<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.lecture.model.*" %>
<%@ page import="com.lecorder.model.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<%
	String memno = request.getParameter("memno");
	LodrService lodrSvc = new LodrService();
	List<LodrVO> list = lodrSvc.getListByMem(memno);
	pageContext.setAttribute("list", list);
%>
<jsp:useBean id="lecSvc" scope="page" class="com.lecture.model.LecService" />
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>Bootstrap Elegant Table Design</title>
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto|Varela+Round">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/back-end/css/bootTable.css">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
<style>
body {
    color: #566787;
    background: #f5f5f5;
    font-family: 'Roboto', sans-serif;
}
</style>
<script>
$(document).ready(function(){
	$('[data-toggle="tooltip"]').tooltip();
	// Animate select box length
	var searchInput = $(".search-box input");
	var inputGroup = $(".search-box .input-group");
	var boxWidth = inputGroup.width();
	searchInput.focus(function(){
		inputGroup.animate({
			width: "300"
		});
	}).blur(function(){
		inputGroup.animate({
			width: boxWidth
		});
	});
});
</script>
</head>
<body>
<div class="container-xl">
    <div class="table-responsive">
        <div class="table-wrapper">			
            <div class="table-title">
                <div class="row">
                    <div class="col-sm-4">
                        <div class="show-entries">
                            <span>Show</span>
                            <select>
                                <option>5</option>
                                <option>10</option>
                                <option>15</option>
                                <option>20</option>
                            </select>
                            <span>entries</span>
                        </div>						
                    </div>
                    <div class="col-sm-4">
                        <h2 class="text-center">Customer <b>Details</b></h2>
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
                        <th>訂單編號<i class="fa fa-sort"></i></th>
                        <th>講座名稱</th>
                        <th>訂單金額<i class="fa fa-sort"></i></th>
                        <th>訂單狀態</th>
                        <th>成立時間<i class="fa fa-sort"></i></th>
                        <th>查看座位</th>
                    </tr>
                </thead>
                <tbody>
                    <%@ include file="/back-end/pool/page1.file" %>
                        <c:forEach var="lodrVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
			<tr><td>${lodrVO.lodrno}</td>
			<c:forEach var="lecVO" items="${lecSvc.list}">
				<c:if test="${lodrVO.lecno == lecVO.lecno}">
					<td>${lecVO.lecname}</td>
				</c:if>
			</c:forEach>
			<td>${lodrVO.lecamt}</td>
			<td>${lodrVO.lodrstatus}</td>
			<td>${lodrVO.lodrtime}</td>
            <td>
            <form id="formGetOne" method="post" action="<%=request.getContextPath()%>/front-end/lecseat/listOneForMem.jsp">
            <input type="hidden" name="lodrno" value="${lodrVO.lodrno}">
			<button type="submit" class="btn view"><i class="material-icons">&#xE417;</i></button>
            </form>
            </td>
            </tr>
		</c:forEach>
                    
                          
                </tbody>
            </table>
            <%@ include file="/back-end/pool/page2.file" %>
            <div class="clearfix">
                <ul class="pagination">
                    <li class="page-item disabled"><a href="#">Previous</a></li>
                    <li class="page-item"><a href="#" class="page-link">1</a></li>
                    <li class="page-item"><a href="#" class="page-link">2</a></li>
                    <li class="page-item active"><a href="#" class="page-link">3</a></li>
                    <li class="page-item"><a href="#" class="page-link">4</a></li>
                    <li class="page-item"><a href="#" class="page-link">5</a></li>
                    <li class="page-item"><a href="#" class="page-link">Next</a></li>
                </ul>
            </div>
        </div>
    </div>        
</div> 
  
</body>
</html>                                		