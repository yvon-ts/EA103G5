package com.course.controller;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.course.model.CourseService;
import com.course.model.CourseVO;


public class CourseForPhoto extends HttpServlet {

	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		System.out.println("***action = " + action);

		if ("searchPhoto".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			try {

				String courseno = req.getParameter("courseno");
				System.out.println(courseno);

				CourseService CSvc = new CourseService();
				CourseVO vo = CSvc.getOneCourse(courseno);

				res.setContentType("image/jpeg");
				ServletOutputStream out = res.getOutputStream();

				ByteArrayInputStream bin = new ByteArrayInputStream(vo.getCourseimg());

				byte[] buffer = new byte[4 * 1024];

				int len = 0;

				while ((len = bin.read(buffer)) != -1) {
					out.write(buffer, 0, len);
					out.flush();
				}
				bin.close();
			} catch (Exception e) {
				errorMsgs.add("無法取得資料: " + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/front-end/course/select_page.jsp");
				failureView.forward(req, res);
			}

		}

	}
}
