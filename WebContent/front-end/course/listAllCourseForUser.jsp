<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page
	import="com.course.model.*,com.course_type.model.*,com.members.model.*,com.tracking_list.model.*"%>

<%
	List<CourseVO> list = (List<CourseVO>) request.getAttribute("list");

	if (list == null) {
		CourseService cSvc = new CourseService();
		list = cSvc.getAllForUser();
	}

	pageContext.setAttribute("Courselist", list);

	List<Integer> averageScore = new ArrayList<>();
	for (CourseVO vo : list) {
		averageScore.add(vo.getCsscore() / vo.getCsscoretimes());
	}

	int i = 0;

	MembersVO Membersvo = (MembersVO) session.getAttribute("Membersvo");
	Membersvo = new MembersVO();
	Membersvo.setMemno("MEM0002");
	pageContext.setAttribute("Membersvo", Membersvo);

	// 	TrackingListService test = new TrackingListService();
	// 	List<TrackingListVO>  listall = test.getOneByMemno(Membersvo.getMemno());

	// 	for(TrackingListVO vo : listall){
	// 		System.out.println(vo);
	// 	}
	
	
	
%>

<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>所有課程列表 - listAllCourse.jsp</title>

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/jquery.rateit/1.1.3/rateit.css" />
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">


<style>
.rateit .rateit-preset {
	color: #FFCC36;
	background:
		url(https://cdnjs.cloudflare.com/ajax/libs/jquery.rateit/1.1.3/star.gif)
		left -32px !important;
}
</style>

</head>

<body>



	<!-- member -->
	<input type="hidden" id="memno" value="${Membersvo.memno}" />
	<jsp:useBean id="courseTypeSvc" scope="page"
		class="com.course_type.model.CourseTypeService" />
	<jsp:useBean id="TrackingListSvc" scope="page"
		class="com.tracking_list.model.TrackingListService" />



	<jsp:include page="/index/front-index/header.jsp" />

	<div id="hero-area" style="background-image: none">
		<div class="container">
			<div class="container">

				<div class="row">
					<div class="col-2">

						<label>課程名稱</label>

						<div>
							<input class="form-control" type="text"
								placeholder="&nbsp;&nbsp;今天想學什麼呢？" id="searchText">
						</div>

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
						<label>最低價格</label> <input class="form-control" type="number"
							size="5" min="0" name="minValue" id="min">
					</div>
					<div class="col-2">
						<label>最高價格</label> <input class="form-control" type="number"
							size="5" min="0" name="maxValue" id="max">
					</div>
					<div class="col-2">
						<label>排序</label> <select class="form-control" id="order">
							<option value="courlmod" seleted>最新</option>
							<option value="csscore">評價高&#x27A1;低</option>
							<option value="ttltime">課時高&#x27A1;低</option>
							<option value="courseprice">價格高&#x27A1;低</option>
							<option value="coursepriceLow">價格低&#x27A1;高</option>
						</select>
					</div>
					<div class="col-2">
						<label></label>
						<button type="button" class="btn btn-primary" id="turnin"
							style="display: block">送出查詢</button>
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
										<!-- 顯鈞：替換成新版本讀圖測試2020/10/22 -->
										<%-- <img src="<%=request.getContextPath()%>/course/coursephoto.do?action=searchPhoto&courseno=${courseVO.courseno}" style="width:200px;height:150px" class="pic"> --%>
										<img src="<%=request.getContextPath()%>/course/CoursePictureReaderFromDB?courseno=${courseVO.courseno}" style="width: 200px; height: 150px;" class="pic">
                        </div>
                        <div class="services-content">
                        	
                  
<!--                         	 -->
                        	&nbsp;&nbsp;&nbsp;<div class="rateit" data-rateit-value="${courseVO.csscore / courseVO.csscoretimes }" data-rateit-ispreset="true" data-rateit-readonly="true"></div> 
                        	<br>&nbsp;&nbsp;&nbsp;${courseVO.csscoretimes}則評價
                            <h3><a href="#">${courseVO.coursename}</a></h3>
                            <p>課程共${courseVO.ttltime}分鐘</p>
<!--                             <p>同學累計9487人</p> -->
							
							<label class="shoppingcart">
								<i class="fa fa-shopping-cart" aria-hidden="true">
									<input type ="hidden" name="courseno" 	 id="courseno"   value ="${courseVO.courseno}"/>
<%-- 									<input type ="hidden" name="courseprice" id="courseprice" value ="${courseVO.courseprice}"/> --%>
<%-- 									<input type ="hidden" name="courseinfo"  id="courseinfo"  value ="${courseVO.courseinfo}"/> --%>
								</i>&nbsp;加入購物車
							</label>
							
							
							
							<c:forEach var="TrackingListVO" items="${TrackingListSvc.getOneByMemno(Membersvo.memno)}">
								<c:choose>
									<c:when test="${ courseVO.courseno eq TrackingListVO.courseno}">
										<label class="bookmark"><i class="fa fa-heart" aria-hidden="true" style="color:red">
											<input type ="hidden"  id="courseno" value ="${courseVO.courseno}"/>
										</i>&nbsp;加入追蹤</label>
										<c:set var="flag" value="true"/>
									</c:when>
								</c:choose>
							</c:forEach>
							
							<c:if test="${empty flag}">
								<label class="bookmark"><i class="fa fa-heart-o" aria-hidden="true" style="color:red">
									<input type ="hidden"  id="courseno" value ="${courseVO.courseno}"/>
								</i>&nbsp;加入追蹤</label>
							</c:if>
							<c:remove var="flag"/>
								
                           <h5>NT$${courseVO.courseprice}</h5>
                        	
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
			$.ajax({
				url	:"<%=request.getContextPath()%>/tracking_list/tracking_list.do",
				data:{
					courseno:$(this).find('#courseno').val(),
					memno    : $("#memno").val(),
					action: "shoppingCart"
				},
				success: function(data){
					console.log(data);
				}
			});
		});
		
		
		$('.bookmark').click(function(){
			
			var updateTrackingList;
			
			if ($(this).children().attr("class") === "fa fa-heart-o"){
				updateTrackingList = "insert";
				$(this).children().attr("class","fa fa-heart");
			}
			else{
				updateTrackingList = "delete";
				$(this).children().attr("class","fa fa-heart-o");
			}
			
			console.log(updateTrackingList + "," + $(this).find('#courseno').val() );
			
			$.ajax({
				url	:"<%=request.getContextPath()%>/tracking_list/tracking_list.do", 
				data:{
					courseno : $(this).find('#courseno').val(),
					memno    : $("#memno").val(),
					action   : updateTrackingList ,
				},
				success: function(data){
					console.log('操作成功');
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
					console.log(data);
					var JSONarray = JSON.parse(data);
					$(".seacharea").empty();
					
					var str = "";
					for(let i = 0 ; i < JSONarray.length ; i++){
						
<%-- 						var courseimgno = "<%=request.getContextPath()%>/course/coursephoto.do?action=searchPhoto&courseno=" + JSONarray[i].courseno; --%>
						
					
						
// 						str +=  `<div class="col-md-6 col-lg-3 col-xs-12">
// 		                    <div class="services-item wow fadeInRight" data-wow-delay="0.3s">
// 		                        <div class="icon">
// 		                            <img src=  "` +  courseimgno    + `"style="width:200px;height:150px">
// 		                        </div>
// 		                        <div class="services-content">`;
		                
						// 顯鈞：替換成新版本讀圖測試2020/10/22
		                var pictureURL = "<%=request.getContextPath()%>/course/CoursePictureReaderFromDB?courseno=" + JSONarray[i].courseno;
		                    
		                
		                str +=  `<div class="col-md-6 col-lg-3 col-xs-12">
			                <div class="services-item wow fadeInRight" data-wow-delay="0.3s">
			                    <div class="icon">
			                        <img src=  "` + pictureURL + `"style="width:200px;height:150px">
			                    </div>
			                   <div class="services-content">`;
						str += `&nbsp;&nbsp;
								<div class="rateit" data-rateit-value="` + JSONarray[i].csscore / JSONarray[i].csscoretimes + `" data-rateit-ispreset="true" data-rateit-readonly="true">
								</div><br>`;
		                str += `&nbsp;&nbsp;&nbsp;` + JSONarray[i].csscoretimes + `則評價
		                        <h3><a href="#">` + JSONarray[i].coursename + `</a></h3>
		                            <p>課程共`+JSONarray[i].ttltime+`分鐘</p>
		<!--                             <p>同學累計9487人</p> -->
									<label class="shoppingcart"><i class="fa fa-shopping-cart" aria-hidden="true"></i>&nbsp;加入購物車</label>`;
									
									
										 str +=	`<label class="bookmark"><i class="fa fa-heart-o" aria-hidden="true" style="color:red"></i>&nbsp;加入追蹤</label>
									<h5>NT$` + JSONarray[i].courseprice + `</h5>
		                        </div>
		                    </div>
		                </div>`;
					}
					
					$(".seacharea").append(str);
					$("div.rateit, span.rateit").rateit()
					
					
					
				}
			});
		});
		
	});
</script>

	<jsp:include page="/index/front-index/footer.jsp" />
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.rateit/1.1.3/jquery.rateit.min.js"></script>
</body>
</html>