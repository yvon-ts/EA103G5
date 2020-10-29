<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.coup_code.model.*, com.members.model.*"%>


<%
	MembersVO memberVO = (MembersVO) session.getAttribute("loginMembersVO");
	System.out.println(memberVO);
	String memno = memberVO.getMemno();

	CoupCodeService coupSvc = new CoupCodeService();
	List<CoupCodeVO> list = coupSvc.getMemberCoup(memno);
	pageContext.setAttribute("list", list);
%>

<html>
<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>Xducation - 陪你成長的學習好夥伴</title>
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Roboto|Varela+Round">
<link rel="stylesheet"
	href="https://fonts.googleapis.com/icon?family=Material+Icons">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/library/bootstrap/4.5.3/css/bootstrap.min.css">
<%@ include file="/index/front-index/header.jsp"%>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/back-end/css/bootTable.css">
<style>
</style>
<script>
	
</script>
</head>
<body>

	<div id="padd">padd</div>
	<div id="table-area" class="container-xl">
		<div class="table-responsive">
			<div class="table-wrapper">
				<div class="table-title">
					<div class="row">
						<div class="col-sm-3"></div>
						<div class="col-sm-4">
							<h2 class="text-center">持有折扣券</h2>
						</div>
					</div>
				</div>
				<table class="table table-bordered">
					<thead>
						<tr>
							<th>折扣券號碼</th>
							<th>折扣券金額</th>
							<th>領取時間</th>
							<th>使用期限</th>
						</tr>
					</thead>
					<tbody>
						<%@ include file="/back-end/pool/page1.file"%>
						<c:forEach var="coupVO" items="${list}"
							begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
							<tr>
								<td>${coupVO.coupcode}</td>
								<td>${coupVO.discamt}</td>
								<td>${coupVO.couptime}</td>
								<td>${coupVO.coupexp}</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<%@ include file="/back-end/pool/page2.file"%>
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
	<%@ include file="/index/front-index/footer.jsp"%>
</body>
</html>
