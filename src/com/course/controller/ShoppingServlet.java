package com.course.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;
import java.util.Vector;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;

import com.course.model.*;

/**
 * Servlet implementation class ShoppingServlet
 */
public class ShoppingServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	

	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");

		HttpSession session = req.getSession();
		Vector<CourseVO> buylist = (Vector<CourseVO>) session.getAttribute("shoppingcart");
		String action = req.getParameter("action");
		
		String courseno = req.getParameter("courseno");
//		if (!action.equals("CHECKOUT")) {
//			//新增購物車
//			if (action.equals("DELETE")) {
//				String del = req.getParameter("del");
//				int d = Integer.parseInt(del);
//				buylist.removeElementAt(d);
//				
//				session.setAttribute("shoppingcart", buylist);
//				String url = "/front-end/Shop/Shopping_Cart.jsp";
//				RequestDispatcher rd = req.getRequestDispatcher(url);
//				rd.forward(req, res);
//			}
			//移除商品
		
//		if (action.equals("ADD")) {
//				
//				boolean match = false;
//				CourseVO acourse = getCourse(req);
//				
//				if (buylist == null) {
//					buylist = new Vector<CourseVO>();
//					buylist.add(acourse);
//				} else {
//					for (int i = 0; i < buylist.size(); i++) {
//						CourseVO course = buylist.get(i);
//						
//						if(course.getCourseno().equals(acourse.getCourseno())) {
//							buylist.set(i, acourse);
//							match = true;
//						}
//					}
//				if(!match) {
//							buylist.add(acourse);
//				}
//					
//				}
//			}
//			System.out.println(buylist);
//			
//			session.setAttribute("shoppingcart", buylist);
//			String url = "/front-end/Shop/Test1.jsp";
//			RequestDispatcher rd = req.getRequestDispatcher(url);
//			rd.forward(req, res);
//			
			
			
			
			
			
			
			if ("shoppingCart".equals(action)) {
				
				List<String> errorMsgs = new LinkedList<String>();

				req.setAttribute("errorMsgs", errorMsgs);
				CourseService courseSvc = new CourseService();

				CourseVO userSelectedCourse = courseSvc.getOneCourse(courseno);

				String jsonStr = "false";
				//刪除判斷旗標
				String remove = req.getParameter("remove");
				
				List<CourseVO> shoppingList = (List<CourseVO>) req.getSession().getAttribute("shoppingList");

				try {
					if (shoppingList == null) {
						shoppingList = new ArrayList<>();
					}
					if (shoppingList != null && !(shoppingList.contains(userSelectedCourse))) {

						shoppingList.add(userSelectedCourse);
						jsonStr = new JSONObject(userSelectedCourse).toString();
						
					} 
					else if("remove".equals(remove)) {
						System.out.println("刪除購物車");
						shoppingList.remove(userSelectedCourse);
					}
					
					
					
					res.setContentType("text/plain");
					res.setCharacterEncoding("UTF-8");
					PrintWriter out = res.getWriter();
					out.write(jsonStr);
					out.flush();
					out.close();
					
					
					req.getSession().setAttribute("shoppingList", shoppingList);
				} catch (Exception e) {
					errorMsgs.add("無法取得資料:" + e.getMessage());
					RequestDispatcher failureView = req.getRequestDispatcher("新增失敗小視窗.jsp");
					failureView.forward(req, res);
				}
			}
		}
	
		
			//付款結帳
//			else if (action.equals("CHECKOUT")) {
//				int total = 0;
//				for (int i = 0; i < buylist.size(); i++) {
//					CourseVO order = buylist.get(i);
//					int price = order.getCourseprice();
//					total += price;
//				}
//
//				String amount = String.valueOf(total);
//				req.setAttribute("amount", amount);
//				String url = "/front-end/Shop/Checkout.jsp";
//				RequestDispatcher rd = req.getRequestDispatcher(url);
//				rd.forward(req, res);
//			}
//		}
	

	private CourseVO getCourse(HttpServletRequest req) {

		String courseno = req.getParameter("courseno");
		String courseprice = req.getParameter("courseprice");
		System.out.println(courseprice);

		CourseVO cs = new CourseVO();

		cs.setCourseno(courseno);
		cs.setCourseprice((new Integer(courseprice)).intValue());
		return cs;
	}
}