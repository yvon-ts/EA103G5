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
import com.members.model.MembersVO;
import com.question_bank.model.QuestionBankService;
import com.question_bank.model.QuestionBankVO;
import com.tests.model.TestsService;
import com.tests.model.TestsVO;

public class QuestionTestServlet extends HttpServlet {
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

	}

	private void correct(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {// 對答案
		
		
		
		Enumeration<String> enums = request.getParameterNames();
		Map<String, String> studentAns = new HashMap<>();

		AnwserListService ase = new AnwserListService();
		TestsService tse = new TestsService();
		QuestionBankService qse = new QuestionBankService();

		
		
		
		while (enums.hasMoreElements()) {
			StringBuilder ansBox = new StringBuilder("0000");
			String name = (String) enums.nextElement();
			String value[] = request.getParameterValues(name);
			
			
				
			if (value != null && !value[0].equals("correct") && !"testno".equals(name) && !"courseno".equals(name)) {
				if (qse.getOneByNO(name).getOp1() == null) {
					studentAns.put(name, value[0]);
				} else {
					for (int i = 0; i < value.length; i++) {
						ansBox.setCharAt(Integer.parseInt(value[i]), '1');
					}
					studentAns.put(name, ansBox.toString());
				}
			}else if("testno".equals(name)) {
				tse.setTestno(value[0]);
			}
			ase.submitAns(studentAns, tse.getTestno());
			
		}
		tse.writeScore(ase.compareToAns(tse.getTestno()), tse.getTestno());
		
		request.setAttribute("testsVo", tse.getOneByNO(tse.getTestno()));
		
		RequestDispatcher ResultView = request.getRequestDispatcher("/front-end/test/Result.jsp");
		ResultView.forward(request, response);
	}

	private Set<QuestionBankVO> pickFromDB(int setting, int number,String courseno) { // 亂數撈題目
		double[] typeNumber = new double[] { number * 0.2, number * 0.4, number * 0.4 };
		QuestionBankService qse = new QuestionBankService();

		Set<QuestionBankVO> set = new HashSet<>();
		List<QuestionBankVO> list = new ArrayList<>();
		int total = 0;

		for (int i = 0; i < 3; i++) {
			list = qse.findArea(setting + 3 * i, courseno);
			
			if(list.size()==0) {
				return null;
			}
			total += typeNumber[i];
			while (set.size() < total) {
				set.add(list.get((int) (Math.random() * (list.size()))));
			}
		}
		return set;
	}

	public List<AnwserListVO> produce(List<QuestionBankVO> list,String questionNO) { // 選項亂數
		
		QuestionBankService qse = new QuestionBankService();
		
		List<AnwserListVO> AnwserListVoList = new ArrayList<>();
		AnwserListVO AnwserListVo = null;
		Collections.shuffle(list);
		
		
		
		if(qse.getOneByNO(questionNO) != null) {
			list.set(0, qse.getOneByNO(questionNO));
		}
		
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

		
		String questionNO = (String)request.getSession().getAttribute("insertQuestionNO");
		

		List<String> errorMsgs = new LinkedList<String>();
		request.setAttribute("errorMsgs", errorMsgs);

		AnwserListService ase = new AnwserListService();
		List<AnwserListVO> randomQuestion = new ArrayList<>();

		TestsService tse = new TestsService();
		TestsVO testsVo = new TestsVO();
		
		String level = request.getParameter("level");
		MembersVO membersVO = (MembersVO) request.getSession().getAttribute("loginMembersVO");
		String courseno = request.getParameter("courseno");
		
		String unit = request.getParameter("unit");//單元不做了
		
		testsVo.setCourseno(courseno);//課程編號
		testsVo.setMemno(membersVO.getMemno());
		testsVo.setTestscope(unit);//單元

		List<QuestionBankVO> QuestionList = new ArrayList<>();
		Set<QuestionBankVO> set = new HashSet();
		int number = 10;
		
		
		if ("simple".equals(level)) {
			
			set = pickFromDB(1, number,courseno);
			
			if(set != null) {
				QuestionList.addAll(set);
				randomQuestion = produce(QuestionList,questionNO);
			}
			
		} else if ("medium".equals(level)) {
			
			set = pickFromDB(1, number / 2,courseno);
			
			if(set != null) {
				QuestionList.addAll(set);
				QuestionList.addAll(pickFromDB(2, number / 2,courseno));
				randomQuestion = produce(QuestionList,questionNO);
			}
			
		} else if ("hard".equals(level)) {
			set = pickFromDB(1, number / 4 ,courseno);
			
			if(set != null) {
				QuestionList.addAll(set);
				QuestionList.addAll(pickFromDB(2, number / 4 ,courseno));
				QuestionList.addAll(pickFromDB(3, number / 2 ,courseno));
				randomQuestion = produce(QuestionList,questionNO);
			}
			
		}
		
			if(set == null) {
				errorMsgs.add("尚無測驗題目");
				RequestDispatcher dispatcher = request.getRequestDispatcher("/course/course.do?action=showCourseMainPage&courseno="+courseno);
				dispatcher.forward(request, response);
				return ;
			}
		

		String testno = tse.insertToAnwserList(testsVo, randomQuestion);
		
		
		try {
			request.setAttribute("testno", testno);
			request.getSession().setAttribute("QuestionList", QuestionList);
			RequestDispatcher dispatcher = request.getRequestDispatcher("/front-end/test/PrintQuestion.jsp");
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
		
		TestsService tse = new TestsService();
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
		request.setAttribute("testsVo", tse.getOneByNO(selectedTestno));
		request.getSession().setAttribute("QuestionList", qblist);
		request.getSession().setAttribute("courseno",tse.getOneByNO(selectedTestno).getCourseno());
		
		
		RequestDispatcher ResultView = request.getRequestDispatcher("/front-end/test/Result.jsp");
		ResultView.forward(request, response);
	}

	
}
