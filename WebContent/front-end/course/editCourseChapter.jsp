<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> <%@ page import="java.util.*"%>
<%@ page import="com.course.model.*"%>
<%@ page import="com.video.model.*"%>

<!DOCTYPE html>
<html>

<head>
</head>

<body>
	<section>
		<table class="table table-hover table-sortable">
			<thead>
				<tr>
					<th scope="col"></th>
					<!-- <th scope="col" style="width: 150px;">#</th> -->
					<th scope="col">#</th>
					<th scope="col"> Chapter Title</th>
					<th scope="col" colspan="2">Video File</th>
					<!-- <th>編輯</th> -->
				</tr>
			</thead>
			<tbody id="videolist">
				<!-- 宣告複合查詢使用的 map -->
				<%
					Map<String, String[]> map = new TreeMap<String, String[]>();
					String courseno = ((CourseVO)request.getAttribute("courseVO")).getCourseno();
					map.put("courseno", new String[]{ courseno });
					request.setAttribute("map", map);
				%>
				${courseVO.courseno}
				<!-- 讀出課程現有的單元清單 -->
				<jsp:useBean id="videoSvc" scope="page" class="com.video.model.VideoService" />
				<c:forEach var="videoVO" items="${videoSvc.getAll(map)}" varStatus="status">
					<tr>
						<form method="post" id="origForm${status.count}">
							<td scope="row" class="align-middle text-center">
								<i class="fas fa-bars"></i>
							</td>
							<td>
								<p>單元：<input type="number" name="chapterno" value=${videoVO.chapterno} readonly form="origForm${status.count}"></p>
								<p>範圍：<input type="number" name="testscope" value=${videoVO.testscope} min=1 max=10 step=1 form="origForm${status.count}"></p>
							</td>
							<td class="align-middle">
								<!-- <p>單元名稱</p> -->
								<input type="text" name="chaptername" size="20" value=${videoVO.chaptername} form="origForm${status.count}">
							</td>
							<td class="align-middle text-center">
								<a href="<%=request.getContextPath()%>/video/VideoReaderFromDB?videono=${videoVO.videono}" target="_blank">
									<span class="far fa-play-circle"></span></a>
							</td>
							<td>
								<span>影片時間：</span><span class="showVideoLen"></span>
								<input type="hidden" name="chapterlen" value=${videoVO.chapterlen} min=0 step=1 readonly form="origForm${status.count}">
								<!-- <span> Secs</span> -->
								<br>
								<input type="file" name="video" form="origForm${status.count}">
							</td>
							<input type="hidden" name="videono" value=${videoVO.videono} form="origForm${status.count}">
							<input type="hidden" name="action" value="update" form="origForm${status.count}">
						</form>
					</tr>
				</c:forEach>
				<tr id="chapterEditRow" class="disabled text-center">
					<td colspan="4" class="text-center">
						<span id="addNewChapter" class="far fa-plus-square"></span>
					</td>
					<td class="text-center">
						<sapn id="test" class="fas fa-save"></span>
					</td>
				</tr>
			</tbody>
		</table>
	</section>

</body>

</html>