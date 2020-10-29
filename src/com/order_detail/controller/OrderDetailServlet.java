package com.order_detail.controller;

import java.io.IOException;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.order_detail.model.*;

@WebServlet("/OrderDetailServlet")
public class OrderDetailServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public OrderDetailServlet() {
		super();
	}

	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");

		if ("getOne_For_Display".equals(action)) { 
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
				String str = req.getParameter("orderno");
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/Order_Master/ListAllOrder.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				String orderno = null;
				try {
					orderno = new String(str);
				} catch (Exception e) {
					errorMsgs.add("訂單編號格式不正確");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/Order_Master/ListAllOrder.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				/*************************** 2.開始查詢資料 *****************************************/
				OrderDetailService ordSvc = new OrderDetailService();
				List<OrderDetailVO> orderDetailVO = ordSvc.getOneOrder(orderno);
				if (orderDetailVO == null) {
					errorMsgs.add("查無資料");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/Order_Master/ListAllOrder.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				/*************************** 3.查詢完成,準備轉交(Send the Success view) *************/
				req.setAttribute("orderDetailVO", orderDetailVO); // 資料庫取出的ordVO物件,存入req
				String url = "/back-end/Order_Detail/listOneOrderNo.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 listOneOrder.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/Order_Master/ListAllOrder.jsp");
				failureView.forward(req, res);
			}
		}
		if ("getOne_For_Update".equals(action)) { 

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 ****************************************/
				String orderno = new String(req.getParameter("orderno"));
				String courseno = new String(req.getParameter("courseno"));
	
				/*************************** 2.開始查詢資料 ****************************************/
				OrderDetailService orderSvc = new OrderDetailService();
				OrderDetailVO orderDetailVO = orderSvc.getOneOrderDetail(orderno, courseno);

				/*************************** 3.查詢完成,準備轉交(Send the Success view) ************/
				req.setAttribute("orderDetailVO", orderDetailVO);
				String url = "/back-end/Order_Detail/update_order_input.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得要修改的資料:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/Order_Master/ListAllOrder.jsp");
				failureView.forward(req, res);
			}
		}

		if ("update".equals(action)) {
			
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
				String orderno = req.getParameter("orderno");
				String courseno = req.getParameter("courseno");
				String odstatus = req.getParameter("odstatus");
				
				OrderDetailService orderDetailSvc = new OrderDetailService();

				/*************************** 2.開始修改資料 *****************************************/
				OrderDetailVO orderDetailVO = orderDetailSvc.updateOrder(orderno, courseno, odstatus);
				
				/*************************** 3.修改完成,準備轉交(Send the Success view) *************/
				req.setAttribute("orderDetailVO", orderDetailVO);
				String url = "/back-end/Order_Detail/listOneOrderDetail.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.add("修改資料失敗:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back-end/Order_Master/ListAllOrder.jsp");
				failureView.forward(req, res);
			}
		}
		
		if ("refund".equals(action)) {

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
				String orderno = req.getParameter("orderno");
				String courseno = req.getParameter("courseno");
				
				OrderDetailService orderDetailSvc = new OrderDetailService();

				/*************************** 2.開始修改資料 *****************************************/
				OrderDetailVO orderDetailVO = orderDetailSvc.updateRefund(orderno, courseno);
				
				/*************************** 3.修改完成,準備轉交(Send the Success view) *************/
				req.setAttribute("orderDetailVO", orderDetailVO);
				String url = "/front-end/Order_Master/listAllByMemno.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.add("修改資料失敗:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back-end/Order_Master/ListAllOrder.jsp");
				failureView.forward(req, res);
			}
		}
		if ("getOne_For_Display_ByMember".equals(action)) { // 前台訂單管理
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
				String str = req.getParameter("orderno");
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/Order_Master/ListAllOrder.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				String orderno = null;
				try {
					orderno = new String(str);
				} catch (Exception e) {
					errorMsgs.add("訂單編號格式不正確");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/Order_Master/ListAllOrder.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				/*************************** 2.開始查詢資料 *****************************************/
				OrderDetailService ordSvc = new OrderDetailService();
				List<OrderDetailVO> orderDetailVO = ordSvc.getOneOrder(orderno);
				if (orderDetailVO == null) {
					errorMsgs.add("查無資料");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/Order_Master/ListAllOrder.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				/*************************** 3.查詢完成,準備轉交(Send the Success view) *************/
				req.setAttribute("orderDetailVO", orderDetailVO); // 資料庫取出的ordVO物件,存入req
				String url = "/front-end/Order_Detail/listOneOrderNo.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 listOneOrder.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/Order_Master/ListAllOrder.jsp");
				failureView.forward(req, res);
			}
		}
		
		if ("bought_Not".equals(action)) { // 前台訂單管理
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
				String courseno = req.getParameter("courseno");
				String memno = req.getParameter("memno");
				/*************************** 2.開始查詢資料 *****************************************/
				OrderDetailService ordSvc = new OrderDetailService();
				boolean owned = ordSvc.boughtNot(courseno, memno);
				
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/Order_Master/ListAllOrder.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				/*************************** 3.查詢完成,準備轉交(Send the Success view) *************/
				req.setAttribute("owned", owned); // 資料庫取出的ordVO物件,存入req
				String url = "/back-end/Order_Master/OrderMasterDB.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 listOneOrder.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/Order_Master/ListAllOrder.jsp");
				failureView.forward(req, res);
			}
		}
	}
}
