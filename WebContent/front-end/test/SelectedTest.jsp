  <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    

<!DOCTYPE html>
<html>
<head>
</head>
<body>

<jsp:include page="/index/front-index/header.jsp" />

<%-- <c:if test="${not empty errorMsgs}"> --%>
<!-- 	<ul> -->
<%-- 	    <c:forEach var="message" items="${errorMsgs}"> --%>
<%-- 			<li style="color:red">${message}</li> --%>
<%-- 		</c:forEach> --%>
<!-- 	</ul> -->
<%-- </c:if> --%>
<div class="container-fluid" style="margin-top: 90px;">

		
	<form action='<%= request.getContextPath()%>/question/questionTest.do' method='post' id="myForm">
<!--         <select name='level'> -->
<!--             <option value="-1">請選擇考題難易度</option> -->
<!--             <option value="simple">簡單</option> -->
<!--             <option value="medium">中等</option> -->
<!--             <option value="hard">困難</option> -->
<!--         </select> -->
        		<div class="row">
					<div class="col">
						<h1 id="pageTitle" style="text-align:center">測驗單元</h1>
					</div>
				</div>

				<div class="row  justify-content-center">
				
					<div class="col-2">
        				<div class="form-group">
    						<select class="form-control" id="exampleFormControlSelect1" name ="level">
      				 			<option value="-1">請選擇考題難易度</option>
            		 			<option value="simple">簡單</option>
            		 			<option value="medium">中等</option>
            		 			<option value="hard">困難</option>
			    			</select>
  						</div>
        			</div>
        			
        			<div class="col-2">
        				<div class="form-group">
    						<select class="form-control" id="exampleFormControlSelect2" name ="unit">
      				 			<option value="-1">請選擇測驗單元</option>
            		 			<option value="1">單元一</option>
            		 			<option value="2">單元二</option>
            		 			<option value="3">單元三</option>
			    			</select>
  						</div>
        			</div>
        			
        			<div class="col-2">
						<button type="button" class="btn btn-info" id="enterTest">進入測驗</button>
						<input type='hidden' name='courseno' value="<%= request.getParameter("courseno") %>">
					</div>
				
				</div>
				
				
				
		</div>
        <input type="hidden" name="action" value="printPaper">
    	</form>
    	
	</div>
	
</div>
<script>
	$(document).ready(function(){
		$('#enterTest').click(function(){
			if($('#exampleFormControlSelect1').find('option:selected').val() === '-1'  || $('#exampleFormControlSelect2').find('option:selected').val() === '-1' ){
				swal('請選擇難易度及單元', '', 'error');
			}
			else{
				$('#myForm').submit();
			}
		});
	});
</script>
    <jsp:include page="/index/front-index/footer.jsp" />
</body>
</html>