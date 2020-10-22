package com.course_assess.controller;

import java.io.IOException;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.course_assess.model.Course_assessService;

public class Course_assessServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req,res);
		
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");// 處理中文檔名
		res.setContentType("text/html; charset=UTF-8");

		String action = req.getParameter("action");
		//===================以下為新增會員區塊======================
				if ("insert".equals(action)) {
					insert(req, res);
				}
		
		
		
	}
	private void insert(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		String memno = req.getParameter("memno");
		
		String courseno = req.getParameter("courseno");
		String cs = req.getParameter("coursescore");
		
		if(cs == null || cs.trim().length() == 0) {
			cs = "5";
		}
		Integer coursescore = Integer.parseInt(cs);
		String comments = req.getParameter("comments");
		if (comments == null || comments.trim().length() == 0) {
		comments = "這是一門很\"固固\"的課程唷^^d";
		}else if(comments.length()>=40) {
			String url = req.getContextPath()+ "/front-end/members/indexV1.jsp";
			res.sendRedirect(url);
		}
		
		Course_assessService course_assessSvc = new Course_assessService();
		course_assessSvc.addCourse_assess(courseno, memno, coursescore, comments);
		RequestDispatcher SuccessView = req.getRequestDispatcher("/front-end/course_assess/addCourse_assess.jsp");
		SuccessView.forward(req, res);
		return;
		
		
		
		
	}

}
