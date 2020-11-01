package com.members.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.members.model.MembersService;

public class MemdeleteSwichServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");// 處理中文檔名
		res.setContentType("text/html; charset=UTF-8");
		PrintWriter out = res.getWriter();
		String memno = req.getParameter("memno");
		System.out.println(memno);
		MembersService membersSvc = new MembersService();
		int a = membersSvc.updateStatusMembers(memno);
		if(a==0) {
			out.write("已啟用");
			
			
		}else {
			out.write("已註銷");
		}
		out.flush();
		
		
		
		
	}

}
