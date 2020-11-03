package com.order_master.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.LinkedList;
import java.util.List;
import java.util.Vector;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.coup_code.model.CoupCodeService;
import com.coup_code.model.CoupCodeVO;
import com.course.model.CourseVO;
import com.order_detail.model.OrderDetailVO;
import com.order_master.model.OrderMasterService;
import com.order_master.model.OrderMasterVO;

import ecpay.payment.integration.AllInOne;
import ecpay.payment.integration.domain.AioCheckOutOneTime;

public class OrderMasterServlet extends HttpServlet {
	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");
		HttpSession session = req.getSession();
		List<CourseVO> buylist = (List<CourseVO>) session.getAttribute("shoppingList");
		String action = req.getParameter("action");

		PrintWriter out = res.getWriter();
		
		if ("getOne_For_Display".equals(action)) { 

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
				
				Integer orderamt = null;
				try {
				orderamt = new Integer(req.getParameter("orderamt"));
				} catch(NumberFormatException e) {
					e.printStackTrace();
				}
				
				String coupno = req.getParameter("coupno");
				
				if (!(coupno.equals("empty"))) {
					
					CoupCodeService coupSvc = new CoupCodeService();
					coupSvc.updateCoupCode(coupno, 1);
				} else {
					coupno = null;
				}
				
				String payby = req.getParameter("payby");

				OrderMasterVO orderMasterVO = new OrderMasterVO();

				List<OrderDetailVO> list = new Vector<OrderDetailVO>();
				for (CourseVO abuylist : buylist) {

					OrderDetailVO odVO = new OrderDetailVO();
					odVO.setCourseno(abuylist.getCourseno());
					odVO.setSellprice(abuylist.getCourseprice());
					odVO.setPromono(null);

					list.add(odVO);
				}

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("orderMasterVO", orderMasterVO);
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/tracking_list/listTrackingListForUser.jsp");
					failureView.forward(req, res);
					return;
				}

				/*************************** 2.開始新增資料 ***************************************/
				OrderMasterService ordermasterSvc = new OrderMasterService();
				orderMasterVO = ordermasterSvc.addOrder(memno, orderamt, coupno, payby, list);
				/*************************** 3.新增完成,準備轉交綠界(Send the Success view) ***********/
				//產生綠界訂單
				AioCheckOutOneTime checkoutonetime = new AioCheckOutOneTime();
				checkoutonetime.setMerchantTradeNo(orderMasterVO.getOrderno());

				StringBuffer itemname = new StringBuffer();
				for(CourseVO a : buylist) {
					itemname.append(a.getCourseno()).append(", ");
				}
				checkoutonetime.setItemName(itemname.toString());
				checkoutonetime.setTotalAmount(orderamt.toString());
					
				java.sql.Timestamp time = new java.sql.Timestamp(System.currentTimeMillis());
				DateFormat sdf = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
				checkoutonetime.setMerchantTradeDate(sdf.format(time));
				checkoutonetime.setReturnURL(req.getScheme() + "://" + req.getServerName() + ":" + req.getServerPort() + ":" + req.getContextPath() + "/Order_Master/Order_Master.do");
				checkoutonetime.setClientBackURL(req.getScheme() + "://" + req.getServerName() + ":" + req.getServerPort() + "/" + req.getContextPath() + "/index/front-index/index.jsp");
				checkoutonetime.setTradeDesc("123");
				
				
				AllInOne all = new AllInOne("");
				String form = all.aioCheckOut(checkoutonetime, null);
				
				//轉送綠界訂單
				out.print("<!DOCTYPE html>\r\n" + 
						"<html lang=\"en\">\r\n" + 
						"<head>\r\n" + 
						"	<meta charset=\"UTF-8\">\r\n" + 
						"	<title>Document</title>\r\n" + 
						"</head>\r\n" + 
						"<body>");
				out.print(form);
				out.print("</body>" +
				"</html>");
				
				//清空購物車
				session.setAttribute("shoppingList", null);
				
//				/*************************** 3.新增完成,準備轉交(Send the Success view) ***********/
//				String url = "/front-end/Shop/Test2.jsp";
//				RequestDispatcher successView = req.getRequestDispatcher(url);
//				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/tracking_list/listTrackingListForUser.jsp");
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
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/Order_Master/OrderMasterDB.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				/*************************** 2.開始查詢資料 *****************************************/
				System.out.println(memno);
				OrderMasterService ordSvc = new OrderMasterService();
				List<OrderMasterVO> orderMasterVO = ordSvc.getOnesOrder(memno);
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
				String url = "/front-end/Order_Master/listAllByMemno.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
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
