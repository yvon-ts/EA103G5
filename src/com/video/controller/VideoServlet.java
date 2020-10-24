package com.video.controller;

import java.io.*;
import java.util.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.course.model.CourseService;
import com.course.model.CourseVO;
import com.video.model.VideoService;
import com.video.model.VideoVO;

//@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 5 * 1024 * 1024, maxRequestSize = 5 * 50 * 1024 * 1024)
@MultipartConfig
//當數據量大於fileSizeThreshold值時，內容將被寫入磁碟
//上傳過程中無論是單個文件超過maxFileSize值，或者上傳的總量大於maxRequestSize 值都會拋出IllegalStateException 異常

public class VideoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		System.out.println("***action = " + action);

		if ("getOne_For_Display".equals(action)) {

			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
				String videono = req.getParameter("videono");

				// 檢查空字串或空白
				if (videono == null || videono.trim().length() == 0) {
					errorMsgs.add("請輸入影片編號");
				}

				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/video/select_page.jsp");
					failureView.forward(req, res);
					return; // 中斷程式
				}

				// 檢查流水碼編號格式
				String videonoRegex = "^VID[0-9]{4}$";
				if (!videono.matches(videonoRegex)) {
					errorMsgs.add("影片編號格式不正確");
				}
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/video/select_page.jsp");
					failureView.forward(req, res);
					return; // 中斷程式
				}

				/*************************** 2.開始查詢資料 *****************************************/
				VideoService videoSvc = new VideoService();
				VideoVO videoVO = videoSvc.getOneVideo(videono);

				if (videoVO == null) {
					errorMsgs.add("查無資料");
				}

				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/video/select_page.jsp");
					failureView.forward(req, res);
					return; // 中斷程式
				}

				/*************************** 3.查詢完成,準備轉交(Send the Success view) *************/
				req.setAttribute("videoVO", videoVO);

				String url = "/back-end/video/listOneVideo.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料: " + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/video/select_page.jsp");
				failureView.forward(req, res);
			}
		}

		if ("getOne_For_Update".equals(action)) {

			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
				String videono = req.getParameter("videono");

				/*************************** 2.開始查詢資料 *****************************************/
				VideoService videoSvc = new VideoService();
				VideoVO videoVO = videoSvc.getOneVideo(videono);

				/*************************** 3.查詢完成,準備轉交(Send the Success view) *************/
				req.setAttribute("videoVO", videoVO);
				String url = "/back-end/video/update_video_input.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);
				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得要修改資料: " + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/video/listAllVideo.jsp");
				failureView.forward(req, res);
			}
		}
		
		
		
		
		

		// 未完成，目前是 insert 版本
		if ("update".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
				String videono = req.getParameter("videono");
				String courseno = req.getParameter("courseno");
				
				System.out.println(videono);
				System.out.println(courseno);

				Integer testscope = null;
				try {
					testscope = Integer.valueOf(req.getParameter("testscope"));
					if (testscope <= 0) {
						errorMsgs.add("範圍編號請輸入大於零的整數");
					}
				} catch (NumberFormatException e) {
					testscope = 0;
					errorMsgs.add("範圍編號請輸入數字");
				}

				Integer chapterno = null;
				// 尚未處理：同課程中，單元編號不得重複
				try {
					chapterno = Integer.valueOf(req.getParameter("chapterno"));
					if (chapterno <= 0) {
						errorMsgs.add("單元編號請輸入大於零的整數");
					}
				} catch (NumberFormatException e) {
					chapterno = 0;
					errorMsgs.add("單元編號請輸入數字");
				}

				String chaptername = req.getParameter("chaptername");
				String chapternameRegex = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_.)]{2,50}$";
				if (chaptername == null || chaptername.trim().length() == 0) {
					chaptername = "";
					errorMsgs.add("單元名稱請勿空白");
				} else if (!chaptername.trim().matches(chapternameRegex)) { // 以下練習正則(規)表示式(regular-expression)
					errorMsgs.add("單元名稱: 只能是中、英文字母、數字和_ , 且長度必需在2到50之間");
				}

				Integer chapterlen = null;
				// 應該要自己抓影片的長度
				try {
					chapterlen = Integer.valueOf(req.getParameter("chapterlen"));
					if (chapterlen <= 0) {
						errorMsgs.add("單元長度請輸入大於零的整數");
					}
				} catch (NumberFormatException e) {
					chapterlen = 0;
					errorMsgs.add("單元長度請輸入數字");
				}

				byte[] video = null;
				Part part = req.getPart("video");
				System.out.println(part);

				System.out.println("**Name = " + part.getName());
				System.out.println("**SubmittedFileName = " + part.getSubmittedFileName());
				System.out.println("**ContentType = " + part.getContentType());
				System.out.println("**Size = " + part.getSize());

//				VideoService videoSvc = new VideoService();
				
				if (part.getSize() == 0) {
					System.out.println("***沒傳檔案***");
					errorMsgs.add("請上傳課程影片");
					// update 應該要保有原本的影片
					// 取 byte[] 方法失敗，無法直接取，下面那行還是 null
					// System.out.println("***byte[] = " + videoSvc.getOneVideo(videono).getVideo());
				} else if (part.getContentType().indexOf("video/mp4") < 0) {
					errorMsgs.add("僅可以上傳 mp4 影片檔案");
				} else {
					InputStream in = part.getInputStream();
					video = getUpdateFileByteArray(in);
					in.close();
					// 檔案格式錯誤？目前寫 mp4
					// 其他錯誤處理
				}

				VideoVO videoVO = new VideoVO();
				videoVO.setVideono(videono);
				videoVO.setCourseno(courseno);
				videoVO.setTestscope(testscope);
				videoVO.setChapterno(chapterno);
				videoVO.setChaptername(chaptername);
				videoVO.setChapterlen(chapterlen);
//				videoVO.setVideo(video); // 不用 hold 上傳檔案的資料

				if (!errorMsgs.isEmpty()) {
					req.setAttribute("videoVO", videoVO); // 含有輸入格式錯誤的empVO物件,也存入req
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/video/update_video_input.jsp");
					failureView.forward(req, res);
					return; // 中斷程式
				}

				/*************************** 2.開始新增資料 *****************************************/
				VideoService videoSvc = new VideoService();
				videoSvc.updateVideo(videono, courseno, testscope, chapterno, chaptername, chapterlen, video);
				videoVO = videoSvc.getOneVideo(videono);

//				if (!errorMsgs.isEmpty()) {
//					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/xxxxx/xxxpage.jsp");
//					failureView.forward(req, res);
//					return; // 中斷程式
//				}
				/*************************** 3.查詢完成,準備轉交(Send the Success view) *************/
				req.setAttribute("videoVO", videoVO);
				String url = "/back-end/video/listOneVideo.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);
				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.add("無法新增資料: " + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/video/update_video_input.jsp");
				failureView.forward(req, res);
			}
		}

		// 進行中
		if ("insert".equals(action)) {

			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
				String courseno = req.getParameter("courseno");

				Integer testscope = null;
				try {
					testscope = Integer.valueOf(req.getParameter("testscope"));
					if (testscope <= 0) {
						errorMsgs.add("範圍編號請輸入大於零的整數");
					}
				} catch (NumberFormatException e) {
					testscope = 0;
					errorMsgs.add("範圍編號請輸入數字");
				}

				Integer chapterno = null;
				// 尚未處理：同課程中，單元編號不得重複
				try {
					chapterno = Integer.valueOf(req.getParameter("chapterno"));
					if (chapterno <= 0) {
						errorMsgs.add("單元編號請輸入大於零的整數");
					}
				} catch (NumberFormatException e) {
					chapterno = 0;
					errorMsgs.add("單元編號請輸入數字");
				}

				String chaptername = req.getParameter("chaptername");
				String chapternameRegex = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_.)]{2,15}$";
				if (chaptername == null || chaptername.trim().length() == 0) {
					chaptername = "";
					errorMsgs.add("單元名稱請勿空白");
				} else if (!chaptername.trim().matches(chapternameRegex)) { // 以下練習正則(規)表示式(regular-expression)
					errorMsgs.add("單元名稱: 只能是中、英文字母、數字和_ , 且長度必需在2到15之間");
				}

				Integer chapterlen = null;
				// 應該要自己抓影片的長度
				try {
					chapterlen = Integer.valueOf(req.getParameter("chapterlen"));
					if (chapterlen <= 0) {
						errorMsgs.add("單元長度請輸入大於零的整數");
					}
				} catch (NumberFormatException e) {
					chapterlen = 0;
					errorMsgs.add("單元長度請輸入數字");
				}

				byte[] video = null;
				Part part = req.getPart("video");
				System.out.println(part);

				if (part.getSize() == 0) {
					errorMsgs.add("請上傳課程影片");
				} else if (part.getContentType().indexOf("video/mp4") < 0) {
					errorMsgs.add("僅可以上傳 mp4 影片檔案");
				} else {
					InputStream in = part.getInputStream();
					video = getUpdateFileByteArray(in);
					in.close();
					// 檔案格式錯誤？目前寫 mp4
					// 其他錯誤處理					
				}

				VideoVO videoVO = new VideoVO();

				videoVO.setCourseno(courseno);
				videoVO.setTestscope(testscope);
				videoVO.setChapterno(chapterno);
				videoVO.setChaptername(chaptername);
				videoVO.setChapterlen(chapterlen);
//				videoVO.setVideo(video); // 不用 hold 上傳檔案的資料

				if (!errorMsgs.isEmpty()) {
					req.setAttribute("videoVO", videoVO); // 含有輸入格式錯誤的empVO物件,也存入req
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/video/addVideo.jsp");
					failureView.forward(req, res);
					return; // 中斷程式
				}

				/*************************** 2.開始新增資料 *****************************************/
				VideoService videoSvc = new VideoService();
				videoVO = videoSvc.addVideo(courseno, testscope, chapterno, chaptername, chapterlen, video);

//				if (!errorMsgs.isEmpty()) {
//					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/xxxxx/xxxpage.jsp");
//					failureView.forward(req, res);
//					return; // 中斷程式
//				}
				/*************************** 3.查詢完成,準備轉交(Send the Success view) *************/
				req.setAttribute("videoVO", videoVO);
				String url = "/back-end/video/listAllVideo.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);
				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.add("無法新增資料: " + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/video/addVideo.jsp");
				failureView.forward(req, res);
			}
		}
		
		
		
		if ("deleteVideo".equals(action)) { // 來自listAllEmp.jsp

			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
	
			try {
				/***************************1.接收請求參數***************************************/
				String vidoeno = req.getParameter("videono");
				
				/***************************2.開始刪除資料***************************************/
				VideoService videoSvc = new VideoService();
				CourseService courseSvc = new CourseService();
				CourseVO courseVO = courseSvc.getOneCourse(videoSvc.getOneVideo(vidoeno).getCourseno());
				videoSvc.deleteVideo(vidoeno);
				
				/***************************3.刪除完成,準備轉交(Send the Success view)***********/								
//				req.setAttribute("courseVO", courseVO);
//				String url = "/front-end/course/editCourse.jsp";
//				RequestDispatcher successView = req.getRequestDispatcher(url);
//				successView.forward(req, res);
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				e.printStackTrace();
//				errorMsgs.add("刪除資料失敗:"+e.getMessage());
//				RequestDispatcher failureView = req
//						.getRequestDispatcher("/emp/listAllEmp.jsp");
//				failureView.forward(req, res);
			}
		}
		
		
		
	}
	
	

	public static byte[] getUpdateFileByteArray(InputStream in) throws IOException {
		ByteArrayOutputStream baos = new ByteArrayOutputStream(); // 此資料流會把write的位元資料，存到一個內建的byte[]
		byte[] buffer = new byte[8192];
		int i;
		while ((i = in.read(buffer)) != -1) {
			baos.write(buffer, 0, i);
			baos.flush();
		}
		baos.close();
//		in.close();

		return baos.toByteArray(); // toByteArray() 可以讓我們取得這個資料流內建的 byte[]
	}
	
	

}
