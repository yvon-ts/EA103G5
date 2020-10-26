package com.course.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.course.model.*;
import com.google.gson.Gson;

@MultipartConfig
@WebServlet("/CourseServlet_Ajax")
public class CourseServlet_Ajax extends HttpServlet {
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		Gson gson = new Gson();

		req.setCharacterEncoding("UTF-8");
		res.setContentType("text/plain; charset=UTF-8");
		PrintWriter out = res.getWriter();
		
		String action = req.getParameter("action");

		System.out.println("*X*X*action = " + action);
		
		// 更新課程狀態 (後台)
		if ("updateCourseStatus".equals(action)) {
			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
				String courseno = req.getParameter("courseno");
				String csstatus = req.getParameter("csstatus");

				String csstatusRegex = "審核中|上架|下架";
				if (csstatus == null || csstatus.trim().length() == 0) {
					out.print("錯誤：請選擇課程狀態");
					return;
				} else if (!csstatus.trim().matches(csstatusRegex)) { // 以下練習正則(規)表示式(regular-expression)
					out.print("錯誤：課程狀態只能是 審核中|上架|下架");
					return;
				}
				CourseService courseSvc = new CourseService();
				/*************************** 2.開始新增資料 *****************************************/
				courseSvc.updateCourseStatus(courseno, csstatus);
				/*************************** 3.查詢完成,準備轉交(Send the Success view) *************/
				out.print("成功更新課程  " + courseno + " 為 " + csstatus + " 狀態");
				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				out.println("無法新增資料: " + e.getMessage());
				return; // 中斷程式
			}
		}
	}

}
