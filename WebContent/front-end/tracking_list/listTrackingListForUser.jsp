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
	label{
		height:30px;
	}
	a.course{
		 color: rgba(0, 0, 0, 0.65);
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
            <div class="section">
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
                        	<a href="<%=request.getContextPath()%>/course/course.do?action=showCourseMainPage&courseno=${courseVO.courseno}" class="course">
                            <div class="row">
                            	
                                <div class="col-md-3 text-left">
                                    <img src="<%=request.getContextPath()%>/course/CoursePictureReaderFromDB?courseno=${courseVO.courseno}" alt="" class="img-fluid d-none d-md-block rounded mb-2 shadow ">
                                </div>
                                <div class="col-md-9 text-left mt-sm-2">
                                    <h5>${courseVO.coursename}</h5>
                                </div>
                            </div>
                            </a>
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
            <button type="button" class="btn btn-primary" id= "checkout">填寫訂購人資料</button>
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
            
                <h2 class="section-title wow fadeInDown" data-wow-delay="0.3s"><i class="fa fa-heart" aria-hidden="true"  style="font-size:25px"></i>&nbsp;追蹤清單</h2>
                <div class="title wow fadeInDown" data-wow-delay="0.3s"></div>
            
            <div class="row trackingArea">
            		
            </div>
            <div align="center"><button class="btn btn-common" id="js-load-more" >載入更多</button></div>
        </div>
    </section>
	
	<script>
    	
		<c:if test="${not empty payoff}">
    	swal('付款成功！', '', 'success');
		</c:if>
		<%request.getSession().removeAttribute("payoff");%>
  
	</script>
	
	<script>
		$(document).ready(function(){
			
			
			//送出按出按鈕
			$('#checkout').click(function(){
				if('${loginMembersVO.memno}' ==''){
					swal({ 
						  title: '您尚未登入', 
						  text: '您將無法結帳，請先登入會員', 
						  type: 'warning',
						  showCancelButton: true, 
						  confirmButtonColor: '#3085d6',
						  cancelButtonColor: '#d33',
						  confirmButtonText: '會員登入', 
						}).then(function(){
							this.location.href = '<%=request.getContextPath()%>/front-end/members/signIn.jsp';
						});
				}else{
					var checkout = document.createElement('a');
					checkout.href = "<%=request.getContextPath()%>/front-end/Shop/Checkout.jsp";
					checkout.click();
				}
			});
			
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
						
					}
				});
			});
			
			
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
						url	:"<%=request.getContextPath()%>/Shop/Shopping_Cart.do",
						data:{
							courseno:$(this).next().val(),
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
					url	:"<%=request.getContextPath()%>/Shop/Shopping_Cart.do",
					data:{
						courseno:$(this).find('#courseno').val(),
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
	                        				<a href="<%=request.getContextPath()%>/course/course.do?action=showCourseMainPage&courseno=` + JSONObj.courseno + `" class="course">
                            					<div class="row">
                            					
                                					<div class="col-md-3 text-left">
                                    					<img src="<%=request.getContextPath()%>/course/CoursePictureReaderFromDB?courseno=`+ JSONObj.courseno +`" alt="" class="img-fluid d-none d-md-block rounded mb-2 shadow ">
                                					</div>
                                					<div class="col-md-9 text-left mt-sm-2">
                                    						<h5>` + JSONObj.coursename + `</h5>
                                					</div>
                                				
                            					</div>
                            				</a>
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
				                <button type="button" class="btn btn-primary" id= "checkout">Checkout</button>
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
								
								$('#shoppingCart tr:last').after(commonStr);
								
								var totalPriceString = $('#totalPrice').text();
								var totalPrice = $('#totalPrice').text().replace('Total:$','');
								$('#totalPrice').text( 'Total:$' + (parseInt(totalPrice)+parseInt($('#courseprice'+count).val())));
							}
							
							$('#number').text($('#shoppingCart tr').length - 1);
							
							//送出按紐
							$('#checkout').click(function(){
								if('${loginMembersVO.memno}' ==''){
									swal({ 
										  title: '您尚未登入', 
										  text: '您將無法結帳，請先登入會員', 
										  type: 'warning',
										  showCancelButton: true, 
										  confirmButtonColor: '#3085d6',
										  cancelButtonColor: '#d33',
										  confirmButtonText: '會員登入', 
										}).then(function(){
											this.location.href = '<%=request.getContextPath()%>/front-end/members/signIn.jsp';
										}).catch(swal.noop);
								}else{
									var checkoutAjax = document.createElement('a');
									checkoutAjax.href = "<%=request.getContextPath()%>/front-end/Shop/Checkout.jsp";
									checkoutAjax.click();
								}
							});

							//刪除購物車
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
									url	:"<%=request.getContextPath()%>/Shop/Shopping_Cart.do",
									data:{
										courseno: $(this).next().val(),
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
			
			
			var pageSize = 4;
			
			
			if('${loginMembersVO.memno}' !=='' && '${TrackingListSvc.getAll(loginMembersVO.memno,0).size()} != 0'){
				
				getData(pageSize);
			}else{
				$('#js-load-more').hide();
			}
			
			/*監聽載入更多*/
			
			$(document).on('click', '#js-load-more', function(){
			pageSize += 4;
			
		
				getData(pageSize );
			
			});
			
		});
		function getData(counter ){
			
			
			
			$.ajax({
				type: 'POST',
				url: "<%=request.getContextPath()%>/tracking_list/tracking_list.do", 
				data:{
					memno:$('#memno').val(),
					pagesize:counter,
					action:'getAllTrackingListByMemno'
				},
				success: function(data){
					
					
					var JSONarray = JSON.parse(data);
					
						
					if(JSONarray.length %4 != 0 || JSONarray.length == 0){
						$('#js-load-more').hide();
					}
					
					var result = '';
					
					for(let i=0; i< JSONarray.length; i ++){
						
						
						result += 	`<div class="col-md-6 col-lg-3 col-xs-12">`;
						result +=	`<div class="services-item wow fadeInRight" data-wow-delay="0.3s">`;
						result +=	`<div class="icon"><a href="<%=request.getContextPath()%>/course/course.do?action=showCourseMainPage&courseno=`+ JSONarray[i].courseno +`" class="course">`
						result +=	`<img src="<%=request.getContextPath()%>/course/CoursePictureReaderFromDB?courseno=` + JSONarray[i].courseno  +`" style="width: 200px; height: 150px;" class="pic"></div>`;
                			
						result +=   `<div class="services-content">`;
                		result += 	`&nbsp;&nbsp;&nbsp;<div class="rateit" data-rateit-value="`+ JSONarray[i].csscore / JSONarray[i].csscoretimes + `" data-rateit-ispreset="true" data-rateit-readonly="true"></div> `; 
          	
                		result +=	`<br>&nbsp;&nbsp;&nbsp;`+ JSONarray[i].csscoretimes  + `則評價`;
                		result +=   `<h3 style="line-height:32px; height:64px; overflow:hidden;">`+ JSONarray[i].coursename + `</h3>`;
                		
                		
                		result +=   `<p>課程共` + Math.floor(JSONarray[i].ttltime/60) + `分鐘</p></a>`;
                    
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
						result += 	`<hr><h5 style="bottom:13px;">NT$` + JSONarray[i].courseprice + `</h5></div></div></div></div>`;
						
                
					}
					
					
					$('.trackingArea').append(result);
					
					$("div.rateit, span.rateit").rateit();
				

					
				
				}	
				});
			}
	</script>
	<jsp:include page="/index/front-index/footer.jsp" />
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.rateit/1.1.3/jquery.rateit.min.js"></script>
	
</body>




</html>