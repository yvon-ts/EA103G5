package com.promo_list.controller;

import java.io.IOException;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.promo_list.model.*;

/**
 * Servlet implementation class PromoListServlet
 */
@WebServlet("/PromoListServlet")
public class PromoListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public PromoListServlet() {
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
				String str = req.getParameter("promono");
				if (str == null || (str.trim()).length() == 0) {
					errorMsgs.add("請輸入優惠編號");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/Promo_List/select_page.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				String promono = null;
				try {
					promono = new String(str);
				} catch (Exception e) {
					errorMsgs.add("優惠編號格式不正確");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/Promo_List/select_page.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				/*************************** 2.開始查詢資料 *****************************************/
				PromoListService promoSvc = new PromoListService();
				PromoListVO promoVO = promoSvc.getOnePromoList(promono);
				if (promoVO == null) {
					errorMsgs.add("查無資料");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/Promo_List/select_page.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				/*************************** 3.查詢完成,準備轉交(Send the Success view) *************/
				req.setAttribute("promoVO", promoVO); // 資料庫取出的VO物件,存入req
				String url = "/back-end/Promo_List/listOnePromoList.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 listOnePromoList.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/Promo_List/select_page.jsp");
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
				String promono = new String(req.getParameter("promono"));

				/*************************** 2.開始查詢資料 ****************************************/
				PromoListService promoSvc = new PromoListService();
				PromoListVO promoVO = promoSvc.getOnePromoList(promono);

				/*************************** 3.查詢完成,準備轉交(Send the Success view) ************/
				req.setAttribute("promoVO", promoVO); // 資料庫取出的empVO物件,存入req
				String url = "/back-end/Promo_List/update_promolist_input.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交 update_emp_input.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得要修改的資料:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/Promo_List/listAllPromoList.jsp");
				failureView.forward(req, res);
			}
		}

		if ("update".equals(action)) { // 來自update_emp_input.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
				String promono = new String(req.getParameter("promono").trim());
				System.out.println(promono);

				String promoname = req.getParameter("promoname");
				String pnameReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{2,20}$";
				if (promoname == null || promoname.trim().length() == 0) {
					errorMsgs.add("活動名稱: 請勿空白");
				} else if (!promoname.trim().matches(pnameReg)) { // 以下練習正則(規)表示式(regular-expression)
					errorMsgs.add("活動名稱: 只能是中、英文字母、數字和_ , 且長度必需在2到20之間");
				}

				java.sql.Date startdate = null;
				try {
					startdate = java.sql.Date.valueOf(req.getParameter("startdate").trim());
				} catch (IllegalArgumentException e) {
					startdate = new java.sql.Date(System.currentTimeMillis());
					errorMsgs.add("請輸入日期!");
				}

				java.sql.Date enddate = null;
				try {
					enddate = java.sql.Date.valueOf(req.getParameter("enddate").trim());
				} catch (IllegalArgumentException e) {
					enddate = new java.sql.Date(System.currentTimeMillis());
					errorMsgs.add("請輸入日期!");
				}

				String promoinfo = req.getParameter("promoinfo");

				PromoListVO promoVO = new PromoListVO();
				promoVO.setPromono(promono);
				promoVO.setPromoname(promoname);
				promoVO.setStartdate(startdate);
				promoVO.setEnddate(enddate);
				promoVO.setPromoinfo(promoinfo);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("promoVO", promoVO); // 含有輸入格式錯誤的VO物件,也存入req
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/Promo_List/update_promolist_input.jsp");
					failureView.forward(req, res);
					return; // 程式中斷
				}

				/*************************** 2.開始修改資料 *****************************************/
				PromoListService promoSvc = new PromoListService();
				promoVO = promoSvc.updatePromoList(promono, promoname, startdate, enddate, promoinfo);

				/*************************** 3.修改完成,準備轉交(Send the Success view) *************/
				req.setAttribute("promoVO", promoVO); // 資料庫update成功後,正確的的empVO物件,存入req
				String url = "/back-end/Promo_List/listOnePromoList.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交listOneEmp.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.add("修改資料失敗:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back-end/Promo_List/update_promolist_input.jsp");
				failureView.forward(req, res);
			}
		}

		if ("insert".equals(action)) { // 來自addEmp.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*********************** 1.接收請求參數 - 輸入格式的錯誤處理 *************************/
				
				String promoname = req.getParameter("promoname");
				String pnameReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{2,20}$";
				if (promoname == null || promoname.trim().length() == 0) {
					errorMsgs.add("活動名稱: 請勿空白");
				} else if (!promoname.trim().matches(pnameReg)) { // 以下練習正則(規)表示式(regular-expression)
					errorMsgs.add("活動名稱: 只能是中、英文字母、數字和_ , 且長度必需在2到20之間");
				}

				java.sql.Date startdate = null;
				try {
					startdate = java.sql.Date.valueOf(req.getParameter("startdate").trim());
				} catch (IllegalArgumentException e) {
					startdate = new java.sql.Date(System.currentTimeMillis());
					errorMsgs.add("請輸入日期!");
				}

				java.sql.Date enddate = null;
				try {
					enddate = java.sql.Date.valueOf(req.getParameter("enddate").trim());
				} catch (IllegalArgumentException e) {
					enddate = new java.sql.Date(System.currentTimeMillis());
					errorMsgs.add("請輸入日期!");
				}

				String promoinfo = req.getParameter("promoinfo");

				PromoListVO promoVO = new PromoListVO();
				promoVO.setPromoname(promoname);
				promoVO.setStartdate(startdate);
				promoVO.setEnddate(enddate);
				promoVO.setPromoinfo(promoinfo);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("promoVO", promoVO); // 含有輸入格式錯誤的empVO物件,也存入req
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/Promo_List/addPromoList.jsp");
					failureView.forward(req, res);
					return;
				}

				/*************************** 2.開始新增資料 ***************************************/
				PromoListService promoSvc = new PromoListService();
				promoVO = promoSvc.addPromoList(promoname, startdate, enddate, promoinfo);

				/*************************** 3.新增完成,準備轉交(Send the Success view) ***********/
				String url = "/back-end/Promo_List/listAllPromoList.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllEmp.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/Promo_List/addPromoList.jsp");
				failureView.forward(req, res);
			}
		}
		if ("delete".equals(action)) { // 來自listAllEmp.jsp

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
	
			try {
				/***************************1.接收請求參數***************************************/
				String promono = new String(req.getParameter("promono"));
				
				/***************************2.開始刪除資料***************************************/
				PromoListService promoSvc = new PromoListService();
				promoSvc.deletePromoList(promono);
				
				/***************************3.刪除完成,準備轉交(Send the Success view)***********/								
				String url = "/back-end/Promo_List/listAllPromoList.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 刪除成功後,轉交回送出刪除的來源網頁
				successView.forward(req, res);
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add("刪除資料失敗:"+e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back-end/Promo_List/listAllPromoList.jsp");
				failureView.forward(req, res);
			}
		}
	}
}
