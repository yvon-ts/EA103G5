<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.tracking_list.model.*,com.course.model.*,java.util.*,com.members.model.*"%>

<%

	List<CourseVO> shoppingList = (List<CourseVO>)request.getSession().getAttribute("shoppingList");
	
	MembersVO Membersvo = (MembersVO) session.getAttribute("Membersvo");
	Membersvo = new MembersVO();
	Membersvo.setMemno("MEM0002");
	pageContext.setAttribute("Membersvo", Membersvo);	
	
	
	
	if(shoppingList!= null){
		System.out.println(shoppingList.size());
	}else{
		System.out.println(0);
	}
		
	
%>

<html>
<head>
	<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
	<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/jquery.rateit/1.1.3/rateit.css" />
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
	
	<input type="hidden" id="memno" value="${Membersvo.memno}" />
	
	<jsp:useBean id="courseTypeSvc" scope="page" class="com.course_type.model.CourseTypeService" />
	<jsp:useBean id="TrackingListSvc" scope="page" class="com.tracking_list.model.TrackingListService" />
	
	<section id="services" class="section-padding" style="padding:90px 0">
        <div class="container">
            <div class="section-header">
                <h2 class="section-title wow fadeInDown" data-wow-delay="0.3s"><i class="fa fa-shopping-cart" aria-hidden="true" style="font-size:25px"></i>購物車</h2>
                <div class="title wow fadeInDown" data-wow-delay="0.3s"></div>
                
                <c:if test="${empty shoppingList}">
                	<div class="shoppingCartArea">
                	<img class="fit-picture"
    							 src="<%=request.getContextPath()%>/index/front-index/assets/img/empty-box.svg"
     									alt="shoppingCart Empty"/>
     				<div>購物車空空的，來去逛逛吧!!!</div>	
     				
     				<button class="btn btn-common"  onclick="location.href='<%=request.getContextPath()%>/index/front-index/index.jsp'" style="margin-top:3%;">
                    		搜尋課程
                    </button>
               		 </div>
     				
                </c:if>
                
            </div>
         </div>
	</section>

	
	<section id="services" class="section-padding" style="padding:90px 0">
        <div class="container">
            <div class="section-header">
                <h2 class="section-title wow fadeInDown" data-wow-delay="0.3s"><i class="fa fa-shopping-cart" aria-hidden="true"></i>追蹤清單</h2>
                <div class="title wow fadeInDown" data-wow-delay="0.3s"></div>
            
            <div class="row trackingArea">
            		
            </div>
            <div align="center"><button class="btn btn-common" id="js-load-more" >載入更多</button></div>
        </div>
       </div>
    </section>
	
	<script>
		$(document).ready(function(){
			
			
			var counter = 0; /*計數器*/
			var pageStart = 0; /*offset*/
			var pageSize = 3; /*size*/
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
						
						
						result += 	`<div class="col-md-6 col-lg-4 col-xs-12">`;
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
											<input type ="hidden" name="courseno" 	 id="courseno"   value ="${courseVO.courseno}"/>
											<input type ="hidden" name="courseprice" id="courseprice" value ="${courseVO.courseprice}"/>
											<input type ="hidden" name="courseinfo"  id="courseinfo"  value ="${courseVO.courseinfo}"/>
										</i>&nbsp;加入購物車
									</label>`;
						result += `<h5>NT$` + JSONarray[i].courseprice + `</h5></div></div></div></div>`;
                
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