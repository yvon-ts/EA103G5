<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.lecture.model.*" %>
<%@ page import="com.lecorder.model.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<%
	String memno = "";
	MembersVO memVO = (MembersVO)session.getAttribute("loginMembersVO");
	if (memVO != null){
		memno = memVO.getMemno();
		System.out.println("listByMemno的memno="+ memno);
	} else {
		memno = (String) request.getAttribute("memno");
	}
	
	LodrService lodrSvc = new LodrService();
	List<LodrVO> list = lodrSvc.getListByMem(memno);
	pageContext.setAttribute("list", list);
%>
<jsp:useBean id="lecSvc" scope="page" class="com.lecture.model.LecService" />
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>Xducation - 陪你成長的學習好夥伴</title>
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto|Varela+Round">
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
<link rel="stylesheet" href="<%=request.getContextPath()%>/library/bootstrap/4.5.3/css/bootstrap.min.css">
<%@ include file="/index/front-index/header.jsp" %>
<link rel="stylesheet" href="<%=request.getContextPath()%>/back-end/css/bootTable.css">
<style>
#head{
	max-height: 800px;
	width: auto;
}
</style>
</head>
<body>
<div id="padd">padd</div>
<div id="table-area" class="container-xl">
    <div class="table-responsive">
    <img id="head" src="<%=request.getContextPath()%>/index/front-index/assets/img/head/lodr.png">
        <div class="table-wrapper">			
            <div class="table-title">
                <div class="row">
                    <div class="col-sm-3">
                    </div>
                    <div class="col-sm-4">
                        <h2 class="text-center">我的講座訂單</h2>
                    </div>
                </div>
            </div>
            <table class="table table-bordered">
                <thead>
                    <tr>
                        <th>訂單編號</th>
                        <th>講座名稱</th>
                        <th>訂單金額</th>
                        <th>訂單狀態</th>
                        <th>成立時間</th>
                        <th>查看座位</th>
                        <th>變更座位</th>
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
			<form method="post" action="<%=request.getContextPath()%>/front-end/lecseat/listWithQRcode.jsp">
				<input type="hidden" name="memno" value="<%=memno%>">
            	<input type="hidden" name="lodrno" value="${lodrVO.lodrno}">
				<button type="submit" class="btn view"><i class="material-icons">&#xE417;</i></button>
            </form>
            </td>
            <td>
            	<form method="post" action="<%=request.getContextPath()%>/front-end/lecseat/cancelSeatMem.jsp">
            	<input type="hidden" name="memno" value="<%=memno%>">
            	<input type="hidden" name="lodrno" value="${lodrVO.lodrno}">
				<button type="submit" class="btn view" style="color: orange"><i class="material-icons">&#xE254;</i></button>
            </form>
            </td>
            </tr>
		</c:forEach>
                    
                          
                </tbody>
            </table>
            
            <div style="text-align: right">
				<%@ include file="/back-end/pool/page2.file" %>
            </div>
        </div>
    </div>        
</div>
<%@ include file="/index/front-index/footer.jsp" %>
</body>
</html>                                		