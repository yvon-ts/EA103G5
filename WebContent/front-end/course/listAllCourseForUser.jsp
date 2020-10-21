<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.*"%>
<%@ page import="com.course.model.*,com.course_type.model.*"%>

<%
	List<CourseVO> list = (List<CourseVO>)request.getAttribute("list");
	
	if(list == null){
		CourseService cSvc = new CourseService();
		list = cSvc.getAllForUser();
	}
	
	pageContext.setAttribute("Courselist",list);
	
	List<Integer> averageScore = new ArrayList<>();
	for(CourseVO vo : list){
		averageScore.add(vo.getCsscore()/vo.getCsscoretimes());
	}
	
	int i = 0 ;
	
	String memno = (String) session.getAttribute("memno");
	memno = "MEM0001";
	pageContext.setAttribute("memno",memno);
%>

<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>所有課程列表 - listAllCourse.jsp</title>
<!-- <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.rateit/1.1.3/jquery.rateit.min.js"></script> -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<style>
</style>

</head>

<body>
	<!-- member -->
	<input type="hidden" id ="memno" value="${memno}"/>
	<jsp:useBean id="courseTypeSvc" scope="page" class="com.course_type.model.CourseTypeService"/>
	<jsp:include page="/index/front-index/header.jsp"/>
	
	<div id="hero-area" style="background-image: none">
	<div class="container">
                <div class="container">
                
  			<div class="row">
    				<div class="col-2">
      						
                            <label>課程名稱</label>      
                            
                            <div><input class="form-control" type="text" placeholder="&nbsp;&nbsp;今天想學什麼呢？" id="searchText"></div>
                                  
                     </div> 
    				<div class="col-2">
    						<label>類別名稱</label>
    						<div>
    						<select class="form-control" id="cstypeno">
									<option value="all">請選擇類別</option>
									<c:forEach var="courseVO" items="${courseTypeSvc.all}">
      									<option value="${courseVO.cstypeno}">${courseVO.cstypename}</option>
      								</c:forEach>
							</select>
      							
      							
      						</div>
    				</div>
    				<div class="col-2">
      						<label>最低價格</label>
      						<input class="form-control" type="number" size="5" min="0" name="minValue" id="min">
    				</div>
    				<div class="col-2">
      						<label>最高價格</label>
      						<input class="form-control" type="number" size="5" min="0" name="maxValue" id="max">
    				</div>
    				<div class="col-2">
    						<label>排序</label>
      						<select class="form-control" id="order">
      							<option value="courlmod" seleted>最新</option>
  								<option value="csscore">評價高&#x27A1;低</option>
  								<option value="ttltime">課時高&#x27A1;低</option>
  								<option value="courseprice">價格高&#x27A1;低</option>
  								<option value="coursepriceLow">價格低&#x27A1;高</option>
							</select>
    				</div>
    				<div class="col-2">
    					<label></label>
    					<button type="button" class="btn btn-primary" id="turnin" style="display:block">送出查詢</button>
    				</div>
  			</div>
  
			</div>
                      
	<section id="services" class="section-padding">
        <div class="container">
            
                <!-- Services item1 -->
                
                		<div class="row seacharea">
                		<c:forEach var="courseVO" items="${Courselist}">
                <div class="col-md-6 col-lg-3 col-xs-12">
                    <div class="services-item wow fadeInRight" data-wow-delay="0.3s">
                        <div class="icon">
                            <img src="<%=request.getContextPath()%>/course/coursephoto.do?action=searchPhoto&courseno=${courseVO.courseno}" style="width:200px;height:150px" class="pic">
                        </div>
                        <div class="services-content">
                        	
                        	<%
                        		for(int j = 0 ; j < 5 ; j++){
                        			if(j<averageScore.get(i)){
                        	%>
                        		<i class="lni-star-filled" ></i>
                        	<%}	
                        			else{%>
                        				<i class="lni-star-filled" style="color:#ADADAD"></i>
                        			<% }
                        		}
                        	i++;
                        	%>
<!--                         	套件ajax套有問題 -->
<%--                         	&nbsp;&nbsp;&nbsp;<div class="rateit" data-rateit-value="${courseVO.csscore / courseVO.csscoretimes }" data-rateit-ispreset="true" data-rateit-readonly="true"></div>  --%>
                        	<br>&nbsp;&nbsp;&nbsp;${courseVO.csscoretimes}則評價
                            <h3><a href="#">${courseVO.coursename}</a></h3>
                            <p>課程共${courseVO.ttltime}分鐘</p>
<!--                             <p>同學累計9487人</p> -->
							
							<form name="shoppingForm" action="<%=request.getContextPath()%>/Shop/Shopping_Cart.do" method="POST">
							<label class="shoppingcart"><input type="submit" name="Submit"><i class="fa fa-shopping-cart" aria-hidden="true"></i>&nbsp;加入購物車</label>
							<input type="hidden" name="action" value="ADD" />
							<input type="hidden" name="courseno" value="${courseVO.courseno}" />
							<input type="hidden" name="courseprice" value="${courseVO.courseprice}" />
							</form>
							
							<label class="bookmark"><i class="fa fa-heart-o" aria-hidden="true" style="color:red"></i>&nbsp;加入追蹤</label>
							<input type ="hidden" name="courseno" value ="${courseVO.courseno}"/>
							
							
                           	&nbsp;&nbsp;<h5>NT$${courseVO.courseprice}</h5>
                        	
                        </div>
                    </div>
                </div>
                
                </c:forEach>
                 </div>
                
            
          </div>
          
       </section>
       </div>
       </div>
<script>
	$(document).ready(function(){
		
		$('.shoppingcart').click(function(){
			alert('加入購物車');
		});
		
		
		$('.bookmark').click(function(){

			var courseno = $(this).next().val();
			var memno = $("#memno").val();
			var action ;
			
			if ($(this).children().attr("class") === "fa fa-heart-o"){
				action = "insert";
				$(this).children().attr("class","fa fa-heart");
			}
			else{
				action = "delete";
				$(this).children().attr("class","fa fa-heart-o");
			}
			
			$.ajax({
				url	:"<%=request.getContextPath()%>/course/coursesearch.do", 
				data:{
					searchText:$('#searchText').val(),
					
				}
			});
			
			
		});
		
		$('#turnin').click(function(){
			$.ajax({
				type:"post",
				url	:"<%=request.getContextPath()%>/course/coursesearch.do", 
				data:{
					searchText:$('#searchText').val(),
					cstypeno:$('#cstypeno').val(),
					min:$('#min').val(),
					max:$('#max').val(),
					order:$('#order').val(),
					action:'mutlipleSearch'
				},
				success: function(data){
					var JSONarray = JSON.parse(data);
					$(".seacharea").empty();
					
					var str = "";
					for(let i = 0 ; i < JSONarray.length ; i++){
						
						var courseimgno = "<%=request.getContextPath()%>/course/coursephoto.do?action=searchPhoto&courseno=" + JSONarray[i].courseno;
						
					
						
						str +=  `<div class="col-md-6 col-lg-3 col-xs-12">
		                    <div class="services-item wow fadeInRight" data-wow-delay="0.3s">
		                        <div class="icon">
		                            <img src=  "` +  courseimgno    + `"style="width:200px;height:150px">
		                        </div>
		                        <div class="services-content">`;
		                        
		                        
						for(let j = 0; j < 5; j++){
							if(j<Math.floor(JSONarray[i].csscore/JSONarray[i].csscoretimes) ){
								str+= `<i class="lni-star-filled" style="margin-left:5px"></i>`;
							}else{
								str+= `<i class="lni-star-filled" style="color:#ADADAD;margin-left:5px"></i>`;
							}
                       	 
                        }
		                                str += `<br>&nbsp;&nbsp;`+JSONarray[i].csscoretimes+`則評價
		                            <h3><a href="#">`+JSONarray[i].coursename+`</a></h3>
		                            <p>課程共`+JSONarray[i].ttltime+`分鐘</p>
		<!--                             <p>同學累計9487人</p> -->
									<label class="shoppingcart"><i class="fa fa-shopping-cart" aria-hidden="true"></i>&nbsp;加入購物車</label>
									<label class="bookmark"><i class="fa fa-heart-o" aria-hidden="true" style="color:red"></i>&nbsp;加入追蹤</label>
									<h5>NT$`+JSONarray[i].courseprice+`</h5>
		                        </div>
		                    </div>
		                </div>`;
						
					}
					
					
					$(".seacharea").html(str);
					
				}
			});
		});
		
	});
</script>

	<jsp:include page="/index/front-index/footer.jsp"/>
	
</body>
</html>