package com.posts.controller;

import java.io.IOException;
import java.io.PrintWriter;
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

import com.google.gson.Gson;
import com.members.model.MembersService;
import com.members.model.MembersVO;
import com.posts.model.PostsService;
import com.posts.model.PostsVO;

/**
 * Servlet implementation class PostsServlet
 */
//@WebServlet("/PostsServlet")
public class PostsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);

	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");

		HttpSession session = req.getSession();
		session.setAttribute("memno", "MEM0001");
		session.setAttribute("courseno", "COUR0001");
		if ("getOne_For_Display".equals(action)) { 

			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
				String postno = req.getParameter("postno");

				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/posts/select_page.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				/*************************** 2.開始查詢資料 *****************************************/
				PostsService postsSvc = new PostsService();
				PostsVO postsVO = postsSvc.getOnePost(postno);
				if (postsVO == null) {
					errorMsgs.add("查無資料");
				}

				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/posts/select_page.jsp");
					failureView.forward(req, res);
					return;
				}

				/*************************** 3.查詢完成,準備轉交(Send the Success view) *************/
				req.setAttribute("postsVO", postsVO); 
				String url = "/back-end/posts/listOnePosts.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); 
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/posts/select_page.jsp");
				failureView.forward(req, res);
			}
		}
		if ("getOne_For_Update".equals(action)) { 

			List<String> errorMsgs = new LinkedList<String>();

			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
				String postno = req.getParameter("postno");

				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/posts/select_page.jsp");
					failureView.forward(req, res);
					return;
				}

				/*************************** 2.開始查詢資料 *****************************************/
				PostsService postsSvc = new PostsService();
				PostsVO postsVO = postsSvc.getOnePost(postno);
				if (postsVO == null) {
					errorMsgs.add("查無資料");
				}

				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/posts/select_page.jsp");
					failureView.forward(req, res);
					return;
				}

				/*************************** 3.查詢完成,準備轉交(Send the Success view) *************/
				req.setAttribute("postsVO", postsVO);
				String url = "/front-end/posts/update_posts_input.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); 
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/posts/select_page.jsp");
				failureView.forward(req, res);
			}
		}

		if ("update_Status_Remove".equals(action)) { 

			List<String> errorMsgs = new LinkedList<String>();

			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 ****************************************/
				String postno = req.getParameter("postno");

				/*************************** 2.開始查詢資料 ****************************************/
				PostsService postsSvc = new PostsService();
				postsSvc.updateStatusRemove(postno);

				/*************************** 3.查詢完成,準備轉交(Send the Success view) ************/
				String url = "/front-end/course/mainCoursePage.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得要修改的資料:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/front-end/course/mainCoursePage.jsp");
				failureView.forward(req, res);
			}
		}

		if ("update_Status_Add".equals(action)) {

			List<String> errorMsgs = new LinkedList<String>();

			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 ****************************************/
				String postno = req.getParameter("postno");

				/*************************** 2.開始查詢資料 ****************************************/
				PostsService postsSvc = new PostsService();
				postsSvc.updateStatusAdd(postno);

				/*************************** 3.查詢完成,準備轉交(Send the Success view) ************/
				String url = "/back-end/posts/listAllPosts.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得要修改的資料:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/posts/listAllPosts.jsp");
				failureView.forward(req, res);
			}
		}

		if ("update".equals(action)) { 

			List<String> errorMsgs = new LinkedList<String>();

			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/

				String postno = req.getParameter("postno");
				System.out.println(postno);
				String postcontent = req.getParameter("postcontent").trim();
				if (postcontent == null || postcontent.trim().length() == 0) {
					errorMsgs.add("貼文內容請勿空白");
				}
				System.out.println(postcontent);
				String superpostno = req.getParameter("superpostno");
				System.out.println(superpostno);
				String courseno = req.getParameter("courseno");
				System.out.println(courseno);
				String memno = req.getParameter("memno");
				System.out.println(memno);
				Timestamp poststamp = new Timestamp(System.currentTimeMillis());

				

				PostsVO postsVO = new PostsVO();
				postsVO.setPostno(postno);
				postsVO.setPostcontent(postcontent);
				postsVO.setSuperpostno(superpostno);
				postsVO.setCourseno(courseno);
				postsVO.setMemno(memno);
				postsVO.setPosttime(poststamp);
				

				
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("postsVO", postsVO); 
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/posts/update_posts_input.jsp");
					failureView.forward(req, res);
					return;
				}

				/*************************** 2.開始修改資料 *****************************************/
				PostsService postsSvc = new PostsService();
				postsVO = postsSvc.updatePosts(postno, postcontent, superpostno, memno, courseno, poststamp);

				/*************************** 3.修改完成,準備轉交(Send the Success view) *************/
				req.setAttribute("postsVO", postsVO); 
				String url = "/front-end/course/mainCoursePage.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); 
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.add("修改資料失敗:" + e.getMessage());
				e.printStackTrace();
				RequestDispatcher failureView = req.getRequestDispatcher("/front-end/course/mainCoursePage.jsp");
				failureView.forward(req, res);
			}
		}

		if ("insert".equals(action)) { 

			List<String> errorMsgs = new LinkedList<String>();

			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*********************** 1.接收請求參數 - 輸入格式的錯誤處理 *************************/
				String postcontent = req.getParameter("postcontent");
				String superpostno = req.getParameter("superpostno");
				String memno = req.getParameter("memno");
				String courseno = req.getParameter("courseno");
				
				
				System.out.println("@PostsServlet 新增留言得到的參數為:");
				System.out.println("postcontent=" + postcontent );
				System.out.println("superpostno=" + superpostno );
				System.out.println("memno=" + memno);
				System.out.println("courseno=" + courseno);
				
				if (postcontent == null || (postcontent.trim()).length() == 0) {
					errorMsgs.add("留言不能空白");
				}


				/*************************** 2.開始新增資料 ***************************************/

				PostsService postsSvc = new PostsService();
				postcontent = postcontent.replace("<p>", "");
				postcontent = postcontent.replace("</p>", "");
				PostsVO postsVO = postsSvc.addPosts(superpostno, courseno, memno, postcontent);

				/*************************** 3.新增完成,準備轉交(Send the Success view) ***********/
				PrintWriter out =res.getWriter();
				Gson gson =new Gson();
				
				out.print(gson.toJson(postsVO));
				out.flush();
				out.close();
//				req.setAttribute("postsVO", postsVO);
//				String url = "/front-end/course/mainCoursePage.jsp";
//				RequestDispatcher successView = req.getRequestDispatcher(url); 
//				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				System.out.println("空值" + e);
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/front-end/course/mainCoursePage.jsp");
				failureView.forward(req, res);
			}
		}
		if ("insert_reply".equals(action)) { 
			List<String> errorMsgs = new LinkedList<String>();

			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*********************** 1.接收請求參數 - 輸入格式的錯誤處理 *************************/
				String postcontent = req.getParameter("postcontent");
				String superpostno = req.getParameter("superpostno");
				String memno = req.getParameter("memno");
				String courseno = req.getParameter("courseno");

				if (postcontent == null || (postcontent.trim()).length() == 0) {
					errorMsgs.add("留言不能空白");
				}

				/*************************** 2.開始新增資料 ***************************************/

				PostsService postsSvc = new PostsService();
				postcontent = postcontent.replace("<p>", "");
				postcontent = postcontent.replace("</p>", "");
				PostsVO postsVO = postsSvc.addPosts(superpostno, courseno, memno, postcontent);

				/*************************** 3.新增完成,準備轉交(Send the Success view) ***********/
				req.setAttribute("postsVO", postsVO);
				String url = "/front-end/course/mainCoursePage.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); 
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				System.out.println("空值");
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/front-end/course/mainCoursePage.jsp");
				failureView.forward(req, res);
			}
		}

		if ("findByMemno".equals(action)) { 

			List<String> errorMsgs = new LinkedList<String>();

			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
				String memno = req.getParameter("memno");

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/posts/select_page.jsp");
					failureView.forward(req, res);
					return;
				}

				/*************************** 2.開始查詢資料 *****************************************/
				PostsService postsSvc = new PostsService();
				PostsVO postsVO = postsSvc.findByMemno(memno);
				if (postsVO == null) {
					errorMsgs.add("查無資料");
				}

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/posts/select_page.jsp");
					failureView.forward(req, res);
					return;
				}

				/*************************** 3.查詢完成,準備轉交(Send the Success view) *************/
				req.setAttribute("postsVO", postsVO); 
				String url = "/back-end/posts/listOnePosts.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); 
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/posts/select_page.jsp");
				failureView.forward(req, res);
			}

		}

	}
}