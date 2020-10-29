<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.tracking_list.model.*,com.course.model.*,java.util.*,com.members.model.*"%>

<%

	List<CourseVO> shoppingList = (List<CourseVO>)request.getSession().getAttribute("shoppingList");
	
	
	
	int productNumber = 0;
	if(shoppingList != null){
		productNumber =shoppingList.size();
	}
	
%>

<html>
<head>
	<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
	<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/jquery.rateit/1.1.3/rateit.css" />
<!-- 	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script> -->
	<style>
	.title{
            height: 1px;
            margin: 0 auto 30px;
            position: relative;
            background-color: #0099CC;
	}
	.shoppingCartArea,.trackingArea{
		text-align : center;
	}
	.js-load-more{
		padding:0 15px;
		width:120px;
		height:30px;
		background-color:#D31733;
		color:#fff;
		line-height:30px;
		border-radius:5px;
		margin:20px auto;
		border:0 none;
		font-size:16px;
		display:none;/*預設不顯示，ajax呼叫成功後才決定顯示與否*/
	}
	.rateit .rateit-preset {
	color: #FFCC36;
	background:
		url(https://cdnjs.cloudflare.com/ajax/libs/jquery.rateit/1.1.3/star.gif)
		left -32px !important;
}
	</style>


</head>
<body>

	<jsp:include page="/index/front-index/header.jsp" />
	
	
	<jsp:useBean id="courseTypeSvc" scope="page" class="com.course_type.model.CourseTypeService" />
	<jsp:useBean id="TrackingListSvc" scope="page" class="com.tracking_list.model.TrackingListService" />
	
<%-- 	<form method="post" action="<%=request.getContextPath()%>/Order_Master/Order_Master.do" id = "myForm">  --%>
	
	
	<section id="services" class="section-padding" style="padding:90px 0">
        <div class="container">
            <div class="section-header">
                <h2 class="section-title wow fadeInDown" data-wow-delay="0.3s"><i class="fa fa-shopping-cart" aria-hidden="true" style="font-size:25px"></i>&nbsp;Shopping Cart</h2>
                &nbsp;&nbsp;<i class="text-info font-weight-bold"><span id = "number"><%= productNumber%></span></i> items in your cart
                
                <input type = "hidden" id = "shoppingCartSize"  value= "<%= productNumber%>" >
                
                <c:if test="${empty shoppingList}">
                	<div class="title wow "></div>
                	<div class="shoppingCartArea">
                	<img class="fit-picture"
    							 src="<%=request.getContextPath()%>/index/front-index/assets/img/empty-box.svg"
     									alt="shoppingCart Empty"/>
     				<div>購物車空空的，來去逛逛吧!!!</div>	
     				
     				<button class="btn btn-common"  id="goToSearch" style="margin-top:3%;">
                    		搜尋課程
                    </button>
               		 </div>
     				
                </c:if>
              
      <c:if test="${not empty shoppingList}">
                 
                	<section>
           	
  <div class="container">
    <div class="row w-100">
        <div class="col-lg-12 col-md-12 col-12">
        
            <div class="shoppingCartArea">
            <table id="shoppingCart" class="table table-condensed table-responsive  wow fadeInDown" data-wow-delay="0.3s">
                <thead>
                    <tr>
                        <th style="width:70%">課程名稱</th>
                        <th style="width:10%">售價</th>
                        <th style="width:16%"></th>
                    </tr>
                </thead>
                <tbody>
                
                <c:set var="totalPrice" value="${0}" />
                
                <c:forEach var="courseVO" items="${shoppingList}" varStatus="counter">
                    <tr>
                    	
                        <td data-th="Product">
                            <div class="row">
                                <div class="col-md-3 text-left">
                                    <img src="<%=request.getContextPath()%>/course/CoursePictureReaderFromDB?courseno=${courseVO.courseno}" alt="" class="img-fluid d-none d-md-block rounded mb-2 shadow ">
                                </div>
                                <div class="col-md-9 text-left mt-sm-2">
                                    <h5><a href="<%=request.getContextPath()%>/course/course.do?action=showCourseMainPage&courseno=${courseVO.courseno}">${courseVO.coursename}</a></h5>
                                </div>
                            </div>
                        </td>
                        <td data-th="Price">${courseVO.courseprice}</td>
                        <c:set var="totalPrice" value="${totalPrice + courseVO.courseprice}" />
                      
                        <td class="actions" data-th="">
                            <div class="text-right">
                            		<input type="hidden"  id='courseprice${counter.count}' value ="${courseVO.courseprice}">
                                    <button type="button" class="btn btn-danger" id="remove${counter.count}">Remove</button>
                                    <input type="hidden"  name="courseno${counter.count}" id='courseno${counter.count}' value ="${courseVO.courseno}">
                            </div>
                        </td>
                        
                    </tr>
                   </c:forEach>
               	 </tbody>
                
            </table>
            
            <div class="float-right text-right">
               <h5 id="totalPrice"> Total:$${totalPrice}</h5>
            </div>
        
    
    
    <div class="title wow "></div>
    <div class="row mt-4 d-flex align-items-center">
        <div class="col-sm-6 order-md-2 text-right">
            <a href="<%=request.getContextPath()%>/front-end/Shop/Checkout.jsp"><button type="button" class="btn btn-primary" id= "checkout">填寫訂購人資料</button></a>
        </div>
        <div class="col-sm-6 mb-3 mb-m-1 order-md-1 text-md-left">
            <a href="<%=request.getContextPath()%>/front-end/course/listAllCourseForUser.jsp">
               <i class="fa fa-undo" aria-hidden="true"></i>&nbsp;&nbsp;返回商店頁面</a>
        </div>
    </div>
	</div>
</div>
</div>
</div>

</section>

 </c:if> 
               
           </div>     
</div>
	</section>
<!-- 	</form> -->
	<section id="services" class="section-padding" style="padding:90px 0">
        <div class="container">
            <div class="section-header">
                <h2 class="section-title wow fadeInDown" data-wow-delay="0.3s"><i class="fa fa-heart" aria-hidden="true"  style="font-size:25px"></i>&nbsp;追蹤清單</h2>
                <div class="title wow fadeInDown" data-wow-delay="0.3s"></div>
            
            <div class="row trackingArea">
            		
            </div>
            <div align="center"><button class="btn btn-common" id="js-load-more" >載入更多</button></div>
        </div>
       </div>
    </section>
	
	<script>
		$(document).ready(function(){
			
			
			$('#goToSearch').click(function(e){
				e.preventDefault();
				

				var a = document.createElement('a');
				a.href = '<%=request.getContextPath()%>/front-end/course/listAllCourseForUser.jsp';
				a.click();
				
			});
			//此頁面取消追蹤
			$('body').on('click','.deleteTrack',function(){
				
				$(this).parents('.col-md-6').remove();
				
				$.ajax({
					url	:"<%=request.getContextPath()%>/tracking_list/tracking_list.do",
					data:{
						courseno:$(this).find('#courseno').val(),
						action: "delete"
					},
					success: function(data){
						console.log(data);
						
// 						if(data ==='true')
// 							$(this).parents('.col-md-6').remove();
					}
				});
			});
			
			
			//註冊繳交表單
// 			$('body').on('click' , '#checkout',function(){ 
// 				$('#myForm').submit(); 
// 			 });
	
			//刪除的按鈕不知道why 一定要註冊兩次@@@
			//註冊移除按鈕
			for(let i = 1 ; i <= $('#shoppingCartSize').val() ; i++){
				$('body').on('click' , '#remove' + i,function(){
					
					
					
					$(this).parents('tr').remove();
					var totalPriceString = $('#totalPrice').text();
					var totalPrice = $('#totalPrice').text().replace('Total:$','');
					$('#totalPrice').text( 'Total:$' + (totalPrice-$(this).prev().val()));
					
					$('#number').text(parseInt($('#number').text()) - 1);
					
					if(parseInt($('#number').text()) == 0 ){
						
						
						$('.shoppingCartArea').empty();
						var str = `<img class="fit-picture"
							 src="<%=request.getContextPath()%>/index/front-index/assets/img/empty-box.svg"
								alt="shoppingCart Empty"/>
								<div>購物車空空的，來去逛逛吧!!!</div>	
						<button class="btn btn-common"  id="goToSearch" style="margin-top:3%;">
        						搜尋課程
        				</button>`;
						
        				$('.shoppingCartArea').append(str);
        				
        				$('#goToSearch').click(function(e){
        					e.preventDefault();
        					

        					var a = document.createElement('a');
        					a.href = '<%=request.getContextPath()%>/front-end/course/listAllCourseForUser.jsp';
        					a.click();
        					
        				});
					}
					
					$.ajax({
						url	:"<%=request.getContextPath()%>/tracking_list/tracking_list.do",
						data:{
							courseno:$(this).next().val(),
// 							memno    : $("#memno").val(),
							action: "shoppingCart",
							remove : "remove"
						},
						success: function(data){
							console.log('移除成功--->ShoppingCartPage');
						}
					});
					
				});
			}
			
			//註冊加入購物車
			//加載順序 js--->ajax 註冊事件會失效
			//https://www.zhihu.com/question/23895785
			$('body').on('click' , '.shoppingcart' , function(){
				
				$.ajax({
					url	:"<%=request.getContextPath()%>/tracking_list/tracking_list.do",
					data:{
						courseno:$(this).find('#courseno').val(),
// 						memno    : $("#memno").val(),
						action: "shoppingCart"
					},
					success: function(data){
						console.log('加入成功--->ShoppingCartPage');
						
						let count = 1 ;
						
						if(data !== 'false'){
							swal('你已將課程加入購物車！！', '', 'success');
									
							var JSONObj = JSON.parse(data);
							
														
							
							
							if($('#shoppingCart tr').length > 0){
								count = $('#shoppingCart tr').length ;
							}
							
							var commonStr = '';
							commonStr +=  	`<tr>
	                        				<td data-th="Product">
                            					<div class="row">
                                					<div class="col-md-3 text-left">
                                    					<img src="<%=request.getContextPath()%>/course/CoursePictureReaderFromDB?courseno=`+ JSONObj.courseno +`" alt="" class="img-fluid d-none d-md-block rounded mb-2 shadow ">
                                					</div>
                                					<div class="col-md-9 text-left mt-sm-2">
                                    						<h5><a href="<%=request.getContextPath()%>/course/course.do?action=showCourseMainPage&courseno=` + JSONObj.courseno + `">` + JSONObj.coursename + `</a></h5>
                                					</div>
                            					</div>
                        					</td>
                        
                        					<td data-th="Price">` + JSONObj.courseprice + `</td>
                      
                       						<td class="actions" data-th="">
                            					<div class="text-right">
                            					<input type="hidden"  id='courseprice`+ count + `' value ="` + JSONObj.courseprice + `">
                                    			<button type="button" class="btn btn-danger" id="remove`+ count + `">Remove</button>
                                    			<input type="hidden" name='courseno`+ count +`' id='courseno`+ count + `' value ="` + JSONObj.courseno + `">
                            					</div>
                       						 </td>
                    						</tr>`;
			             	
							if($('.fit-picture').length > 0){
								$('.fit-picture').remove();
								$('.shoppingCartArea').empty();
								
								
								var str = "" ;
								str +=	`<div class= "shoppingArea"><table id="shoppingCart" class="table table-condensed table-responsive  wow fadeInDown" data-wow-delay="0.3s">`;
				                str +=  `<thead>
				                    		<tr>
				                        		<th style="width:60%">課程名稱</th>
				                        		<th style="width:10%">售價</th>
				                        		<th style="width:16%"></th>
				                    		</tr>
				                		</thead>
				                		<tbody>`;
							
				                str += 	commonStr;	
				                		
				                		
				                		
				               str += ` </tbody>
				            	   </table>
				               		<div class="float-right text-right">
				                       		<h5 id="totalPrice"> Total:$` + JSONObj.courseprice + ` </h5>
				                    </div>
				            <div class="title wow "></div>
				            <div class="row mt-4 d-flex align-items-center">
				                <div class="col-sm-6 order-md-2 text-right">
				                <a href="<%=request.getContextPath()%>/front-end/Shop/Checkout.jsp"><button type="button" class="btn btn-primary" id= "checkout">Checkout</button></a>
				                    <input type="hidden" name="action" value="insert">
				                </div>
				                <div class="col-sm-6 mb-3 mb-m-1 order-md-1 text-md-left">
				                    <a href="<%=request.getContextPath()%>/front-end/course/listAllCourseForUser.jsp">
				                       <i class="fa fa-undo" aria-hidden="true"></i>&nbsp;&nbsp;Continue Shopping</a>
				                </div>
				            </div>
				        </div>`; 
				               
				               
				       
				                    
				                    	 			
				               	$('.shoppingCartArea').append(str);
				                
							}
							
							else{
// 								console.log($('#shoppingCart tr:last'));
								
								$('#shoppingCart tr:last').after(commonStr);
								
								var totalPriceString = $('#totalPrice').text();
								var totalPrice = $('#totalPrice').text().replace('Total:$','');
								$('#totalPrice').text( 'Total:$' + (parseInt(totalPrice)+parseInt($('#courseprice'+count).val())));
							}
							
							$('#number').text($('#shoppingCart tr').length - 1);
							
// 							$('body').on('click' , '#checkout',function(){
// 									$('#myForm').submit(); 
// 							});
							
							
							$('body').on('click' , '#remove' + count,function(){
								$(this).parents('tr').remove();
								var totalPriceString = $('#totalPrice').text();
								var totalPrice = $('#totalPrice').text().replace('Total:$','');
								$('#totalPrice').text( 'Total:$' + (totalPrice-$(this).prev().val()));
								
								$('#number').text(parseInt($('#number').text()) - 1);
								
								if(parseInt($('#number').text()) == 0 ){
									
									$('.shoppingCartArea').empty();
									
									var str = `<img class="fit-picture"
										 src="<%=request.getContextPath()%>/index/front-index/assets/img/empty-box.svg"
											alt="shoppingCart Empty"/>
											<div>購物車空空的，來去逛逛吧!!!</div>	
									<button class="btn btn-common"  id="goToSearch" style="margin-top:3%;">
			        						搜尋課程
			        				</button>`;
									
			        				$('.shoppingCartArea').append(str);
			        				
			        				$('#goToSearch').click(function(e){
			        					e.preventDefault();
			        					

			        					var a = document.createElement('a');
			        					a.href = '<%=request.getContextPath()%>/front-end/course/listAllCourseForUser.jsp';
			        					a.click();
			        					
			        				});
								}
								
								
								$.ajax({
									url	:"<%=request.getContextPath()%>/tracking_list/tracking_list.do",
									data:{
										courseno: $(this).next().val(),
// 										memno    : $("#memno").val(),
										action: "shoppingCart",
										remove :"remove"
									},
									success: function(data){
										console.log('移除成功--->ShoppingCartPage');
									}
								});
								
							});
							
							count++;
						}
					}
				});
			});
			
			var counter = 0; /*計數器*/
			var pageStart = 0; /*offset*/
			var pageSize = 4; /*size*/
			/*首次載入*/
			getData(pageStart, pageSize);
			/*監聽載入更多*/
			
		
			
			$(document).on('click', '#js-load-more', function(){
			counter++ ;
			pageStart = counter * pageSize;
			pageEnd = 	( counter + 1 ) * pageSize;
			getData(pageStart, pageEnd);
			
			
			});
			
		});
		function getData(offset,size){
			$.ajax({
				type: 'POST',
				url: "<%=request.getContextPath()%>/tracking_list/tracking_list.do", 
				data:{
					memno:$('#memno').val(),
					action:'getAllTrackingListByMemno'
				},
				success: function(data){
					var JSONarray = JSON.parse(data);
					
// 					console.log(JSONarray);
//	 				/****業務邏輯塊：實現拼接html內容並prepend到頁面*********/
					var sum = JSONarray.length;
					console.log(offset,size,sum);
//	 				/*如果剩下的記錄數不夠分頁，就讓分頁數取剩下的記錄數
//	 				* 例如分頁數是5，只剩2條，則只取2條
					var result = '';
					
					if(sum - offset < size ){
						size = sum - offset;
						}
					
					for(let i=offset; i< (offset+size); i ++){
						
						
						result += 	`<div class="col-md-6 col-lg-3 col-xs-12">`;
						result +=	`<div class="services-item wow fadeInRight" data-wow-delay="0.3s">`;
						result +=	`<div class="icon">`
						result +=	`<img src="<%=request.getContextPath()%>/course/CoursePictureReaderFromDB?courseno=` + JSONarray[i].courseno  +`" style="width: 200px; height: 150px;" class="pic"></div>`;
                			
						result +=   `<div class="services-content">`;
                		result += 	`&nbsp;&nbsp;&nbsp;<div class="rateit" data-rateit-value="`+ JSONarray[i].csscore / JSONarray[i].csscoretimes + `" data-rateit-ispreset="true" data-rateit-readonly="true"></div> `; 
          	
                		result +=	`<br>&nbsp;&nbsp;&nbsp;`+ JSONarray[i].csscoretimes  + `則評價`;
                		result +=   `<h3><a href="#">`+ JSONarray[i].coursename + `</a></h3>`;
                		result +=   `<p>課程共` + JSONarray[i].ttltime + `分鐘</p>`;
                    
                		result += 	`<label class="shoppingcart">
										<i class="fa fa-shopping-cart" aria-hidden="true">
												<input type ="hidden"  id="courseno" value ="`+ JSONarray[i].courseno +`">
										</i>&nbsp;加入購物車
									</label>`;
						result += 	`<label class="deleteTrack">
										<i class="fa fa-times" aria-hidden="true" style="color:red">
											<input type ="hidden"  id="courseno" value ="`+ JSONarray[i].courseno +`">
										</i>&nbsp;取消追蹤
									 </label>`;
						result += 	`<h5>NT$` + JSONarray[i].courseprice + `</h5></div></div></div></div>`;
                
					}
					
					
					$('.trackingArea').append(result);
					
					$("div.rateit, span.rateit").rateit();


// 				/*隱藏more按鈕*/
					if ( (offset + size) >= sum){
						$("#js-load-more").hide();
					}else{
						$("#js-load-more").show();
					}
				}	
				});
			}
	</script>
	<jsp:include page="/index/front-index/footer.jsp" />
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.rateit/1.1.3/jquery.rateit.min.js"></script>
	
</body>




</html>