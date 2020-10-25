<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> <%@ page import="java.util.*"%>
<%@ page import="com.course.model.*"%>
<%@ page import="com.video.model.*"%>

<!DOCTYPE html>
<html>

<head>
	<!-- This page's CSS -->
	<link rel="stylesheet" href="<%=request.getContextPath()%>/front-end/course/css/editCourseChapter.css">
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
					<th scope="col">Chapter Title</th>
					<th scope="col" colspan="2">Video File</th>
					<th scope="col" colspan="2">Action</th>
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
						<!-- 表單 #1 課程資訊 -->
						<form method="post" class="chapterInfo" id="chapterInfoForm${status.count}">
							<td scope="row" class="align-middle text-center">
								<i class="fas fa-bars"></i>
							</td>
							<td class="align-middle text-center">
								<h5><input type="number" name="chapterno" value=${videoVO.chapterno} readonly form="chapterInfoForm${status.count}"></h5>
								<%-- <p>範圍：<input type="number" name="testscope" value=${videoVO.testscope} min=1 max=10 step=1 form="chapterInfoForm${status.count}"></p> --%>
								<input type="hidden" name="testscope" value=${videoVO.testscope} form="chapterInfoForm${status.count}">
							</td>
							<td>
								<!-- <p>單元名稱</p> -->
								<input type="text" name="chaptername" class="form-control" style="margin:10px 0;"
									value=${videoVO.chaptername} form="chapterInfoForm${status.count}">
							</td>
							<input type="hidden" name="videono" value=${videoVO.videono} form="chapterInfoForm${status.count}">
							<input type="hidden" name="action" value="updateChapterInfo" form="chapterInfoForm${status.count}">
						</form>
						<!-- 表單 #1 課程資訊 -->

						<!-- 表單 #2 課程影片 -->
						<form method="post" class="videoFile" id="videoFileForm${status.count}">
							<td class="align-middle text-center">
								<a href="<%=request.getContextPath()%>/video/VideoReaderFromDB?videono=${videoVO.videono}" target="_blank">
									<span class="far fa-play-circle"></span></a>
							</td>
							<td>
								<span>影片時間：</span><span class="showVideoLen"></span>
								<input type="hidden" name="chapterlen" value=${videoVO.chapterlen} min=0 step=1 readonly form="videoFileForm${status.count}">
								<br>
								<input type="file" name="video" form="videoFileForm${status.count}">
								<input type="hidden" name="videono" value=${videoVO.videono} form="videoFileForm${status.count}">
								<input type="hidden" name="action" value="updateVideoFile" form="videoFileForm${status.count}">
							</td>
							<td class="align-middle text-center">
								<button type="button" class="btn btn-success updateButton"><i class="fas fa-file-upload"></i></button>
							</td>
						</form>
						<!-- 表單 #2 課程影片 -->
						<td class="align-middle text-center">
							<!-- 表單 #3 刪除按鈕 -->
							<form method="post" ACTION="<%=request.getContextPath()%>/video/video.do">
								<input type="hidden" name="videono" value=${videoVO.videono}>
								<input type="hidden" name="action" value="deleteVideo">
								<button type="button" class="btn btn-danger deleteButton"><i class="far fa-trash-alt"></i></button>
							</form>
							<!-- 表單 #3 刪除按鈕 -->
						</td>
					</tr>
				</c:forEach>
				<tr id="chapterEditRow" class="disabled text-center">
					<td colspan="5" class="text-center">
						<span id="addNewChapter" class="far fa-plus-square"></span>
					</td>
					<td colspan="2" class="text-center">
						<sapn id="updateAllChaptersInfo" class="fas fa-save"></span>
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
			// 註冊刪除按鈕
			addDeleteEvent()
		});
	</script>


	<!-- ==================== 文件元件相關：排序、新增 ==================== -->
	<script type="text/javascript">
		function addSortableEvent() {
			// 註冊 sortable 事件，以及其 callback function
			// 使用 github 上的 sortable api，
			$('.table-sortable tbody').sortable({
				handle: 'i', // 用 i tag 來 drag & drop
				items: ':not(.disabled)' // 用 .disabled class 禁止排序
			}).bind('sortupdate', replaceTheChapterNumber);
		}

		// 更新排序後的單元編號
		function replaceTheChapterNumber() {
			// 更新排序後的單元編號
			for (let i = 0; i < $("#videolist tr").length; i++) {
				$("#videolist tr:nth-child(" + (i + 1) + ") input[name='chapterno']").val(i + 1);
			}
		}

		// 增加章節欄位，並設定其為 insert
		var addNumber = 0;
		var alreadyAddOneClass = false;
		$("#addNewChapter").click(function () {
			if (!alreadyAddOneClass) {
				alreadyAddOneClass = true;
				var newChapterStr = `<tr class="insertChapterTr">
										<!-- 表單 #1 課程資訊 -->
										<form method="post" class="newChapterForm" id="newChapterForm` + addNumber + `">
											<td scope="row" class="align-middle text-center">
												<i class="fas fa-bars"></i>
											</td>
											<td class="align-middle text-center">
												<h5><input type="number" name="chapterno" value="" readonly form="newChapterForm` + addNumber + `"></h5>
												<input type="hidden" name="testscope" value=1 form="newChapterForm` + addNumber + `">
											</td>
											<td>
												<!-- <p>單元名稱</p> -->
												<input type="text" name="chaptername" class="form-control" style="margin:10px 0;"
													value="新單元" form="newChapterForm` + addNumber + `">
											</td>
										<!-- 表單 #1 課程資訊 -->
										<!-- 表單 #2 課程影片 -->
											<td class="align-middle text-center">
													<i class="fas fa-video-slash"></i>
											</td>
											<td>
												<span>影片時間：</span><span class="showVideoLen"> 0 : 00</span>
												<input type="hidden" name="chapterlen" value=0 min=0 step=1 readonly form="newChapterForm` + addNumber + `">
												<br>
												<input type="file" name="video" form="newChapterForm` + addNumber + `">
												<input type="hidden" name="action" value="addNewChapter" form="newChapterForm` + addNumber + `">
											</td>
											<td class="align-middle text-center">
												<button type="button" class="btn btn-success addNewButton"><i class="fas fa-sign-in-alt"></i></i></button>
											</td>
										</form>
										<!-- 表單 #2 課程影片 -->
										<td class="align-middle text-center">
											<!-- 表單 #3 刪除按鈕 -->
											<form method="post" ACTION="<%=request.getContextPath()%>/video/video.do">
												<input type="hidden" name="videono" value=${videoVO.videono}>
												<input type="hidden" name="action" value="deleteVideo">
												<button type="button" class="btn btn-danger deleteButton" new=true><i class="far fa-trash-alt"></i></button>
											</form>
											<!-- 表單 #3 刪除按鈕 -->
										</td>
									</tr>`;

				// 新增可以上傳課程的欄位
				// $("#videolist").append(newChapter);
				$("#videolist #chapterEditRow").before(newChapterStr);
				// 更新排序後的單元編號
				replaceTheChapterNumber();
				// 重新註冊 sortable 事件
				addSortableEvent();
				// 註冊自動抓取影片時間事件
				$("input[name=video]").change(setVideoDuration);
				// 取得課程單元之 FormDatas
				getFormDatas();
				addNumber++;

				// 註冊新增按鈕
				addAddNewEvent();
				// 註冊刪除按鈕
				addDeleteEvent();
			}
		});
	</script>


	<!-- ==================== 資料讀寫相關 ==================== -->
	<script type="text/javascript">
		// // 測試用：於 console 印出所有 key-value pair 
		// console.log("===== FormDate " + (i+1) + " =====")
		// for (let key of formData.keys()) {
		//     console.log(key + " : " + formData.get(key));
		// }

		// 更新該課程內所有單元的基本資訊
		$("#updateAllChaptersInfo").click(function () {
			updateAllChaptersInfo();
		});

		// 更新該課程內所有單元的基本資訊
		function updateAllChaptersInfo() {
			let formDatas = getFormDatas();
			for (let i = 0; i < formDatas.length; i++) {
				formData = formDatas[i];
				updateOneChapterInfo(formData);
			}
			// 重新整理寫在 updateCourseInfo() 的 complete
			updateCourseInfo();
		}

		// 取得該課程內所有單元的基本資訊
		function getFormDatas() {
			let formDatas = [];
			// 取得課程單元之 FormDatas
			for (let i = 0; i < $("#videolist .chapterInfo").length; i++) {
				let formData = new FormData($("#videolist .chapterInfo")[i]);
				// 加入 courseno
				formData.append("courseno", "${courseVO.courseno}")
				// 存入 formDatas Array 內
				formDatas[i] = formData;
			}
			return formDatas;
		}

		// 更新單一單元的基本資訊  <= 拿宜靜的來改
		function updateOneChapterInfo(formData) {
			// getFormDatas();
			//var count++;
			$.ajax({ // 存入資料庫階段
				url: "<%=request.getContextPath()%>/video/videoAjax.do",
				type: "POST",
				data: formData,
				// 告訴jQuery不要去處理發送的資料
				processData: false,
				// 告訴jQuery不要去設定Content-Type請求頭
				contentType: false,
				//async: false, //****
				success: function (data) { // 以上成功才執行
					console.log("*回傳內容： " + data);
					// count--;
				},
				error: function (data) {
					console.log("*真的不棒" + data)
					//count--;
				}
			})
		}

		// 新增課程單元(包含影片上傳)
		var addNewIsWorking;

		function addAddNewEvent() {
			$(".addNewButton").click(function (e) {
				if (addNewIsWorking === undefined) {
					addNewIsWorking = false;
				}

				e.preventDefault();
				var formData = new FormData($(this).parents("tr").children(".newChapterForm")[0]);
				formData.append("courseno", "${courseVO.courseno}")

				if (!addNewIsWorking) {
					addNewIsWorking = true;

					$.ajax({
						url: "<%=request.getContextPath()%>/video/videoAjax.do",
						type: "POST",
						data: formData,
						// 告訴jQuery不要去處理發送的資料
						processData: false,
						// 告訴jQuery不要去設定Content-Type請求頭
						contentType: false,
						success: function (data) { // 以上成功才執行
							alert(data);
							if (data.indexOf('成功') > -1) {
								updateAllChaptersInfo();
							}
						},
						error: function (data) {
							alert(data);
						},
						complete: function () {
							addNewIsWorking = false;
						}
					})
				}
			});
		}

		// 上傳單一單元的影片
		$(".updateButton").click(function (e) {
			e.preventDefault();
			var formData = new FormData($(this).parents("tr").children(".videoFile")[0]);

			$.ajax({
				url: "<%=request.getContextPath()%>/video/videoAjax.do",
				type: "POST",
				data: formData,
				// 告訴jQuery不要去處理發送的資料
				processData: false,
				// 告訴jQuery不要去設定Content-Type請求頭
				contentType: false,
				success: function (data) { // 以上成功才執行
					alert(data);
					updateAllChaptersInfo();
				},
				error: function (data) {
					alert(data);
				}
			})
		});

		function addDeleteEvent() {
			// 刪除單一單元，包含 DB 內資料
			$(".deleteButton").unbind().click(function (e) {
				// 加上 unbind()，可以清除先前的事件，避免重複註冊
				e.preventDefault();
				if (confirm("\n確認刪除後，將無法回復資料\n且不建議刪除以開使販售之課程\n避免影響學生權益\n\n請問是否要刪除本單元？")) {
					if ($(this).attr("new") === "true") {
						alreadyAddOneClass = false;
					}

					var formData = new FormData($(this).parent()[0]);

					$.ajax({
						url: "<%=request.getContextPath()%>/video/videoAjax.do",
						type: "POST",
						data: formData,
						// 告訴jQuery不要去處理發送的資料
						processData: false,
						// 告訴jQuery不要去設定Content-Type請求頭
						contentType: false,
						success: function (data) { // 以上成功才執行
							alert(data);
							console.log("* Video 刪除成功");
						},
						error: function (data) {
							alert(data)
							console.log("* Video 刪除失敗");
						}
					})

					$(this).parents("tr").remove(); // 感謝靜神
					replaceTheChapterNumber();
				} else {
					e.preventDefault();
				}
			});
		}
	</script>
</body>

</html>