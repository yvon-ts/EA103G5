package com.coup_code.controller;

import java.io.IOException;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.coup_code.model.*;
import com.order_master.model.OrderMasterService;
import com.order_master.model.OrderMasterVO;

/**
 * Servlet implementation class CoupCodeServlet
 */
public class CoupCodeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public CoupCodeServlet() {
		super();
	}

	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");

		if ("getOne_For_Display".equals(action)) { // 來自select_page.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
				String str = req.getParameter("coupno");
				if (str == null || (str.trim()).length() == 0) {
					errorMsgs.add("請輸入折價券編號");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/Coup_Code/select_page.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				String coupno = null;
				try {
					coupno = new String(str);
				} catch (Exception e) {
					errorMsgs.add("折價券編號格式不正確");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/Coup_Code/select_page.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				/*************************** 2.開始查詢資料 *****************************************/
				CoupCodeService coupSvc = new CoupCodeService();
				CoupCodeVO coupVO = coupSvc.getOneCoupCode(coupno);
				if (coupVO == null) {
					errorMsgs.add("查無資料");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/Coup_Code/select_page.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				/*************************** 3.查詢完成,準備轉交(Send the Success view) *************/
				req.setAttribute("coupVO", coupVO);
				String url = "/back-end/Coup_Code/listOneCoupCode.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 listOneEmp.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/Coup_Code/select_page.jsp");
				failureView.forward(req, res);
			}
		}
		if ("getOne_For_Update".equals(action)) { // 來自listAllEmp.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 ****************************************/
				String coupno = new String(req.getParameter("coupno"));

				/*************************** 2.開始查詢資料 ****************************************/
				CoupCodeService coupSvc = new CoupCodeService();
				CoupCodeVO coupVO = coupSvc.getOneCoupCode(coupno);
				System.out.println(coupVO);

				/*************************** 3.查詢完成,準備轉交(Send the Success view) ************/
				req.setAttribute("coupVO", coupVO); // 資料庫取出的VO物件,存入req
				String url = "/back-end/Coup_Code/update_coupcode_input.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);//
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得要修改的資料:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/Coup_Code/listAllCoupCode.jsp");
				failureView.forward(req, res);
			}
		}

		if ("update".equals(action)) { // 來自update_emp_input.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			CoupCodeVO coupVO = new CoupCodeVO();

			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
				String coupno = new String(req.getParameter("coupno").trim());
				Integer discstatus = new Integer(req.getParameter("discstatus"));
				System.out.println(coupVO);

				/*************************** 2.開始修改資料 *****************************************/

				CoupCodeService coupSvc = new CoupCodeService();
				coupVO = coupSvc.updateCoupCode(coupno, discstatus);

				/*************************** 3.修改完成,準備轉交(Send the Success view) *************/
				req.setAttribute("coupVO", coupVO); // 資料庫update成功後,正確的的VO物件,存入req
				String url = "/back-end/Coup_Code/listOneCoupCode.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.add("修改資料失敗:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back-end/Coup_Code/update_coupcode_input.jsp");
				failureView.forward(req, res);
			}
		}

		if ("insert".equals(action)) {

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*********************** 1.接收請求參數 - 輸入格式的錯誤處理 *************************/

				String memno = req.getParameter("memno");
				String memReg = "^[M][E][M]\\d{4}$";
				if (memno == null || memno.trim().length() == 0) {
					errorMsgs.add("會員編號: 請勿空白");
				} else if (!memno.trim().matches(memReg)) {
					errorMsgs.add("會員編號如:MEM0001");
				}

				java.sql.Date coupexp = null;
				try {
					coupexp = java.sql.Date.valueOf(req.getParameter("coupexp").trim());
				} catch (IllegalArgumentException e) {
					coupexp = new java.sql.Date(System.currentTimeMillis());
					errorMsgs.add("請輸入日期!");
				}

				Integer discamt = null;
				try {
					discamt = new Integer(req.getParameter("discamt").trim());
				} catch (NumberFormatException e) {
					discamt = 0;
					errorMsgs.add("折扣金額請填數字.");
				}

				String coupcode = req.getParameter("coupcode").trim();
				if (coupcode == null || coupcode.trim().length() == 0) {
					errorMsgs.add("折扣代碼請勿空白");
				}

				CoupCodeVO coupVO = new CoupCodeVO();
				coupVO.setMemno(memno);
				coupVO.setCoupcode(coupcode);
				coupVO.setCoupexp(coupexp);
				coupVO.setDiscamt(discamt);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("coupVO", coupVO);
					RequestDispatcher failureView = req.getRequestDispatcher("/front-end/Coup_Code/addCoupCode.jsp");
					failureView.forward(req, res);
					return;
				}

				/*************************** 2.開始新增資料 ***************************************/
				CoupCodeService coupSvc = new CoupCodeService();
				coupVO = coupSvc.addCoupCode(memno, coupcode, discamt, coupexp);

				/*************************** 3.新增完成,準備轉交(Send the Success view) ***********/
				String url = "/back-end/Coup_Code/listAllCoupCode.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/Coup_Code/addCoupCode.jsp");
				failureView.forward(req, res);
			}
		}
		
		if ("getMemno_For_Display".equals(action)) { // 來自OrderMasterDB.jsp的請求
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			
			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
				String memno = req.getParameter("memno").toString();
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/front-end/members/indexV1.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				/*************************** 2.開始查詢資料 *****************************************/
				System.out.println(memno);
				CoupCodeService coupSvc = new CoupCodeService();
				List<CoupCodeVO> coupVO = coupSvc.getMemberCoup(memno);
//				if (coupVO == null) {
//					errorMsgs.add("查無資料");
//				}
//				// Send the use back to the form, if there were errors
//				if (!errorMsgs.isEmpty()) {
//					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/Order_Master/OrderMasterDB.jsp");
//					failureView.forward(req, res);
//					return;// 程式中斷
//				}

				/*************************** 3.查詢完成,準備轉交(Send the Success view) *************/
				req.setAttribute("coupVO", coupVO); // 資料庫取出的ordVO物件,存入req
				String url = "/front-end/Coup_Code/listAllByMemno.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/front-end/members/indexV1.jsp");
				failureView.forward(req, res);
			}
		}

	}

}
