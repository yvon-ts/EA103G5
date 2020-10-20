package com.question_bank.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.anwser_list.model.AnwserListService;
import com.anwser_list.model.AnwserListVO;
import com.question_bank.model.QuestionBankService;
import com.question_bank.model.QuestionBankVO;
import com.tests.model.TestsService;
import com.tests.model.TestsVO;

public class QuestionBankServlet_old extends HttpServlet {
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		doPost(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {

		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");

		String action = request.getParameter("action");

		if ("correct".equals(action)) { // 對答案
			correct(request, response);
		}

		if ("printPaper".equals(action)) {// 印考卷
			printPaper(request, response);
		}
		if ("reviewByTestNo".equals(action)) {// 查看某次考試編號測驗卷
			reviewByTestNo(request, response);
		}

		if ("inputQuestion".equals(action)) {// 新增考題
			inputQuestion(request, response);
		}

		if ("getOne_For_Update".equals(action)) { // 取出要更改的物件
			getOneForUpdate(request, response);

		}
		if ("updateQuestion".equals(action)) { // 更新考題
			updateQuestion(request, response);
		}
		System.out.println(action);
		if ("listEmps_ByCompositeQuery".equals(action)) {

			compositeQuery(request, response);
		}
	}

	private void correct(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {// 對答案
		Enumeration<String> enums = request.getParameterNames();
		Map<String, String> studentAns = new HashMap<>();

		AnwserListService ase = (AnwserListService) request.getSession().getAttribute("ase");
		TestsService tse = (TestsService) request.getSession().getAttribute("tse");
		QuestionBankService qse = new QuestionBankService();

		while (enums.hasMoreElements()) {
			StringBuilder ansBox = new StringBuilder("0000");
			String name = (String) enums.nextElement();
			String value[] = request.getParameterValues(name);

			if (value != null && !(value[0].equals("correct"))) {
				if (qse.getOneByNO(name).getOp1() == null) {
					studentAns.put(name, value[0]);
				} else {
					for (int i = 0; i < value.length; i++) {
						ansBox.setCharAt(Integer.parseInt(value[i]), '1');
					}
					studentAns.put(name, ansBox.toString());
				}
			}
			ase.submitAns(studentAns, tse.getTestno());
		}
		tse.writeScore(ase.compareToAns(tse.getTestno()), tse.getTestno());

		RequestDispatcher ResultView = request.getRequestDispatcher("/front-end/question/Result.jsp");
		ResultView.forward(request, response);
	}

	private Set<QuestionBankVO> pickFromDB(int setting, int number) { // 亂數撈題目
		double[] typeNumber = new double[] { number * 0.2, number * 0.4, number * 0.4 };
		QuestionBankService qse = new QuestionBankService();

		Set<QuestionBankVO> set = new HashSet<>();
		List<QuestionBankVO> list = new ArrayList<>();
		int total = 0;

		for (int i = 0; i < 3; i++) {
			list = qse.findArea(setting + 3 * i);
			total += typeNumber[i];
			while (set.size() < total) {
				set.add(list.get((int) (Math.random() * (list.size()))));
			}
		}

		return set;
	}

	public List<AnwserListVO> produce(List<QuestionBankVO> list) { // 選項亂數

		List<AnwserListVO> AnwserListVoList = new ArrayList<>();
		AnwserListVO AnwserListVo = null;
		Collections.shuffle(list);
		/*
		 * Collections.shuffle(List<?> list) Randomly permutes the specified list using
		 * a default source of randomness.
		 */
		/* 對傳入的List進行洗牌，會更動原先list的順序 */
		int quno = 0;

		for (QuestionBankVO q : list) {
			AnwserListVo = new AnwserListVO();
			StringBuilder testans = new StringBuilder();
			StringBuilder quans = new StringBuilder();
			StringBuilder oporder = new StringBuilder();

//---------------------------處理填充題---------------------------------				
			if (q.getOp1() == null) {// op1為空即為填空題
				oporder.append("none");// 因此沒有順序
				testans.append(q.getQuans());// 正解直接加入testans
			} else {
//---------------------------處理單/多選題---------------------------------	
				testans.append("0000");
				List<String> optionList = q.getOptionList();// 原本選項順序
				List<String> randomOption = new ArrayList<>(optionList);// 新的選項順序
				Collections.shuffle(randomOption);// 將新的選項順序打亂
//------------------------------------------亂數選項對應全題目選項的順序處理---------------------------------				
				for (int i = 0; i < optionList.size(); i++) {
					oporder.append(optionList.indexOf(randomOption.get(i)));
				}

				/*---------------------------------------------------------------------------------------------------
												
												原本的選項順序        對應                答案順序
												  0 1 2 3   ---------->   0 0 1 0		step 1 : 先找目前答案的位置，example:目前2的位置(以0起算)
												
												打亂的選項順序        對應                答案順序		step 2 : 再去打亂後的選項找到2的索引位置，即為答案(建一個"0000"將找到索引改為1)
												  3 2 0 1   ---------->   0 1 0 0
												 
								*/

//---------------------------找出原本選項答案位置(1--->正解)-----------------
				int p = 0;
				while ((q.getQuans().indexOf('1', p)) != -1) {
					quans.append(q.getQuans().indexOf('1', p));
					p = q.getQuans().indexOf('1', p) + 1;
				}
//---------------------------透過上面的答案紀錄的位置，去亂數後的順序找相對的位置，即為打亂後的順序-----------------				
				for (int i = 0; i < quans.toString().length(); i++) {
					if (oporder.indexOf(String.valueOf(quans.charAt(i))) != -1) {
						testans.setCharAt(oporder.indexOf(String.valueOf(quans.charAt(i))), '1');
					}
				}
				q.setOptionList(randomOption);
			}

			AnwserListVo.setQbankno(q.getQbankno());
			AnwserListVo.setQuno(++quno);
			AnwserListVo.setTestans(testans.toString());
			AnwserListVo.setOporder(oporder.toString());
			AnwserListVoList.add(AnwserListVo);
		}

		return AnwserListVoList;
	}

	private void printPaper(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException { // 印考卷

		String level = request.getParameter("level");

		List<String> errorMsgs = new LinkedList<String>();
		request.setAttribute("errorMsgs", errorMsgs);

		if ("-1".equals(level)) {
			errorMsgs.add("請點選難易度");
			RequestDispatcher failureView = request.getRequestDispatcher("/front-end/question/SelectedQuestion.jsp");
			failureView.forward(request, response);
		}

		AnwserListService ase = new AnwserListService();
		List<AnwserListVO> randomQuestion = new ArrayList<>();

		TestsService tse = new TestsService();
		TestsVO testsVo = new TestsVO();
		testsVo.setCourseno("COUR0001");
		testsVo.setMemno("MEM0001");
		testsVo.setTestscope("1");

		List<QuestionBankVO> QuestionList = new ArrayList<>();
		int number = 20;
		if ("simple".equals(level)) {
			QuestionList.addAll(pickFromDB(1, number));
			randomQuestion = produce(QuestionList);
		} else if ("medium".equals(level)) {
			QuestionList.addAll(pickFromDB(1, number / 2));
			QuestionList.addAll(pickFromDB(2, number / 2));
			randomQuestion = produce(QuestionList);
		} else if ("hard".equals(level)) {
			QuestionList.addAll(pickFromDB(1, number / 4));
			QuestionList.addAll(pickFromDB(2, number / 4));
			QuestionList.addAll(pickFromDB(3, number / 2));
			randomQuestion = produce(QuestionList);
		}

		tse.insertToAnwserList(testsVo, randomQuestion);// 之後要抓取會員編號、課程編號與範圍編號

		try {

			request.getSession().setAttribute("ase", ase);
			request.getSession().setAttribute("tse", tse);
			request.getSession().setAttribute("list", QuestionList);
			RequestDispatcher dispatcher = request.getRequestDispatcher("/front-end/question/PrintQuestion.jsp");
			dispatcher.forward(request, response);
		} catch (ServletException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	private void reviewByTestNo(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException { // 查看答案紀錄
		String selectedTestno = request.getParameter("selectedTestno");
		TestsService tse = new TestsService(selectedTestno);
		AnwserListService ase = new AnwserListService();
		QuestionBankService qse = new QuestionBankService();

		List<AnwserListVO> aselist = ase.getTestData(selectedTestno);// 取道當次測驗的題目，順序尚未更改(只從DB中取出)

		List<QuestionBankVO> qblist = new ArrayList<>();// 選項已更改當次測驗的選項順序

		for (AnwserListVO vo : aselist) {

			QuestionBankVO qbvo = qse.getOneByNO(vo.getQbankno());// 找那道題

			if (!"none".equals(vo.getOporder())) {// 製作跟歷史紀錄一樣的選項順序

				String[] oporderArray = vo.getOporder().split("");// 取出當次的選項順序

				List<String> optionList = qbvo.getOptionList();// 該題原本順序選項
				List<String> oldOption = new ArrayList<>(); // 先前亂數後的選項

				for (int i = 0; i < oporderArray.length; i++) {
					oldOption.add(optionList.get(Integer.parseInt(oporderArray[i])));
				}

				qbvo.setOptionList(oldOption);
			}

			qblist.add(qbvo);

		}
		request.getSession().setAttribute("ase", ase);
		request.getSession().setAttribute("tse", tse);
		request.getSession().setAttribute("list", qblist);
		RequestDispatcher ResultView = request.getRequestDispatcher("/front-end/question/Result.jsp");
		ResultView.forward(request, response);
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
		request.setAttribute("QuestionBankvo", QuestionBankvo);
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
			System.out.println(quans.isEmpty());
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
		String url = "/front-end/question/ListOneQuestion.jsp";
		RequestDispatcher successView = request.getRequestDispatcher(url);
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
				;
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
