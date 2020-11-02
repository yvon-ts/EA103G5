<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/back-end/index/homepage.jsp" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Xducation管理後臺</title>
<style>
.words{font-size: 40px;
	   letter-spacing: 10px;
	   position: fixed ;
	   top:78%;
	   left: 54%;
}
.words2{font-size: 39px;
		letter-spacing: 10px;
		position: fixed ;
		top:50%;
		left: 51%;}
}
.imgw{position: fixed;}

</style>
</head>
<body>
	<main class="app-content">		
		<div class="container">
    		<div id="link-area" class="row">
    			<div class="col-md-6">
<!--     				<div class="words2"><b>Xducation</b> -->
    				</div>
        			<div class="imgw">
					<img src='<%=request.getContextPath()%>/index/front-index/assets/img/head/07.png'> 
					</div>
<%-- 				<div class="words"><b>${empname}</b></div> --%>
				</div>
        	</div>
    	</div>
    </main>
</body>
</html>