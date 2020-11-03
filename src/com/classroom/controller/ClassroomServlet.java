package com.classroom.controller;

import java.io.*;
import java.util.*;
import java.util.regex.*;

import javax.servlet.*;
import javax.servlet.http.*;

import com.classroom.model.*;

public class ClassroomServlet extends HttpServlet {
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");

		if ("getOne_For_Display".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
				String roomno = req.getParameter("roomno");

				// 檢查空字串或空白
				if (roomno == null || roomno.trim().length() == 0) {
					errorMsgs.add("請輸入教室編號");
				}
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/classroom/listAllClassroom.jsp");
					failureView.forward(req, res);
					return; // 中斷程式
				}

				// 檢查流水碼編號格式
				String roomnoRegex = "^ROOM[0-9]{4}$";
				if (!roomno.matches(roomnoRegex)) {
					errorMsgs.add("教室編號格式不正確");
				}
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/classroom/listAllClassroom.jsp");
					failureView.forward(req, res);
					return; // 中斷程式
				}

				/*************************** 2.開始查詢資料 *****************************************/
				ClassroomService classroomSvc = new ClassroomService();
				ClassroomVO classroomVO = classroomSvc.getOneClassroom(roomno);

				if (classroomVO == null) {
					errorMsgs.add("查無資料");
				}
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/classroom/listAllClassroom.jsp");
					failureView.forward(req, res);
					return; // 中斷程式
				}

				/*************************** 3.查詢完成,準備轉交(Send the Success view) *************/
				req.setAttribute("classroomVO", classroomVO);

				String url = "/back-end/classroom/listOneClassroom.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料: " + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/classroom/listAllClassroom.jsp");
				failureView.forward(req, res);
			}
		}

		if ("getOne_For_Update".equals(action)) {

			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 ****************************************/
				String roomno = req.getParameter("roomno");

				/*************************** 2.開始查詢資料 ****************************************/
				ClassroomService classroomSvc = new ClassroomService();
				ClassroomVO classroomVO = classroomSvc.getOneClassroom(roomno);

				/*************************** 3.查詢完成,準備轉交(Send the Success view) ************/
				req.setAttribute("classroomVO", classroomVO);
				String url = "/back-end/classroom/update_classroom_input.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得要修改的資料" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/classroom/listAllClassroom.jsp");
				failureView.forward(req, res);
				return;
			}
		}

		if ("update".equals(action)) {

			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*********************** 1.接收請求參數 - 輸入格式的錯誤處理 *************************/
				String roomno = req.getParameter("roomno");

				String roomname = req.getParameter("roomname");
				String roomnameRegex = "^[A-Z][0-9]{3}";
				if (roomname == null || roomname.trim().length() == 0) {
					errorMsgs.add("教室名稱請勿空白");
				} else if (!roomname.trim().matches(roomnameRegex)) {
					errorMsgs.add("教室名稱格式不符，請輸入 1 碼英文加 3 碼數字，如： A005");
				}

				ClassroomService classroomSvc = new ClassroomService();
				Boolean roomdelete = Boolean.valueOf(req.getParameter("roomdelete"));

				for (ClassroomVO classroomVO : classroomSvc.getAll()) {
					if (!roomno.equals(classroomVO.getRoomno())) {
						if (!classroomVO.getRoomdelete() && (roomname.trim().equals(classroomVO.getRoomname()))) {
							// 資料庫內有尚未刪除， 且與新名稱相同的教室
//							System.out.println(classroomVO.getRoomno()+" : " + classroomVO.getRoomname());
							if (!roomdelete) 
								errorMsgs.add("*已有相同名稱且啟用中之教室 " + classroomVO.getRoomno() + " ，請重新命名或註銷原教室");
						}
					}
				}

				Integer roomrow = null;
				Integer roomcolumn = null;
				try {
					roomrow = Integer.valueOf(req.getParameter("roomrow"));
					roomcolumn = Integer.valueOf(req.getParameter("roomcolumn"));

					if (roomrow < 1 || roomrow > 10 || roomcolumn < 1 || roomcolumn > 10) {
						errorMsgs.add("欄數、列數請填入 1 - 10 之間的數字");
					}
				} catch (NumberFormatException e) {
					roomrow = 5;
					roomcolumn = 5;
					errorMsgs.add("欄數、列數請填入數字");
				}

				String defaultseat = req.getParameter("defaultseat");
				if (defaultseat == null || defaultseat.trim().length() == 0) {
					errorMsgs.add("預設座位狀態請勿空白");
				} else if (defaultseat.length() != (roomrow * roomcolumn)) {
					errorMsgs.add("預設座位狀態數量與空間數量不符");
				}

				ClassroomVO classroomVO = new ClassroomVO();
				classroomVO.setRoomno(roomno);
				classroomVO.setRoomname(roomname);
				classroomVO.setRoomrow(roomrow);
				classroomVO.setRoomcolumn(roomcolumn);
				classroomVO.setDefaultseat(defaultseat);
				classroomVO.setRoomdelete(roomdelete);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("classroomVO", classroomVO); // 含有輸入格式錯誤的empVO物件,也存入req
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/classroom/update_classroom_input.jsp");
					failureView.forward(req, res);
					return;
				}

				/*************************** 2.開始修改資料 ***************************************/
//				classroomVO = classroomSvc.updateClassroom(roomno, roomname, roomrow, roomcolumn, defaultseat, roomdelete);
				// 用上面那行回傳的VO取不到 timestamp
				classroomSvc.updateClassroom(roomno, roomname, roomrow, roomcolumn, defaultseat, roomdelete);
				classroomVO = classroomSvc.getOneClassroom(roomno);

				/*************************** 3.修改完成,準備轉交(Send the Success view) ***********/
				req.setAttribute("classroomVO", classroomVO);
				String url = "/back-end/classroom/listOneClassroom.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add("修改資料失敗:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back-end/classroom/update_classroom_input.jsp");
				failureView.forward(req, res);
			}
		}

		if ("insert".equals(action)) {

			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*********************** 1.接收請求參數 - 輸入格式的錯誤處理 *************************/
				String roomname = req.getParameter("roomname");
				String roomnameRegex = "^[A-Z][0-9]{3}";
				if (roomname == null || roomname.trim().length() == 0) {
					errorMsgs.add("教室名稱請勿空白");
				} else if (!roomname.trim().matches(roomnameRegex)) {
					errorMsgs.add("教室名稱格式不符，請輸入 1 碼英文加 3 碼數字，如： A005");
				}

				ClassroomService classroomSvc = new ClassroomService();
				for (ClassroomVO classroomVO : classroomSvc.getAll()) {
					if (!classroomVO.getRoomdelete() && (roomname.trim().equals(classroomVO.getRoomname()))) {
						errorMsgs.add("已有相同名稱且啟用中之教室 " + classroomVO.getRoomno() + " ，請重新命名或註銷原教室");
					}
				}

				Integer roomrow = null;
				Integer roomcolumn = null;
				try {
					roomrow = Integer.valueOf(req.getParameter("roomrow"));
					roomcolumn = Integer.valueOf(req.getParameter("roomcolumn"));

					if (roomrow < 1 || roomrow > 10 || roomcolumn < 1 || roomcolumn > 10) {
						errorMsgs.add("欄數、列數請填入 1 - 10 之間的數字");
					}
				} catch (NumberFormatException e) {
					roomrow = 5;
					roomcolumn = 5;
					errorMsgs.add("欄數、列數請填入數字");
				}

				String defaultseat = req.getParameter("defaultseat");
				if (defaultseat == null || defaultseat.trim().length() == 0) {
					errorMsgs.add("預設座位狀態請勿空白");
				} else if (defaultseat.length() != (roomrow * roomcolumn)) {
					errorMsgs.add("預設座位狀態數量與空間數量不符");
				}

				Boolean roomdelete = Boolean.valueOf(req.getParameter("roomdelete"));

				ClassroomVO classroomVO = new ClassroomVO();
				classroomVO.setRoomname(roomname);
				classroomVO.setRoomrow(roomrow);
				classroomVO.setRoomcolumn(roomcolumn);
				classroomVO.setDefaultseat(defaultseat);
				classroomVO.setRoomdelete(roomdelete);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("classroomVO", classroomVO); // 含有輸入格式錯誤的empVO物件,也存入req
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/classroom/addClassroom.jsp");
					failureView.forward(req, res);
					return;
				}
				/*************************** 2.開始新增資料 ***************************************/
				classroomVO = classroomSvc.addClassroom(roomname, roomrow, roomcolumn, defaultseat, roomdelete);

				/*************************** 3.新增完成,準備轉交(Send the Success view) ***********/
				String url = "/back-end/classroom/listAllClassroom.jsp"; // 不用加前面的路徑？2020/09/30
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllClassroom.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add("無法新增資料:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/classroom/addClassroom.jsp");
				failureView.forward(req, res);
			}
		}

	}

}
