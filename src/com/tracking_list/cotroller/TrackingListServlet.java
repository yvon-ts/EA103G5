package com.tracking_list.cotroller;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.report_detail.model.ReportDetailService;
import com.report_detail.model.ReportDetailVO;
import com.tracking_list.model.TrackingListService;
import com.tracking_list.model.TrackingListVO;

/**
 * Servlet implementation class TrackingListServlet
 */
@WebServlet("/TrackingListServlet")
public class TrackingListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);

	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");

		if ("insert".equals(action)) {

			List<String> errorMsgs = new LinkedList<String>();

			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 ****************************************/

				String memno = req.getParameter("memno");
				String courseno = req.getParameter("courseno");

				/*************************** 2.開始查詢資料 ****************************************/
				TrackingListService trackinglistSvc = new TrackingListService();
				TrackingListVO trackinglistVO = trackinglistSvc.addTracking(memno, courseno);

				/*************************** 3.查詢完成,準備轉交(Send the Success view) ************/

				req.setAttribute("trackinglistVO", trackinglistVO); // 資料庫取出的empVO物件,存入req
				String url = "/front-end/report_detail/listOneTrackingFront.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交 update_emp_input.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
//					errorMsgs.add("無法取得要新增的資料:" + e.getMessage());
//					RequestDispatcher failureView = req.getRequestDispatcher("新增失敗小視窗.jsp");
//					failureView.forward(req, res);
			}

		}

		if ("delete".equals(action)) {

			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 ****************************************/
				String memno = req.getParameter("memno");
				String courseno = req.getParameter("courseno");

				/*************************** 2.開始查詢資料 ****************************************/
				TrackingListService trackinglistSvc = new TrackingListService();
				trackinglistSvc.deleteTracking(memno, courseno);

				/*************************** 3.查詢完成,準備轉交(Send the Success view) ************/

				String url = "/front-end/tracking_list/listOneTrackingFront.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
//				errorMsgs.add("無法取得要修改的資料:" + e.getMessage());
//				RequestDispatcher failureView = req.getRequestDispatcher("新增失敗小視窗.jsp");
//				failureView.forward(req, res);
			}
		}
		if ("findByMemno".equals(action)) { // 來自select_page.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
				String memno = req.getParameter("memno");
				System.out.println("1");
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/front-end/tracking_/select_page.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}
				System.out.println("2");

				/*************************** 2.開始查詢資料 *****************************************/
				TrackingListService trackilistSvc = new TrackingListService();
				List<TrackingListVO> trackinglistVO = trackilistSvc.findByMemno(memno);
				System.out.println("2");
				if (trackinglistVO == null) {
					errorMsgs.add("查無資料");
				}
			
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/front-end/tracking_list/listAllTrackingFront.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				/*************************** 3.查詢完成,準備轉交(Send the Success view) *************/
				req.setAttribute("trackinglistVO", trackinglistVO); // 資料庫取出的empVO物件,存入req
				String url = "/front-end/tracking_list/listAllTrackingFront.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 listOneEmp.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
//				errorMsgs.add("無法取得資料:" + e.getMessage());
//				RequestDispatcher failureView = req.getRequestDispatcher("新增失敗小視窗.jsp");
//				failureView.forward(req, res);
			}
		}
	}

}
