<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.order_master.model.*"%>
<%
    OrderMasterService orderSvc = new OrderMasterService();
    List<OrderMasterVO> list = orderSvc.getAll();
    pageContext.setAttribute("list",list);
%>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Bootstrap Order Details Table with Search Filter</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/back-end/index/css/main.css>">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto|Varela+Round">
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <style>
        body {
        color: #566787;
		background: #f5f5f5;
		font-family: 'Varela Round', sans-serif;
		font-size: 13px;
	}
	.table-wrapper {
        background: #fff;
        padding: 20px 25px;
        margin: 30px auto;
		border-radius: 3px;
        box-shadow: 0 1px 1px rgba(0,0,0,.05);
    }
	.table-wrapper .btn {
		float: right;
		color: #333;
    	background-color: #fff;
		border-radius: 3px;
		border: none;
		outline: none !important;
		margin-left: 10px;
	}
	.table-wrapper .btn:hover {
        color: #333;
		background: #f2f2f2;
	}
	.table-wrapper .btn.btn-primary {
		color: #fff;
		background: #03A9F4;
	}
	.table-wrapper .btn.btn-primary:hover {
		background: #03a3e7;
	}
	.table-title .btn {		
		font-size: 13px;
		border: none;
	}
	.table-title .btn i {
		float: left;
		font-size: 21px;
		margin-right: 5px;
	}
	.table-title .btn span {
		float: left;
		margin-top: 2px;
	}
	.table-title {
		color: #fff;
		background: #4b5366;		
		padding: 16px 25px;
		margin: -20px -25px 10px;
		border-radius: 3px 3px 0 0;
    }
    .table-title h2 {
		margin: 5px 0 0;
		font-size: 24px;
	}
	.show-entries select.form-control {        
        width: 60px;
		margin: 0 5px;
	}
	.table-filter .filter-group {
        float: right;
		margin-left: 15px;
    }
	.table-filter input, .table-filter select {
		height: 34px;
		border-radius: 3px;
		border-color: #ddd;
        box-shadow: none;
	}
	.table-filter {
		padding: 5px 0 15px;
		border-bottom: 1px solid #e9e9e9;
		margin-bottom: 5px;
	}
	.table-filter .btn {
		height: 34px;
	}
	.table-filter label {
		font-weight: normal;
		margin-left: 10px;
	}
	.table-filter select, .table-filter input {
		display: inline-block;
		margin-left: 5px;
	}
	.table-filter input {
		width: 200px;
		display: inline-block;
	}
	.filter-group select.form-control {
		width: 110px;
	}
	.filter-icon {
		float: right;
		margin-top: 7px;
	}
	.filter-icon i {
		font-size: 18px;
		opacity: 0.7;
	}	
    table.table tr th, table.table tr td {
        border-color: #e9e9e9;
		padding: 12px 15px;
		vertical-align: middle;
    }
	table.table tr th:first-child {
		width: 60px;
	}
	table.table tr th:last-child {
		width: 80px;
	}
    table.table-striped tbody tr:nth-of-type(odd) {
    	background-color: #fcfcfc;
	}
	table.table-striped.table-hover tbody tr:hover {
		background: #f5f5f5;
	}
    table.table th i {
        font-size: 13px;
        margin: 0 5px;
        cursor: pointer;
    }	
	table.table td a {
		font-weight: bold;
		color: #566787;
		display: inline-block;
		text-decoration: none;
	}
	table.table td a:hover {
		color: #2196F3;
	}
	table.table td a.view {        
		width: 30px;
		height: 30px;
		color: #2196F3;
		border: 2px solid;
		border-radius: 30px;
		text-align: center;
    }
    table.table td a.view i {
        font-size: 22px;
		margin: 2px 0 0 1px;
    }   
	table.table .avatar {
		border-radius: 50%;
		vertical-align: middle;
		margin-right: 10px;
	}
	.status {
		font-size: 30px;
		margin: 2px 2px 0 0;
		display: inline-block;
		vertical-align: middle;
		line-height: 10px;
	}
    .text-success {
        color: #10c469;
    }
    .text-info {
        color: #62c9e8;
    }
    .text-warning {
        color: #FFC107;
    }
    .text-danger {
        color: #ff5b5b;
    }
    .hint-text {
        float: left;
        margin-top: 10px;
        font-size: 13px;
    }
    .page-change {
    	color: #000;
    }
    a .test{
    color:black !important;
    }
    
</style>
    <script>
        $(document).ready(function(){
	$('[data-toggle="tooltip"]').tooltip();
});
</script>
</head>

<body>
    <%@ include file="/back-end/index/homepage.jsp"%>
    <main class="app-content">
        <c:if test="${not empty errorMsgs}">
            <font style="color:red">請修正以下錯誤:</font>
            <ul>
                <c:forEach var="message" items="${errorMsgs}">
                    <li style="color:red">${message}</li>
                </c:forEach>
            </ul>
        </c:if>
        <div class="container">
            <div class="table-wrapper">
                <div class="table-title">
                    <div class="row">
                        <div class="col-sm-4">
                            <h2>Order <b>Masters</b></h2>
                        </div>
                        <div class="col-sm-8">
                        </div>
                    </div>
                </div>
                <div class="table-filter">
                    <div class="row">
                        <div class="col-sm-3">
                   	
                        </div>
                        <div class="col-sm-9">
                            <button type="button" class="btn btn-primary"><i class="fa fa-search"></i></button>
                            <div class="filter-group">
                                <label>訂單編號</label>
                                <input type="text" class="form-control">
                            </div>
<!--                             <div class="filter-group"> -->
<!--                                 <label>訂單狀態</label> -->
<!--                                 <select class="form-control"> -->
<!--                                     <option>全部</option> -->
<!--                                     <option>未付款</option> -->
<!--                                     <option>已付款</option> -->
<!--                                     <option>失效訂單</option> -->
<!--                                     <option>已結單</option> -->
<!--                                 </select> -->
<!--                             </div> -->
                            <span class="filter-icon"><i class="fa fa-filter"></i></span>
                        </div>
                    </div>
<%--                      <%@ include file="page1.file" %> --%>
                </div>
               
                <table class="table table-striped table-hover">
                    <thead>
                        <tr>
                            <th>課程訂單編號</th>
                            <th>會員編號</th>
                            <th>訂單成立時間</th>
                            <th>課程訂單狀態</th>
                            <th>總金額</th>
                            <th>折扣碼編號</th>
                            <th>付款方式</th>
                        </tr>
                    </thead>
                    
<%--                     <c:forEach var="ordermasterVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>"> --%>
                        <tbody>
                            <tr>
                                <td><a href="<%=request.getContextPath()%>/Order_Detail/Order_Detail.do?action=getOne_For_Display&orderno=${ordermasterVO.orderno}">${ordermasterVO.orderno}</a></td>
                                <td>${ordermasterVO.memno}</td>
                                <td>${ordermasterVO.orderdate}</td>
                                <td>${ordermasterVO.orderstatus}</td>
                                <td>${ordermasterVO.orderamt}</td>
                                <td>${ordermasterVO.coupno}</td>
                                <td>${ordermasterVO.payby}</td>
                                <td>
                                    <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/Order_Master/Order_Master.do" style="margin-bottom: 0px;">
                                        <input type="submit" value="修改">
                                        <input type="hidden" name="orderno" value="${ordermasterVO.orderno}">
                                        <input type="hidden" name="action" value="getOne_For_Update"></FORM>
                                </td>
                            </tr>
<%--                     </c:forEach> --%>
                </table>
                </tbody>
                </table>
            </div>
<%--             <div class="page-change"><%@ include file="page2.file" %></div> --%>
           
        </div>
        
    </main>
</body>

</html>