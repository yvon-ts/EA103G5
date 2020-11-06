package com.question_bank.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.question_bank.model.QuestionBankService;
import com.question_bank.model.QuestionBankVO;


public class QuestionBankServlet extends HttpServlet {
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		doPost(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {

		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");

		String action = request.getParameter("action");

		System.out.println(action);
		
		
		if ("inputQuestion".equals(action)) {// 新增考題
			
			inputQuestion(request, response);
		}

		if ("getOne_For_Update".equals(action)) { // 取出要更改的物件
			getOneForUpdate(request, response);

		}
		if ("updateQuestion".equals(action)) { // 更新考題
			updateQuestion(request, response);
		}
		
		if ("listEmps_ByCompositeQuery".equals(action)) {

			compositeQuery(request, response);
		}
	}

	
	private void inputQuestion(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException { // 新增考題
		List<String> errorMsgs = new LinkedList<String>();
		request.setAttribute("errorMsgs", errorMsgs);

		QuestionBankService qse = new QuestionBankService();
		QuestionBankVO QuestionBankvo = new QuestionBankVO();

		String testtype = request.getParameter("testtype");// 題型
		
		
		
		QuestionBankvo.setCourseno(request.getParameter("courseno"));// 課程編號
		
		
		Integer typeno = null;
		try {
			typeno = Integer.parseInt(request.getParameter("typeno"));
		} catch (Exception e) {
			typeno = 0;
			errorMsgs.add("請選擇題型");
		}

		QuestionBankvo.setTypeno(typeno);// 題型編號
		
		QuestionBankvo.setTestscope(request.getParameter("testscope"));// 範圍編號

		String qustmt = request.getParameter("qustmt");// 題目

		if (qustmt == null || qustmt.trim().length() == 0) {
			errorMsgs.add("請輸入題目");
			QuestionBankvo.setQustmt("");
		} else {
			QuestionBankvo.setQustmt(qustmt);
		}

		if ("text".equals(testtype)) {
			String quans = request.getParameter("quans");// 答案
			if (quans == null || quans.trim().length() == 0) {
				errorMsgs.add("請輸入答案");
				QuestionBankvo.setQuans("");
			} else {
				QuestionBankvo.setQuans(quans);
			}
			if (!errorMsgs.isEmpty()) {
				request.setAttribute("QuestionBankvo", QuestionBankvo);
				RequestDispatcher inputView = request.getRequestDispatcher("/front-end/question/inputQuestion.jsp");
				inputView.forward(request, response);
				return;
			}
		} else if ("radio".equals(testtype) || "checkbox".equals(testtype)) {
			String op1 = request.getParameter("op1");// 選項一
			if (op1 == null || op1.trim().length() == 0) {
				errorMsgs.add("請輸入選項A");
				QuestionBankvo.setOp1("");
			} else {
				QuestionBankvo.setOp1(op1);
			}
			String op2 = request.getParameter("op2");// 選項二
			if (op2 == null || op2.trim().length() == 0) {
				errorMsgs.add("請輸入選項B");
				QuestionBankvo.setOp2("");
			} else {
				QuestionBankvo.setOp2(op2);
			}
			String op3 = request.getParameter("op3");// 選項三
			if (op3 == null || op3.trim().length() == 0) {
				errorMsgs.add("請輸入選項C");
				QuestionBankvo.setOp3("");
			} else {
				QuestionBankvo.setOp3(op3);
			}
			String op4 = request.getParameter("op4");// 選項四
			if (op4 == null || op4.trim().length() == 0) {
				errorMsgs.add("請輸入選項D");
				QuestionBankvo.setOp4("");
			} else {
				QuestionBankvo.setOp4(op4);
			}
			String quans = request.getParameter("quans");// 答案
			if (quans == null || quans.trim().length() == 0) {
				errorMsgs.add("請選擇答案選項");
				QuestionBankvo.setOp4("");
			} else {
				StringBuilder ansMaker = new StringBuilder("0000");
				for (int i = 0; i < quans.length(); i++) {
					ansMaker.setCharAt((int) (quans.charAt(i)) - 65, '1');
				}
				QuestionBankvo.setQuans(ansMaker.toString());
			}

			if (!errorMsgs.isEmpty()) {
				request.setAttribute("QuestionBankvo", QuestionBankvo);
				RequestDispatcher inputView = request.getRequestDispatcher("/front-end/question/inputQuestion.jsp");
				inputView.forward(request, response);
				return;
			}

		}
		
		
		QuestionBankvo = qse.insertQuestion(QuestionBankvo);
		
		
//		request.setAttribute("courseno",request.getParameter("courseno"));
//		request.setAttribute("coursename",request.getParameter("coursename"));
//		request.setAttribute("update","update");
		request.setAttribute("QuestionBankvo", QuestionBankvo);
		
		
		
		//test
//		getServletContext().setAttribute("insertQuestionNO", QuestionBankvo.getQbankno());
//		request.getSession().setAttribute("insertQuestionNO", QuestionBankvo.getQbankno());
		
		String url = "/front-end/question/ListOneQuestion.jsp";
		RequestDispatcher successView = request.getRequestDispatcher(url);
		successView.forward(request, response);
	}

	private void getOneForUpdate(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException { // 取出要更新的物件
		List<String> errorMsgs = new LinkedList<String>();
		// Store this set in the request scope, in case we need to
		// send the ErrorPage view.
		request.setAttribute("errorMsgs", errorMsgs);
		try {

			String qbankno = request.getParameter("qbankno");

			QuestionBankService qse = new QuestionBankService();
			QuestionBankVO QuestionBankvo = qse.getOneByNO(qbankno);
			
			
			request.setAttribute("QuestionBankvo", QuestionBankvo);
			String url = "/front-end/question/update_Question_input.jsp";
			RequestDispatcher successView = request.getRequestDispatcher(url);// 成功轉交 update_Question_input.jsp
			successView.forward(request, response);
		} catch (Exception e) {
			errorMsgs.add("無法取得要修改的資料:" + e.getMessage());
			RequestDispatcher failureView = request.getRequestDispatcher("/front-end/question/ListAllQuestion.jsp");
			failureView.forward(request, response);
		}
	}

	private void updateQuestion(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException { // 更新考題
		List<String> errorMsgs = new LinkedList<String>();
		// Store this set in the request scope, in case we need to
		// send the ErrorPage view.
		request.setAttribute("errorMsgs", errorMsgs);

		String testtype = request.getParameter("testtype");
		QuestionBankService qse = new QuestionBankService();
		QuestionBankVO QuestionBankvo = new QuestionBankVO();

		QuestionBankvo.setQbankno(request.getParameter("qbankno"));
		
		QuestionBankvo.setCourseno(request.getParameter("courseno"));
		QuestionBankvo.setTypeno(Integer.parseInt(request.getParameter("typeno")));
		QuestionBankvo.setTestscope(request.getParameter("testscope"));
		
		
		String qustmt = request.getParameter("qustmt");// 題目(必填)
		
		
		if (qustmt == null || qustmt.trim().length() == 0) {
			errorMsgs.add("請輸入題目");
			QuestionBankvo.setQustmt("");
		} else {
			QuestionBankvo.setQustmt(qustmt);
		}

		if ("text".equals(testtype)) {
			String quans = request.getParameter("quans");// 答案
			
			if (quans == null || quans.trim().length() == 0) {
				errorMsgs.add("請輸入答案");
				QuestionBankvo.setQuans("");
			} else {
				QuestionBankvo.setQuans(quans);
			}
			if (!errorMsgs.isEmpty()) {
				request.setAttribute("QuestionBankvo", QuestionBankvo);
				RequestDispatcher inputView = request
						.getRequestDispatcher("/front-end/question/update_Question_input.jsp");
				inputView.forward(request, response);
				return;
			}
		} else if ("radio".equals(testtype) || "checkbox".equals(testtype)) {
			String op1 = request.getParameter("op1");// 選項一
			if (op1 == null || op1.trim().length() == 0) {
				errorMsgs.add("請輸入選項A");
				QuestionBankvo.setOp1("");
			} else {
				QuestionBankvo.setOp1(op1);
			}
			String op2 = request.getParameter("op2");// 選項二
			if (op2 == null || op2.trim().length() == 0) {
				errorMsgs.add("請輸入選項B");
				QuestionBankvo.setOp2("");
			} else {
				QuestionBankvo.setOp2(op2);
			}
			String op3 = request.getParameter("op3");// 選項三
			if (op3 == null || op3.trim().length() == 0) {
				errorMsgs.add("請輸入選項C");
				QuestionBankvo.setOp3("");
			} else {
				QuestionBankvo.setOp3(op3);
			}
			String op4 = request.getParameter("op4");// 選項四
			if (op4 == null || op4.trim().length() == 0) {
				errorMsgs.add("請輸入選項D");
				QuestionBankvo.setOp4("");
			} else {
				QuestionBankvo.setOp4(op4);
			}
			String quans = request.getParameter("quans");// 答案

			if (quans == null || quans.trim().length() == 0) {
				errorMsgs.add("請選擇答案選項");
				QuestionBankvo.setQuans("");
			} else {
				StringBuilder ansMaker = new StringBuilder("0000");
				for (int i = 0; i < quans.length(); i++) {
					ansMaker.setCharAt((int) (quans.charAt(i)) - 65, '1');
				}
				QuestionBankvo.setQuans(ansMaker.toString());

			}

		}
		
		if (!errorMsgs.isEmpty()) {
			request.setAttribute("QuestionBankvo", QuestionBankvo);
			RequestDispatcher inputView = request.getRequestDispatcher("/front-end/question/update_Question_input.jsp");
			inputView.forward(request, response);
			return;
		}
		
		QuestionBankvo = qse.update(QuestionBankvo);
		
		request.setAttribute("QuestionBankvo", QuestionBankvo);
		
		request.setAttribute("courseno",request.getParameter("courseno"));
		request.setAttribute("coursename",request.getParameter("coursename"));
		
		
		RequestDispatcher successView = request.getRequestDispatcher("/front-end/question/ListOneQuestion.jsp");
		successView.forward(request, response);

	}

	private void compositeQuery(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException { // 符合查詢題目
		List<String> errorMsgs = new LinkedList<String>();
		// Store this set in the request scope, in case we need to
		// send the ErrorPage view.
		request.setAttribute("errorMsgs", errorMsgs);

		try {
			
			
			
			HttpSession session = request.getSession();

			Map<String, String[]> map = (Map<String, String[]>) session.getAttribute("map");
			if (request.getParameter("whichPage") == null) {
				HashMap<String, String[]> map1 = new HashMap<String, String[]>(request.getParameterMap());
				session.setAttribute("map", map1);
				map = map1;
			}
			QuestionBankService QuestionBankSvc = new QuestionBankService();
			List<QuestionBankVO> list = QuestionBankSvc.getAll(map);

			request.setAttribute("listEmps_ByCompositeQuery", list); // 資料庫取出的list物件,存入request
			RequestDispatcher successView = request
					.getRequestDispatcher("/front-end/question/ListAllQuestionQuery.jsp");
			successView.forward(request, response);
		} catch (Exception e) {
			errorMsgs.add(e.getMessage());
			RequestDispatcher failureView = request.getRequestDispatcher("/front-end/question/ListAllQuestion.jsp");
			failureView.forward(request, response);
		}

	}
}
