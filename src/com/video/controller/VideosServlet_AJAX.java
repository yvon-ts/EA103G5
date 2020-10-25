package com.video.controller;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.video.model.VideoService;
import com.video.model.VideoVO;
import com.course.model.CourseService;
import com.course.model.CourseVO;
import com.google.gson.*;

@MultipartConfig
@WebServlet("/courseVideosServlet")

// 未來要改成佈署描述檔

public class VideosServlet_AJAX extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		Gson gson = new Gson();

		req.setCharacterEncoding("UTF-8");
		res.setContentType("text/plain; charset=UTF-8");
		PrintWriter out = res.getWriter();
		String action = req.getParameter("action");
		System.out.println();
		System.out.println("***action = " + action);


		// 10/26 NEW INSERT
		if ("addNewChapter".equals(action)) {

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
				String chapternameRegex = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_. )]{2,50}$";
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

				if (part.getSize() == 0) {
					errorMsgs.add("請上傳課程影片");
				} else if (part.getContentType().indexOf("video/mp4") < 0) {
					errorMsgs.add("僅可以上傳 mp4 影片檔案");
				} else {
					InputStream in = part.getInputStream();
					video = getUpdateFileByteArray(in);
					// in.close();
					// 其他錯誤處理
				}

				if (!errorMsgs.isEmpty()) {
					String jsonStr = gson.toJson(errorMsgs);
					out.println(jsonStr);
					return; // 中斷程式
				}
				/*************************** 2.開始新增資料 *****************************************/
				VideoService videoSvc = new VideoService();
				VideoVO videoVO = videoSvc.addVideo(courseno, testscope, chapterno, chaptername, chapterlen, video);
				/*************************** 3.查詢完成,準備轉交(Send the Success view) *************/
				out.print("成功新增課程單元： " + videoVO.getChaptername());
				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.add("無法新增資料: " + e.getMessage());
				String jsonStr = gson.toJson(errorMsgs);
				out.println(jsonStr);
				return; // 中斷程式
			}
		}

		// 更新單一課程內的基本資訊
		if ("updateChapterInfo".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
				String videono = req.getParameter("videono");
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
				try {
					chapterno = Integer.valueOf(req.getParameter("chapterno"));
					if (chapterno <= 0) {
						errorMsgs.add("單元編號請輸入大於零的整數");
					}
				} catch (NumberFormatException e) {
					chapterno = 0;
					errorMsgs.add("單元編號請輸入數字");
				}

				VideoService videoSvc = new VideoService();
				VideoVO videoVO = videoSvc.getOneVideo(videono);

				String chaptername = req.getParameter("chaptername");
				String chapternameRegex = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_. )]{2,50}$";
				if (chaptername == null || chaptername.trim().length() == 0) {
					chaptername = videoVO.getChaptername();
//					errorMsgs.add("單元名稱請勿空白");
					out.print("單元名稱請勿空白");
				} else if (!chaptername.trim().matches(chapternameRegex)) { // 以下練習正則(規)表示式(regular-expression)
					chaptername = videoVO.getChaptername();
					out.print("單元名稱: 只能是中、英文字母、數字和_ , 且長度必需在2到50之間");
//					errorMsgs.add("單元名稱: 只能是中、英文字母、數字和_ , 且長度必需在2到50之間");
				}

				if (!errorMsgs.isEmpty()) {
					String jsonStr = gson.toJson(errorMsgs);
					out.println(jsonStr);
					return; // 中斷程式
				}

				/*************************** 2.開始新增資料 *****************************************/
				videoSvc.updateVideo(videono, courseno, testscope, chapterno, chaptername);
				/*************************** 3.查詢完成,準備轉交(Send the Success view) *************/
				out.print("UpdateChapterInfo Success: " + videono);
				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.add("無法新增資料: " + e.getMessage());
				String jsonStr = gson.toJson(errorMsgs);
				out.println(jsonStr);
				return; // 中斷程式
			}
		}

		// 上傳單一課程內影片
		if ("updateVideoFile".equals(action)) {
			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
				String videono = req.getParameter("videono");

				Integer chapterlen = null;
				byte[] video = null;
				Part part = req.getPart("video");

				// System.out.println("**Name = " + part.getName());
				System.out.println("===== PART: " + videono + " =====");
				System.out.println("**SubmittedFileName = " + part.getSubmittedFileName());
				System.out.println("**ContentType = " + part.getContentType());
				System.out.println("**Size = " + part.getSize());

				if (part.getSize() == 0) {
					out.println("請選取欲上傳的檔案");
					return;
				} else if (part.getContentType().indexOf("video/mp4") < 0) {
					out.println("僅可以上傳 mp4 影片檔案");
					return;
				} else {

					try {
						chapterlen = Integer.valueOf(req.getParameter("chapterlen"));
						if (chapterlen <= 0) {
							out.println("單元長度請輸入大於零的整數");
							return;
						}
					} catch (NumberFormatException e) {
						chapterlen = 0;
						out.println("單元長度請輸入數字");
						return;
					}

					InputStream in = part.getInputStream();
					video = getUpdateFileByteArray(in);
				}
				/*************************** 2.開始新增資料 *****************************************/
				VideoService videoSvc = new VideoService();
				VideoVO videoVO = videoSvc.getOneVideo(videono);
				videoSvc.updateVideo(videono, videoVO.getCourseno(), videoVO.getTestscope(), videoVO.getChapterno(),
						videoVO.getChaptername(), chapterlen, video);
				/*************************** 3.查詢完成,準備轉交(Send the Success view) *************/
				out.print("成功上傳影片: " + part.getSubmittedFileName());
				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				e.printStackTrace();
				out.print("伺服器異常，影片上傳失敗");
			}
		}

		if ("deleteVideo".equals(action)) {
			try {
				/*************************** 1.接收請求參數 ***************************************/
				String vidoeno = req.getParameter("videono");

				/*************************** 2.開始刪除資料 ***************************************/
				VideoService videoSvc = new VideoService();
//				CourseService courseSvc = new CourseService();
//				CourseVO courseVO = courseSvc.getOneCourse(videoSvc.getOneVideo(vidoeno).getCourseno());
				videoSvc.deleteVideo(vidoeno);

				/*************************** 3.刪除完成,準備轉交(Send the Success view) ***********/
				out.print("課程單元已成功刪除");
				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				e.printStackTrace();
				out.print("伺服器異常，課程單元刪除失敗");
			}
		}

//		// ========== 10/25 之前，同時更新資訊+上傳影片的版本，但是影片太多會卡死 ==========
//		// 更新單一課程內的基本資訊
//		if ("update".equals(action)) {
//			List<String> errorMsgs = new LinkedList<String>();
//			req.setAttribute("errorMsgs", errorMsgs);
//
//			try {
//				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
//				String videono = req.getParameter("videono");
//				String courseno = req.getParameter("courseno");
//
//				Integer testscope = null;
//				try {
//					testscope = Integer.valueOf(req.getParameter("testscope"));
//					if (testscope <= 0) {
//						errorMsgs.add("範圍編號請輸入大於零的整數");
//					}
//				} catch (NumberFormatException e) {
//					testscope = 0;
//					errorMsgs.add("範圍編號請輸入數字");
//				}
//
//				Integer chapterno = null;
//				// 尚未處理：同課程中，單元編號不得重複
//				try {
//					chapterno = Integer.valueOf(req.getParameter("chapterno"));
//					if (chapterno <= 0) {
//						errorMsgs.add("單元編號請輸入大於零的整數");
//					}
//				} catch (NumberFormatException e) {
//					chapterno = 0;
//					errorMsgs.add("單元編號請輸入數字");
//				}
//
//				String chaptername = req.getParameter("chaptername");
//				String chapternameRegex = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_.)]{2,50}$";
//				if (chaptername == null || chaptername.trim().length() == 0) {
//					chaptername = "";
//					errorMsgs.add("單元名稱請勿空白");
//				} else if (!chaptername.trim().matches(chapternameRegex)) { // 以下練習正則(規)表示式(regular-expression)
//					errorMsgs.add("單元名稱: 只能是中、英文字母、數字和_ , 且長度必需在2到50之間");
//				}
//
//				Integer chapterlen = null;
//				byte[] video = null;
//				Part part = req.getPart("video");
//
//				//				System.out.println("**Name = " + part.getName());
//				System.out.println("===== PART: " + videono + " =====");
//				System.out.println("**SubmittedFileName = " + part.getSubmittedFileName());
//				System.out.println("**ContentType = " + part.getContentType());
//				System.out.println("**Size = " + part.getSize());
//
//				if (part.getSize() == 0) {
//					System.out.println("***沒上傳檔案***");
//				} else if (part.getContentType().indexOf("video/mp4") < 0) {
//					errorMsgs.add("僅可以上傳 mp4 影片檔案");
//				} else {
//
//					try {
//						chapterlen = Integer.valueOf(req.getParameter("chapterlen"));
//						if (chapterlen <= 0) {
//							errorMsgs.add("單元長度請輸入大於零的整數");
//						}
//					} catch (NumberFormatException e) {
//						chapterlen = 0;
//						errorMsgs.add("單元長度請輸入數字");
//					}
//
//					InputStream in = part.getInputStream();
//					video = getUpdateFileByteArray(in);
//				}
//
//				VideoVO videoVO = new VideoVO();
//				videoVO.setVideono(videono);
//				videoVO.setCourseno(courseno);
//				videoVO.setTestscope(testscope);
//				videoVO.setChapterno(chapterno);
//				videoVO.setChaptername(chaptername);
//				videoVO.setChapterlen(chapterlen);
//
//				if (!errorMsgs.isEmpty()) {
//					out.println(videono + "ERR:");
//					for (String errorMsg : errorMsgs) {
//						System.out.println(errorMsg);
//						res.getWriter().println(errorMsg);
//					}
//					return; // 中斷程式
//				}
//				/*************************** 2.開始新增資料 *****************************************/
//				VideoService videoSvc = new VideoService();
//				if (part.getSize() == 0) {
//					videoSvc.updateVideo(videono, courseno, testscope, chapterno, chaptername);
//				} else {
//					videoSvc.updateVideo(videono, courseno, testscope, chapterno, chaptername, chapterlen, video);
//				}
//				videoVO = videoSvc.getOneVideo(videono);
//				/*************************** 3.查詢完成,準備轉交(Send the Success view) *************/
//				res.getWriter().print("Update Success: " + videono);
//				/*************************** 其他可能的錯誤處理 *************************************/
//			} catch (Exception e) {
//				errorMsgs.add("無法新增資料: " + e.getMessage());
//				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/video/update_video_input.jsp");
//				failureView.forward(req, res);
//			}
//		}
		
		
//		// 10/25 之前的版本，尚未更新，進行中
//		if ("insert".equals(action)) {
//
//			List<String> errorMsgs = new LinkedList<String>();
//			req.setAttribute("errorMsgs", errorMsgs);
//
//			try {
//				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
//				String courseno = req.getParameter("courseno");
//
//				Integer testscope = null;
//				try {
//					testscope = Integer.valueOf(req.getParameter("testscope"));
//					if (testscope <= 0) {
//						errorMsgs.add("範圍編號請輸入大於零的整數");
//					}
//				} catch (NumberFormatException e) {
//					testscope = 0;
//					errorMsgs.add("範圍編號請輸入數字");
//				}
//
//				Integer chapterno = null;
//				// 尚未處理：同課程中，單元編號不得重複
//				try {
//					chapterno = Integer.valueOf(req.getParameter("chapterno"));
//					if (chapterno <= 0) {
//						errorMsgs.add("單元編號請輸入大於零的整數");
//					}
//				} catch (NumberFormatException e) {
//					chapterno = 0;
//					errorMsgs.add("單元編號請輸入數字");
//				}
//
//				String chaptername = req.getParameter("chaptername");
//				String chapternameRegex = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_.)]{2,50}$";
//				if (chaptername == null || chaptername.trim().length() == 0) {
//					chaptername = "";
//					errorMsgs.add("單元名稱請勿空白");
//				} else if (!chaptername.trim().matches(chapternameRegex)) { // 以下練習正則(規)表示式(regular-expression)
//					errorMsgs.add("單元名稱: 只能是中、英文字母、數字和_ , 且長度必需在2到50之間");
//				}
//
//				Integer chapterlen = null;
//				// 應該要自己抓影片的長度
//				try {
//					chapterlen = Integer.valueOf(req.getParameter("chapterlen"));
//					if (chapterlen <= 0) {
//						errorMsgs.add("單元長度請輸入大於零的整數");
//					}
//				} catch (NumberFormatException e) {
//					chapterlen = 0;
//					errorMsgs.add("單元長度請輸入數字");
//				}
//
//				byte[] video = null;
//				Part part = req.getPart("video");
//				System.out.println(part);
//
//				if (part.getSize() == 0) {
//					errorMsgs.add("請上傳課程影片");
//				} else if (part.getContentType().indexOf("video/mp4") < 0) {
//					errorMsgs.add("僅可以上傳 mp4 影片檔案");
//				} else {
//					InputStream in = part.getInputStream();
//					video = getUpdateFileByteArray(in);
//					// in.close();
//					// 其他錯誤處理
//				}
//
//				VideoVO videoVO = new VideoVO();
//
//				videoVO.setCourseno(courseno);
//				videoVO.setTestscope(testscope);
//				videoVO.setChapterno(chapterno);
//				videoVO.setChaptername(chaptername);
//				videoVO.setChapterlen(chapterlen);
////						videoVO.setVideo(video); // 不用 hold 上傳檔案的資料
//
//				if (!errorMsgs.isEmpty()) {
//					System.out.println("insert ERR:");
////					for (String errorMsg : errorMsgs) {
////						System.out.println(errorMsg);
////						res.getWriter().println(errorMsg);
////					}
////					req.setAttribute("videoVO", videoVO); // 含有輸入格式錯誤的empVO物件,也存入req
////					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/video/addVideo.jsp");
////					failureView.forward(req, res);
//					return; // 中斷程式
//				}
//
//				/*************************** 2.開始新增資料 *****************************************/
//				VideoService videoSvc = new VideoService();
//				videoVO = videoSvc.addVideo(courseno, testscope, chapterno, chaptername, chapterlen, video);
//				String videono = videoVO.getVideono();
//
////						if (!errorMsgs.isEmpty()) {
////							RequestDispatcher failureView = req.getRequestDispatcher("/back-end/xxxxx/xxxpage.jsp");
////							failureView.forward(req, res);
////							return; // 中斷程式
////						}
//				/*************************** 3.查詢完成,準備轉交(Send the Success view) *************/
//				res.getWriter().print("Insert Success: " + videono);
////				req.setAttribute("videoVO", videoVO);
////				String url = "/back-end/video/listAllVideo.jsp";
////				RequestDispatcher successView = req.getRequestDispatcher(url);
////				successView.forward(req, res);
//				/*************************** 其他可能的錯誤處理 *************************************/
//			} catch (Exception e) {
//				errorMsgs.add("無法新增資料: " + e.getMessage());
//				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/video/addVideo.jsp");
//				failureView.forward(req, res);
//			}
//		}

	}

	public static byte[] getUpdateFileByteArray(InputStream in) throws IOException {
		byte[] buffer = new byte[in.available()];
		in.read(buffer);
		in.close();
		return buffer;
	}
}
