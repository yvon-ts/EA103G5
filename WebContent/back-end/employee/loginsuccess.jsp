<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/back-end/index/homepage.jsp" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Xducation管理後臺</title>
<link rel="stylesheet" href="<%=request.getContextPath()%>/library/bootstrap/4.5.3/css/bootstrap.min.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto|Varela+Round">
<script src="<%=request.getContextPath()%>/library/jquery/jquery-3.5.1.js"></script>
<style>
.imgw{position: fixed;}

</style>
</head>
<body>
	<main class="app-content">		
		<div class="container">
    		<div id="link-area" class="row">
    			<div class="col-md-6">
    				</div>
        			<div class="imgw">
					<img src='<%=request.getContextPath()%>/index/front-index/assets/img/head/07.png'> 
					</div>
				</div>
        	</div>
    	</div>
    </main>
</body>
</html>