package com.order_master.controller;

import java.io.IOException;
import java.util.LinkedList;
import java.util.List;
import java.util.Vector;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.course.model.CourseVO;
import com.order_detail.model.OrderDetailVO;
import com.order_master.model.OrderMasterService;
import com.order_master.model.OrderMasterVO;

public class OrderMasterServlet extends HttpServlet {
	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");
		HttpSession session = req.getSession();
		List<CourseVO> buylist = (Vector<CourseVO>) session.getAttribute("shoppingcart");
		String action = req.getParameter("action");

		if ("getOne_For_Display".equals(action)) { // 來自OrderMasterDB.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
				String str = req.getParameter("orderno");
				if (str == null || (str.trim()).length() == 0) {
					errorMsgs.add("請輸入訂單編號");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/Order_Master/OrderMasterDB.jsp");
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
							.getRequestDispatcher("/back-end/Order_Master/OrderMasterDB.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				/*************************** 2.開始查詢資料 *****************************************/
				OrderMasterService ordSvc = new OrderMasterService();
				OrderMasterVO orderMasterVO = ordSvc.getOneOrder(orderno);
				if (orderMasterVO == null) {
					errorMsgs.add("查無資料");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/Order_Master/OrderMasterDB.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				/*************************** 3.查詢完成,準備轉交(Send the Success view) *************/
				req.setAttribute("orderMasterVO", orderMasterVO); // 資料庫取出的ordVO物件,存入req
				String url = "/back-end/Order_Master/ListOneOrder.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 listOneOrder.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/Order_Master/OrderMasterDB.jsp");
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

				/*************************** 2.開始查詢資料 ****************************************/
				OrderMasterService orderMasterSvc = new OrderMasterService();
				OrderMasterVO orderMasterVO = orderMasterSvc.getOneOrder(orderno);

				/*************************** 3.查詢完成,準備轉交(Send the Success view) ************/
				req.setAttribute("OrderMasterVO", orderMasterVO);
				String url = "/back-end/Order_Master/update_order_input.jsp";
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
				String orderstatus = req.getParameter("orderstatus");

				OrderMasterService orderMasterSvc = new OrderMasterService();

				/*************************** 2.開始修改資料 *****************************************/
				OrderMasterVO orderMasterVO = orderMasterSvc.updateOrder(orderno, orderstatus);

				/*************************** 3.修改完成,準備轉交(Send the Success view) *************/
				req.setAttribute("orderMasterVO", orderMasterVO); // 資料庫update成功後,正確的的empVO物件,存入req
				String url = "/back-end/Order_Master/ListOneOrder.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交listOneEmp.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.add("修改資料失敗:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back-end/Order_Master/update_order_input.jsp");
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
				Integer orderamt = new Integer (req.getParameter("orderamt"));
				String coupno = req.getParameter("coupno");
//				空值
				coupno = null;
//				空值
				String payby = req.getParameter("payby").trim();
				if (payby == null || payby.trim().length() == 0) {
					errorMsgs.add("付款方式請勿空白");
				}
				
				String[] courseno = req.getParameterValues("courseno");
				String[] sellprice = req.getParameterValues("courseprice");
				String[] promono = req.getParameterValues("promono");
				
				for(int i = 0 ; i <= promono.length; i++) {
					promono[i] = null;
				}

				OrderMasterVO orderMasterVO = new OrderMasterVO();
				orderMasterVO.setMemno(memno);
				orderMasterVO.setOrderamt(orderamt);
				orderMasterVO.setCoupno(coupno);
				orderMasterVO.setPayby(payby);

				List<OrderDetailVO> list = new Vector<OrderDetailVO>();
				
				for (int i = 0; i < buylist.size(); i++) {
					OrderDetailVO odVO = new OrderDetailVO();
					odVO.setCourseno(courseno[i]);
					odVO.setSellprice(new Integer(sellprice[i]));
					odVO.setPromono(courseno[i]);
					
					list.add(odVO);
					
				}
				
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("orderMasterVO", orderMasterVO);
					RequestDispatcher failureView = req.getRequestDispatcher("/front-end/Shop/Shopping_Cart.jsp");
					failureView.forward(req, res);
					return;
				}

				/*************************** 2.開始新增資料 ***************************************/
				OrderMasterService ordermasterSvc = new OrderMasterService();
				orderMasterVO = ordermasterSvc.addOrder(memno, orderamt, coupno, payby, list);

				/*************************** 3.新增完成,準備轉交(Send the Success view) ***********/
				String url = "/back-end/Order_Master/ListOneOrder.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllEmp.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/front-end/Shop/Shopping_Cart.jsp");
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
				String str = req.getParameter("memno");
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/Order_Master/OrderMasterDB.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				String memno = null;
				try {
					memno = new String(str);
				} catch (Exception e) {
					errorMsgs.add("會員編號格式不正確");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/Order_Master/OrderMasterDB.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				/*************************** 2.開始查詢資料 *****************************************/
				OrderMasterService ordSvc = new OrderMasterService();
				List<OrderMasterVO> orderMasterVO = ordSvc.getOnesOrder(memno);
				if (orderMasterVO == null) {
					errorMsgs.add("查無資料");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/Order_Master/OrderMasterDB.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				/*************************** 3.查詢完成,準備轉交(Send the Success view) *************/
				req.setAttribute("orderMasterVO", orderMasterVO); // 資料庫取出的ordVO物件,存入req
				String url = "/front-end/Order_Master/listAllByMemno.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 listOneOrder.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/Order_Master/OrderMasterDB.jsp");
				failureView.forward(req, res);
			}
		}
	}
}
