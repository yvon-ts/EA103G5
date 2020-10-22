<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> <%@ page import="java.util.*"%>
<%@ page import="com.course.model.*"%>
<%@ page import="com.video.model.*"%>

<!DOCTYPE html>
<html>

<head>
</head>

<body>
	
	<h2>課程單元編輯</h2>
	
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


	<!-- ========== JavaScript Area ========== -->
	<script>
		// 初始化
		$(function () {
			// 註冊 sortable 事件
			addSortableEvent()
			// 重新排序
			replaceTheChapterNumber();
			// 抓取初始的影片時間
			showInitOriginalVideoLen();
			// 抓取初始 FormData
			getFormDatas();
		});
	</script>
	
	<script type="text/javascript">
		function addSortableEvent() {
			// 註冊 sortable 事件，以及其 callback function
			// 使用 github 上的 sortable api，
			$('.table-sortable tbody').sortable({
				handle: 'i', // 用 i tag 來 drag & drop
				items: ':not(.disabled)' // 用 .disabled class 禁止排序
			}).bind('sortupdate', replaceTheChapterNumber);
		}
	
		function replaceTheChapterNumber() {
			// 更新排序後的單元編號
			for (let i = 0; i < $("#videolist tr").length; i++) {
				$("#videolist tr:nth-child(" + (i + 1) + ") input[name='chapterno']").val(i + 1);
			}
			
			// 純 javascript 版本
			// let chapternos = document.querySelectorAll("#videolist .chapterno");
			// for (let i = 0; i < chapternos.length; i++) {
			//     chapternos[i].innerText = "單元" + (i + 1);
			// }
		}
	
		// 增加章節欄位，並設定其為 insert
		let addNumber = 1;
		$("#addNewChapter").click(function () {
			let newChapter = `<tr class="insertChapterTr">
											<form method="post" id="newFrom` + addNumber + `"></form>
											<td class="align-middle text-center"><i class="fas fa-bars"></i></td>
		                                    <td>
		                                        <p>單元：<input type="number" name="chapterno" value="" readonly form="newFrom` + addNumber + `"></p>
		                                        <p>範圍：<input type="number" name="testscope" value=0 min=1 max=10 step=1 form="newFrom` + addNumber + `"></p>
		                                    </td>
		                                    <td class="align-middle">
												<input type="text" name="chaptername" value="" size="20" form="newFrom` + addNumber + `">
		                                    </td>
											<td class="align-middle text-center">
												<i class="fas fa-video-slash"></i>
											</td>
											<td>
												<span>影片時間：</span><span class="showVideoLen">0</span>
												<input type="hidden" name="chapterlen" value=0 min=0 step=1 readonly form="newFrom` + addNumber + `">
												<br>
												<input type="file" name="video" form="newFrom` + addNumber + `">
											</td>
		                                    <input type="hidden" name="action" value="insert" form="newFrom` + addNumber + `">
										</tr>`;
			// 新增可以上傳課程的欄位
			// $("#videolist").append(newChapter);
			$("#videolist #chapterEditRow").before(newChapter);
			// 更新排序後的單元編號
			replaceTheChapterNumber();
			// 重新註冊 sortable 事件
			addSortableEvent()
			// 註冊自動抓取影片時間事件
			$("input[name=video]").change(setVideoDuration);
			// 取得課程單元之 FormDatas
			getFormDatas();
			addNumber++;
		});
	
		function getFormDatas() {
			let formDatas = [];
			// 取得課程單元之 FormDatas
			for (let i = 0; i < $("#videolist form").length; i++) {
				let formData = new FormData($("#videolist form")[i]);
				// 加入 courseno
				formData.append("courseno", "${courseVO.courseno}")
				// 存入 formDatas Array 內
				formDatas[i] = formData;
				// // ====== 測試用 ======
				// // 於 console 印出所有 key-value pair 
				// console.log("===== FormDate " + (i+1) + " =====")
				// for (let key of formData.keys()) {
				//     console.log(key + " : " + formData.get(key));
				// }
				// // ====== 測試用 ======
			}
			return formDatas;
		}
		// 將課程資訊寫入資料庫  // 拿宜靜的來改
		function ajax_updateVideo(formData) {
			// getFormDatas();
			
			//var count++;
			
			$.ajax({ // 存入資料庫階段
				url: "<%=request.getContextPath()%>/courseVideosServlet",
				type: "POST",
				data: formData,
				// 告訴jQuery不要去處理發送的資料
				processData: false,
				// 告訴jQuery不要去設定Content-Type請求頭
				contentType: false,
				success: function (data) { // 以上成功才執行
					console.log("*回傳內容： " + data);
					
					// count--;
				},
				error: function () {
					console.log("*真的不棒")
					
					//count--;
				}
			})
		}
	
		// 測試按鈕
		$("#test").click(function () {
			let formDatas = getFormDatas();
			for (let i = 0; i < formDatas.length; i++) {
				formData = formDatas[i];
				ajax_updateVideo(formData);
			}
			// to do: 還須使其 reload 或重新整理
		});
	</script>

</body>

</html>