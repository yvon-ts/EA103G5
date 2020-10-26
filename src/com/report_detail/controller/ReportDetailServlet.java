package com.report_detail.controller;

import java.io.*;
import java.sql.Timestamp;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.report_detail.model.ReportDetailService;
import com.report_detail.model.ReportDetailVO;

@WebServlet("/ReportDetailServlet")
public class ReportDetailServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		
//		HttpSession session = req.getSession();  //取得session
//		String XXXNO = (String)session.getAttribute("memno"); //透過session取得已登入會員的會員編號
		
		if ("getOne_For_Display_Front".equals(action)) { // 來自select_page.jsp的請求
		
			List<String> errorMsgs = new LinkedList<String>();
			
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
				String reportno = req.getParameter("reportno");

				
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/report_detail/select_page.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				/*************************** 2.開始查詢資料 *****************************************/
				ReportDetailService reportdetailSvc = new ReportDetailService();
				ReportDetailVO reportdetailVO = reportdetailSvc.getOneReport(reportno);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/report_detail/select_page.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				/*************************** 3.查詢完成,準備轉交(Send the Success view) *************/
				req.setAttribute("reportdetailVO", reportdetailVO); // 資料庫取出的empVO物件,存入req
				String url = "/front-end/report_detail/listOneReportFront.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 listOneEmp.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/report_detail/select_page.jsp");
				failureView.forward(req, res);
			}
		}

		if ("getOne_For_Display_Back".equals(action)) { // 來自select_page.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
				String reportno = req.getParameter("reportno");

				
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/report_detail/select_page.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				/*************************** 2.開始查詢資料 *****************************************/
				ReportDetailService reportdetailSvc = new ReportDetailService();
				ReportDetailVO reportdetailVO = reportdetailSvc.getOneReport(reportno);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/report_detail/select_page.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				/*************************** 3.查詢完成,準備轉交(Send the Success view) *************/
				req.setAttribute("reportdetailVO", reportdetailVO); // 資料庫取出的empVO物件,存入req
				String url = "/back-end/report_detail/listOneReportBack.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 listOneEmp.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/eport_detail/select_page.jsp");
				failureView.forward(req, res);
			}
		}

		if ("getOne_For_Update_AddReport".equals(action)) { // 來自listAllEmp.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
		
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 ****************************************/
				
				String memno = req.getParameter("memno");
				String postno = req.getParameter("postno");
				
				
				/*************************** 2.開始查詢資料 ****************************************/
				ReportDetailService reportdetailSvc = new ReportDetailService();
				ReportDetailVO reportdetailVO = reportdetailSvc.addReport(memno,postno);
				reportdetailVO.setPoststatus("未處理");
				
				/*************************** 3.查詢完成,準備轉交(Send the Success view) ************/
				
				req.setAttribute("reportdetailVO", reportdetailVO); // 資料庫取出的empVO物件,存入req
				String url = "/front-end/posts/posts.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交 update_emp_input.jsp
				successView.forward(req, res);
					
				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得要修改的資料:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/front-end/report_detail/select_page.jsp");
				failureView.forward(req, res);
			}
		}
		if ("getOne_For_Update_removeReportFront".equals(action)) { // 來自listAllEmp.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 ****************************************/
				String reportno = req.getParameter("reportno");

				/*************************** 2.開始查詢資料 ****************************************/
				ReportDetailService reportdetailSvc = new ReportDetailService();
				reportdetailSvc.deleteReport(reportno);
				System.out.println(reportno);
				/*************************** 3.查詢完成,準備轉交(Send the Success view) ************/
				
				String url = "/front-end/report_detail/select_page.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交 update_emp_input.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得要修改的資料:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/report_detail/listAllReport.jsp");
				failureView.forward(req, res);
			}
		}

		
		if ("getOne_For_Update_removeReportBack".equals(action)) { // 員工審核完狀態改變

			List<String> errorMsgs = new LinkedList<String>();
			
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
				String reportno = req.getParameter("reportno");
				String poststatus = req.getParameter("poststatus");
				String memno = req.getParameter("memno");
				String postno = req.getParameter("postno");
				String empno = req.getParameter("empno");
				Timestamp reportlmod = new Timestamp(System.currentTimeMillis());

				ReportDetailVO reportdetailVO = new ReportDetailVO();
				reportdetailVO.setReportno(reportno);
				reportdetailVO.setPoststatus(poststatus);
				reportdetailVO.setMemno(memno);
				reportdetailVO.setPostno(postno);
				reportdetailVO.setEmpno(empno);
				reportdetailVO.setReportlmod(reportlmod);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("reportdetailVO", reportdetailVO); // 含有輸入格式錯誤的empVO物件,也存入req
					RequestDispatcher failureView = req.getRequestDispatcher("/report_detail/update_report_detail_input.jsp");
					failureView.forward(req, res);
					return; // 程式中斷
				}

				/*************************** 2.開始修改資料 *****************************************/
				ReportDetailService reportdetailSvc = new ReportDetailService();
				reportdetailVO = reportdetailSvc.removeReport(reportno);

				/*************************** 3.修改完成,準備轉交(Send the Success view) *************/
				reportdetailVO = reportdetailSvc.getOneReport(reportno);
				req.setAttribute("reportdetailVO", reportdetailVO); // 資料庫update成功後,正確的的empVO物件,存入req
				String url = "/back-end/report_detail/listOneReportBack.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交listOneEmp.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.add("修改資料失敗:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back-end/report_detail/select_page.jsp");
				failureView.forward(req, res);
			}
		}

		if ("update".equals(action)) { // 員工審核完狀態改變

			List<String> errorMsgs = new LinkedList<String>();
			
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
				String reportno = req.getParameter("reportno");
				String poststatus = req.getParameter("poststatus");
				String memno = req.getParameter("memno");
				String postno = req.getParameter("postno");
				String empno = req.getParameter("empno");
				Timestamp reportlmod = new Timestamp(System.currentTimeMillis());

				ReportDetailVO reportdetailVO = new ReportDetailVO();
				reportdetailVO.setReportno(reportno);
				reportdetailVO.setPoststatus(poststatus);
				reportdetailVO.setMemno(memno);
				reportdetailVO.setPostno(postno);
				reportdetailVO.setEmpno(empno);
				reportdetailVO.setReportlmod(reportlmod);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("reportdetailVO", reportdetailVO); // 含有輸入格式錯誤的empVO物件,也存入req
					RequestDispatcher failureView = req.getRequestDispatcher("/report_detail/update_report_detail_input.jsp");
					failureView.forward(req, res);
					return; // 程式中斷
				}

				/*************************** 2.開始修改資料 *****************************************/
				ReportDetailService reportdetailSvc = new ReportDetailService();
				reportdetailVO = reportdetailSvc.updateReport(reportno);

				/*************************** 3.修改完成,準備轉交(Send the Success view) *************/
				reportdetailVO = reportdetailSvc.getOneReport(reportno);
				req.setAttribute("reportdetailVO", reportdetailVO); // 資料庫update成功後,正確的的empVO物件,存入req
				String url = "/back-end/report_detail/listOneReportBack.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交listOneEmp.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.add("修改資料失敗:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back-end/report_detail/select_page.jsp");
				failureView.forward(req, res);
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
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/report_detail/select_page.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}
				System.out.println("2");

				/*************************** 2.開始查詢資料 *****************************************/
				ReportDetailService reportdetailSvc = new ReportDetailService();
				List<ReportDetailVO> reportdetailVO = reportdetailSvc.findByMemno(memno);
				System.out.println("2");
				if (reportdetailVO == null) {
					errorMsgs.add("查無資料");
				}
			
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/report_detail/select_page.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				/*************************** 3.查詢完成,準備轉交(Send the Success view) *************/
				req.setAttribute("reportdetailVO", reportdetailVO); // 資料庫取出的empVO物件,存入req
				String url = "/back-end/report_detail/listMemReport.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 listOneEmp.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/report_detail/select_page.jsp");
				failureView.forward(req, res);
			}
		}
		if ("findByEmpno".equals(action)) { // 來自select_page.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
				String empno = req.getParameter("empno");

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/report_detail/select_page.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				/*************************** 2.開始查詢資料 *****************************************/
				ReportDetailService reportdetailSvc = new ReportDetailService();
				List<ReportDetailVO> reportdetailVO = reportdetailSvc.findByEmpno(empno);
				if (reportdetailVO == null) {
					errorMsgs.add("查無資料");
				}

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/report_detail/select_page.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				/*************************** 3.查詢完成,準備轉交(Send the Success view) *************/
				req.setAttribute("reportdetailVO", reportdetailVO); // 資料庫取出的empVO物件,存入req
				String url = "/back-end/report_detail/listEmpReport.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 listOneEmp.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/report_detail/select_page.jsp");
				failureView.forward(req, res);
			}
		}
		if ("getPending".equals(action)) { // 來自select_page.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			HttpSession session = req.getSession();
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
			
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/report_detail/select_page.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				/*************************** 2.開始查詢資料 *****************************************/
				ReportDetailService reportdetailSvc = new ReportDetailService();
				List<ReportDetailVO> reportdetailVO = reportdetailSvc.getPending();
				if (reportdetailVO == null) {
					errorMsgs.add("查無資料");
				}

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/report_detail/select_page.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				/*************************** 3.查詢完成,準備轉交(Send the Success view) *************/
				session.setAttribute("list", reportdetailVO); 
				String url = "/back-end/report_detail/listPendingReport.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); 
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/report_detail/select_page.jsp");
				failureView.forward(req, res);
			}
		}
		if ("getSettled".equals(action)) { // 來自select_page.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			HttpSession session = req.getSession();
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
				
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/report_detail/select_page.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				/*************************** 2.開始查詢資料 *****************************************/
				ReportDetailService reportdetailSvc = new ReportDetailService();
				List<ReportDetailVO> reportdetailVO = reportdetailSvc.getSettled();
				if (reportdetailVO == null) {
					errorMsgs.add("查無資料");
				}

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/report_detail/select_page.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				/*************************** 3.查詢完成,準備轉交(Send the Success view) *************/
				req.setAttribute("list", reportdetailVO);
				String url = "/back-end/report_detail/listSettledReport.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); 
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/report_detail/select_page.jsp");
				failureView.forward(req, res);
			}
		}
	
	}

}
