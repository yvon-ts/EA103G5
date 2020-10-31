package com.course.controller;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.course.model.*;
import com.video.model.*;

@MultipartConfig
public class CourseServlet extends HttpServlet {

	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");
		res.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		
		if ("showCourseMainPage".equals(action)) {// 取得特定物件

			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
				String courseno = req.getParameter("courseno");

				// 檢查空字串或空白的錯誤
				if (courseno == null || courseno.trim().length() == 0) {
					errorMsgs.add("請輸入課程編號");
				}
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/front-end/course/select_page.jsp");
					failureView.forward(req, res);
					return; // 中斷程式
				}

				// 檢查流水碼編號格式
				String coursenoRegex = "^COUR[0-9]{4}$";
				if (!courseno.matches(coursenoRegex)) {
					errorMsgs.add("教室編號格式不正確");
				}
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/front-end/course/select_page.jsp");
					failureView.forward(req, res);
					return; // 中斷程式
				}

				/*************************** 2.開始查詢資料 *****************************************/
				CourseService courseSvc = new CourseService();
				CourseVO courseVO = courseSvc.getOneCourse(courseno);

				if (courseVO == null) {
					errorMsgs.add("查無資料");
				}
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/front-end/course/select_page.jsp");
					failureView.forward(req, res);
					return; // 中斷程式
				}

				/*************************** 3.查詢完成,準備轉交(Send the Success view) *************/
				req.setAttribute("courseVO", courseVO);
				// String url = "/front-end/course/listOneCourse.jsp";
				String url = "/front-end/course/mainCoursePage.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料: " + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/front-end/course/select_page.jsp");
				failureView.forward(req, res);
			}
		}
		
		
		// =====================================================================================================
		

		if ("getOneCourseForUpdate".equals(action)) {

			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 ****************************************/
				String courseno = req.getParameter("courseno");
				
				/*************************** 2.開始查詢資料 ****************************************/
				CourseService courseSvc = new CourseService();
				CourseVO courseVO = courseSvc.getOneCourse(courseno);

				/*************************** 3.查詢完成,準備轉交(Send the Success view) ************/
				req.setAttribute("courseVO", courseVO);
				String url = "/front-end/course/editCourse.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得要修改的資料" + e.getMessage());
				// 應該要到該老師自己的課程頁面
				RequestDispatcher failureView = req.getRequestDispatcher("/front-end/course/listAllCourse.jsp");
				failureView.forward(req, res);
				return;
			}
		}

		// =====================================================================================================
		
		if ("update".equals(action)) {

			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*********************** 1.接收請求參數 - 輸入格式的錯誤處理 *************************/
				String courseno = req.getParameter("courseno");
				
				// 課程類別
				String cstypeno = req.getParameter("cstypeno");
				System.out.println(cstypeno);
				if (cstypeno == null || cstypeno.trim().length() == 0) {
					cstypeno = "";
					errorMsgs.add("請選擇課程類別");
				}

				// 開課教師 NGNGNGNGNGNGNGNGNGNGNGNGNGNGNGNGNGNGNGNGNGNGNGNGNG
				String tchrno = req.getParameter("tchrno");
				
				// 課程名稱 NGNGNGNGNGNGNGNGNGNGNGNGNGNGNGNGNGNGNGNGNGNGNGNGNG
				String coursename = req.getParameter("coursename");
				String coursenameRegex = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{2,15}$";
				if (coursename == null || coursename.trim().length() == 0) {
					coursename = "";
					errorMsgs.add("課程名稱請勿空白");
				} else if (!coursename.trim().matches(coursenameRegex)) {
					errorMsgs.add("課程名稱: 只能是中、英文字母、數字和_ , 且長度必需在2到15之間");
				}
				
				// 課程資訊 NGNGNGNGNGNGNGNGNGNGNGNGNGNGNGNGNGNGNGNGNGNGNGNGNG
				String courseinfo = req.getParameter("courseinfo");

				// 課程單價
				Integer courseprice = null;
				try {
					courseprice = Integer.valueOf(req.getParameter("courseprice"));
					if (courseprice <= 0) {
						errorMsgs.add("課程單價請輸入大於零的整數");
					}
					if (courseprice > 999999) {
						errorMsgs.add("課程單價請小於一百萬");
					}
				} catch (NumberFormatException e) {
					courseprice = 0;
					errorMsgs.add("課程單價請輸入數字");
				}

				// ============================================================
				// 課程總時數 (自動抓取)
				Integer ttltime = 0;
				Map<String, String[]> map = new TreeMap<String, String[]>();
				map.put("courseno", new String[] { courseno });
				VideoService videoSvc = new VideoService();
				List<VideoVO> videoList = videoSvc.getAll(map);
				for (VideoVO videoVO : videoList) {
					ttltime += videoVO.getChapterlen();
				}
				
				// 課程狀態
				String csstatus = req.getParameter("csstatus");
				// 課程總評分
				Integer csscore = null;
				try {
					csscore = Integer.valueOf(req.getParameter("csscore"));
					if (csscore < 0) {
						errorMsgs.add("累積總評分數不可小於零");
					}
				} catch (NumberFormatException e) {
					csscore = 0;
					errorMsgs.add("累積總評分數請輸入數字");
				}
				// 評分次數
				Integer csscoretimes = null;
				try {
					csscoretimes = Integer.valueOf(req.getParameter("csscoretimes"));
					if (csscoretimes < 0) {
						errorMsgs.add("評分次數請不可小於零");
					}
				} catch (NumberFormatException e) {
					csscoretimes = 0;
					errorMsgs.add("評分次數請輸入數字");
				}
				// ============================================================
				
				
				// 上傳課程圖片
				byte[] courseimg = null;
				Part part = req.getPart("courseimg");
				
				if (part.getSize() == 0) {
					System.out.println("***沒上傳檔案***");
					// errorMsgs.add("請上傳課程圖片");
				} else if (part.getContentType().indexOf("image") < 0) {
					errorMsgs.add("僅可以上傳圖片類型之檔案");
				} else {
					InputStream in = part.getInputStream();
					courseimg = getUpdateFileByteArray(in);
				}
				
				// ========== 測試用印出程式碼 ==========
				// System.out.println("===== PART: " + courseimg + " =====");
				System.out.println("**SubmittedFileName = " + part.getSubmittedFileName());
				System.out.println("**ContentType = " + part.getContentType());
				System.out.println("**Size = " + part.getSize());
				// ========== 測試用印出程式碼 ==========

				CourseVO courseVO = new CourseVO();
				courseVO.setCourseno(courseno);
				courseVO.setCstypeno(cstypeno);
				courseVO.setTchrno(tchrno);
				courseVO.setCoursename(coursename);
				courseVO.setCourseinfo(courseinfo);
				courseVO.setCourseprice(courseprice);
				courseVO.setTtltime(ttltime);
				courseVO.setCsstatus(csstatus);
				courseVO.setCsscore(csscore);
				courseVO.setCsscoretimes(csscoretimes);
//				courseVO.setCourseimg(courseimg);	// 不用 hold 上傳檔案的資料

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("courseVO", courseVO);
					RequestDispatcher failureView = req.getRequestDispatcher("/front-end/course/editCourse.jsp");
					failureView.forward(req, res);
					return;
				}
				/*************************** 2.開始新增資料 ***************************************/
				CourseService courseSvc = new CourseService();
				if (part.getSize() == 0) {
					courseVO = courseSvc.updateCourse(courseno, cstypeno, tchrno, coursename, courseinfo, courseprice,
							ttltime, csstatus, csscore, csscoretimes);
				} else {
					courseVO = courseSvc.updateCourse(courseno, cstypeno, tchrno, coursename, courseinfo, courseprice,
							ttltime, csstatus, csscore, csscoretimes, courseimg);
				}
				
				courseVO = courseSvc.getOneCourse(courseno);
				/*************************** 3.新增完成,準備轉交(Send the Success view) ***********/
				req.setAttribute("courseVO", courseVO);
				String url = "/front-end/course/editCourse.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);
				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add("無法更新課程:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/front-end/course/editCourse.jsp");
				failureView.forward(req, res);
			}
		}
		
		// =====================================================================================================

		
		//改用下方 create
		
//		if ("insert".equals(action)) {// 新增課程
//
//			List<String> errorMsgs = new LinkedList<String>();
//			req.setAttribute("errorMsgs", errorMsgs);
//
//			try {
//				/*********************** 1.接收請求參數 - 輸入格式的錯誤處理 *************************/
//				String tchrno = req.getParameter("tchrno");
//				
//				String cstypeno = req.getParameter("cstypeno");
//				System.out.println(cstypeno);
//				if (cstypeno == null || cstypeno.trim().length() == 0) {
//					cstypeno = "";
//					errorMsgs.add("請選擇課程類別");
//				}
//
//				String coursename = req.getParameter("coursename");
//				String coursenameRegex = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{2,10}$";
//				if (coursename == null || coursename.trim().length() == 0) {
//					coursename = "";
//					errorMsgs.add("課程名稱請勿空白");
//				} else if (!coursename.trim().matches(coursenameRegex)) {
//					errorMsgs.add("課程名稱: 只能是中、英文字母、數字和_ , 且長度必需在2到10之間");
//				}
//
//				String courseinfo = req.getParameter("courseinfo");
//
//				Integer courseprice = null;
//				try {
//					courseprice = Integer.valueOf(req.getParameter("courseprice"));
//					if (courseprice <= 0) {
//						errorMsgs.add("課程單價請輸入大於零的整數");
//					}
//				} catch (NumberFormatException e) {
//					courseprice = 0;
//					errorMsgs.add("課程單價請輸入數字");
//				}
//
//				Integer ttltime = null;
//				// 應該要自己抓影片的長度
//				try {
//					ttltime = Integer.valueOf(req.getParameter("ttltime"));
//					if (ttltime < 0) {
//						errorMsgs.add("課程總時數不可小於零");
//					}
//				} catch (NumberFormatException e) {
//					ttltime = 0;
//					errorMsgs.add("課程總時數請輸入數字");
//				}
//
//				String csstatus = req.getParameter("csstatus");// ?
//
//				Integer csscore = null;
//				try {
//					csscore = Integer.valueOf(req.getParameter("csscore"));
//					if (csscore < 0) {
//						errorMsgs.add("累積總評分數不可小於零");
//					}
//				} catch (NumberFormatException e) {
//					csscore = 0;
//					errorMsgs.add("累積總評分數請輸入數字");
//				}
//
//				// 評分次數???
//
//				Integer csscoretimes = null;
//				try {
//					csscoretimes = Integer.valueOf(req.getParameter("csscoretimes"));
//					if (csscoretimes < 0) {
//						errorMsgs.add("評分次數不可小於零");
//					}
//				} catch (NumberFormatException e) {
//					csscoretimes = 0;
//					errorMsgs.add("評分次數請輸入數字");
//				}
//
//				byte[] courseimg = null;
//				Part part = req.getPart("courseimg");
//
////				System.out.println("===== PART: " + courseimg + " =====");
//				System.out.println("**SubmittedFileName = " + part.getSubmittedFileName());
//				System.out.println("**ContentType = " + part.getContentType());
//				System.out.println("**Size = " + part.getSize());
//
//				if (part.getSize() == 0) {
//					errorMsgs.add("請上傳課程圖片");
//				} else if (part.getContentType().indexOf("image") < 0) {
//					errorMsgs.add("僅可以上傳圖片檔案");
//				} else {
//					InputStream in = part.getInputStream();
//					courseimg = getUpdateFileByteArray(in);
////					System.out.println(courseimg.length);
////					in.close();
//				}
//
//				CourseVO courseVO = new CourseVO();
//				courseVO.setCstypeno(cstypeno);
//				courseVO.setTchrno(tchrno);
//				courseVO.setCoursename(coursename);
//				courseVO.setCourseinfo(courseinfo);
//				courseVO.setCourseprice(courseprice);
//				courseVO.setTtltime(ttltime);
//				courseVO.setCsstatus(csstatus);
//				courseVO.setCsscore(csscore);
//				courseVO.setCsscoretimes(csscoretimes);
//				courseVO.setCourseimg(courseimg);
//
//				// Send the use back to the form, if there were errors
//				if (!errorMsgs.isEmpty()) {
//					req.setAttribute("courseVO", courseVO); // 含有輸入格式錯誤的empVO物件,也存入req
//					RequestDispatcher failureView = req.getRequestDispatcher("/front-end/course/addCourse2.jsp");
//					failureView.forward(req, res);
//					return;
//				}
//				/*************************** 2.開始新增資料 ***************************************/
//				CourseService courseSvc = new CourseService();
//				//要用自增主鍵方法再取一次，才能做到直接轉交 edit
//				String courseno = courseSvc.addCourse(cstypeno, tchrno, coursename, courseinfo, courseprice, ttltime, csstatus,	csscore, csscoretimes, courseimg);
//				courseVO = courseSvc.getOneCourse(courseno);
//				/*************************** 3.新增完成,準備轉交(Send the Success view) ***********/
////				String url = "/front-end/course/listAllCourse.jsp";
//				req.setAttribute("courseVO", courseVO);
//				String url = "/front-end/course/editCourse.jsp";
//				RequestDispatcher successView = req.getRequestDispatcher(url);
//				successView.forward(req, res);
//
//				/*************************** 其他可能的錯誤處理 **********************************/
//			} catch (Exception e) {
//				errorMsgs.add("無法新增資料:" + e.getMessage());
//				RequestDispatcher failureView = req.getRequestDispatcher("/front-end/course/addCourse2.jsp");
//				failureView.forward(req, res);
//			}
//		}
		
		
		
		
		if ("create".equals(action)) {
			// 2020/10/22 新版本上架課程

			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*********************** 1.接收請求參數 - 輸入格式的錯誤處理 *************************/
				
				// 課程類別
				String cstypeno = req.getParameter("cstypeno");
				System.out.println(cstypeno);
				if (cstypeno == null || cstypeno.trim().length() == 0) {
					cstypeno = "";
					errorMsgs.add("請選擇課程類別");
				}

				// 開課教師 NGNGNGNGNGNGNGNGNGNGNGNGNGNGNGNGNGNGNGNGNGNGNGNGNG
				String tchrno = req.getParameter("tchrno");
				
				// 課程名稱 NGNGNGNGNGNGNGNGNGNGNGNGNGNGNGNGNGNGNGNGNGNGNGNGNG
				String coursename = req.getParameter("coursename");
				String coursenameRegex = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{2,15}$";
				if (coursename == null || coursename.trim().length() == 0) {
					coursename = "";
					errorMsgs.add("課程名稱請勿空白");
				} else if (!coursename.trim().matches(coursenameRegex)) {
					errorMsgs.add("課程名稱: 只能是中、英文字母、數字和_ , 且長度必需在2到15之間");
				}
				
				// 課程資訊 NGNGNGNGNGNGNGNGNGNGNGNGNGNGNGNGNGNGNGNGNGNGNGNGNG
				String courseinfo = req.getParameter("courseinfo");

				// 課程單價
				Integer courseprice = null;
				try {
					courseprice = Integer.valueOf(req.getParameter("courseprice"));
					if (courseprice <= 0) {
						errorMsgs.add("課程單價請輸入大於零的整數");
					}
					if (courseprice > 999999) {
						errorMsgs.add("課程單價請小於一百萬");
					}
				} catch (NumberFormatException e) {
					courseprice = 0;
					errorMsgs.add("課程單價請輸入數字");
				}

				// ========== 初次申請課程的初始值區域 ==========
				// 課程總時數
				Integer ttltime = 0;
				// 課程狀態
				String csstatus = "審核中";
				// 課程總評分
				Integer csscore = 0;
				// 評分次數
				Integer csscoretimes = 0;
				// ========== 初次申請課程的初始值區域 ==========

				// 上傳課程圖片
				byte[] courseimg = null;
				Part part = req.getPart("courseimg");

				if (part.getSize() == 0) {
					//System.out.println("***沒上傳檔案***");
				} else if (part.getContentType().indexOf("image") < 0) {
					errorMsgs.add("僅可以上傳圖片類型之檔案");
				} else {
					InputStream in = part.getInputStream();
					courseimg = getUpdateFileByteArray(in);
				}
				
//				// ========== 測試用印出程式碼 ==========
//				// System.out.println("===== PART: " + courseimg + " =====");
//				System.out.println("**SubmittedFileName = " + part.getSubmittedFileName());
//				System.out.println("**ContentType = " + part.getContentType());
//				System.out.println("**Size = " + part.getSize());
//				// ========== 測試用印出程式碼 ==========

				CourseVO courseVO = new CourseVO();
				courseVO.setCstypeno(cstypeno);
				courseVO.setTchrno(tchrno);
				courseVO.setCoursename(coursename);
				courseVO.setCourseinfo(courseinfo);
				courseVO.setCourseprice(courseprice);
				courseVO.setTtltime(ttltime);
				courseVO.setCsstatus(csstatus);
				courseVO.setCsscore(csscore);
				courseVO.setCsscoretimes(csscoretimes);
				courseVO.setCourseimg(courseimg);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("courseVO", courseVO);
					RequestDispatcher failureView = req.getRequestDispatcher("/front-end/course/addCourse.jsp");
					failureView.forward(req, res);
					return;
				}
				/*************************** 2.開始新增資料 ***************************************/
				CourseService courseSvc = new CourseService();
				// 新增後，再抓取自增PK，再進行轉交，才能拿到 PK 流水碼
				String courseno = courseSvc.addCourse(cstypeno, tchrno, coursename, courseinfo, courseprice, ttltime, csstatus,	csscore, csscoretimes, courseimg);
				
				/*************************** 3.新增完成,準備轉交(Send the Success view) ***********/
				courseVO = courseSvc.getOneCourse(courseno);
				req.setAttribute("courseVO", courseVO);
				
				String url = "/front-end/course/addCourseToEdit.jsp?";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);
				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add("無法新增資料:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/front-end/course/addCourse.jsp");
				failureView.forward(req, res);
			}
		}
	}

	public static byte[] getUpdateFileByteArray(InputStream in) throws IOException {
		byte[] buffer = new byte[in.available()];
		in.read(buffer);
		in.close();
		return buffer;
	}
}
