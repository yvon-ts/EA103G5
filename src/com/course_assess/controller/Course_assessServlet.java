package com.course_assess.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.LinkedList;
import java.util.List;
import org.json.JSONArray;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.course_assess.model.Course_assessService;
import com.course_assess.model.Course_assessVO;
import com.members.model.MembersService;
import com.teacher.model.TeacherService;

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
				
				if("update".equals(action)) {
					update(req,res);
				}
				if("getAll".equals(action)) {
					getAll(req,res);
				}
		
		
		
	}
	
	private void getAll(HttpServletRequest req, HttpServletResponse res)throws ServletException, IOException{
		List<String> errorMsgs = new LinkedList<String>();

		req.setAttribute("errorMsgs", errorMsgs);
		
		try {
			Course_assessService course_assessSvc = new Course_assessService();
			MembersService membersSvc = new MembersService();
			TeacherService teacherSvc = new TeacherService();
			
			String courseno = req.getParameter("courseno");
			List<Course_assessVO>list = course_assessSvc.getAll(courseno);
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd HH:mm:ss");
			
			 for(Course_assessVO vo: list) {
				vo.setNkname(membersSvc.getOneMembers(vo.getMemno()).getNkname());
				vo.setTchrstatus(teacherSvc.getStatus(vo.getMemno()).getTchrstatus());
				Date date = vo.getCommenttime();
				vo.setString_commenttime(new SimpleDateFormat("yyyy年MM月dd日 HH時:mm分").format(date));
			 }
			
			
			
			
			
			
			
			String str = new JSONArray(list).toString();
			
			res.setContentType("text/plain");
			res.setCharacterEncoding("UTF-8");
			PrintWriter out = res.getWriter();
			out.write(str);
			out.flush();
			out.close();
			
			
			
		} catch (Exception e) {
			errorMsgs.add("無法取得資料:" + e.getMessage());
			RequestDispatcher failureView = req.getRequestDispatcher("新增失敗小視窗.jsp");
			failureView.forward(req, res);
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
			String url = req.getContextPath()+ "/index/front-index/index.jsp";
			res.sendRedirect(url);
		}
		
		Course_assessService course_assessSvc = new Course_assessService();
		course_assessSvc.addCourse_assess(courseno, memno, coursescore, comments);
		String inform5 = "200";
		req.setAttribute("inform5", inform5);
		RequestDispatcher SuccessView = req.getRequestDispatcher("/front-end/course_assess/listAllAjax.jsp");
		SuccessView.forward(req, res);
		return;
		
		
		
		
	}

		
	
	private void update(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException{
		String asesno = req.getParameter("asesno");
		String cs = req.getParameter("coursescore");
		Integer coursescore = Integer.parseInt(cs);
		String comments = req.getParameter("comments");
		if (comments == null || comments.trim().length() == 0) {
			comments = "這是一門很\"固固\"的課程唷^^d";
			}else if(comments.length()>=40) {
				String url = req.getContextPath()+ "/index/front-index/index.jsp";
				res.sendRedirect(url);
			}
		String inform5 = "100";
		req.setAttribute("inform5", inform5);
		Course_assessService course_assessSvc = new Course_assessService();
		course_assessSvc.updateCourse_assess(asesno, coursescore, comments);
		RequestDispatcher SuccessView = req.getRequestDispatcher("/front-end/course_assess/listAllAjax.jsp");
		SuccessView.forward(req, res);
		return;
	}
	
	

	
	
	
}
