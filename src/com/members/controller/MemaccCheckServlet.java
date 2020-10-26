package com.members.controller;

import java.io.*;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.*;
import javax.servlet.http.*;

import com.members.model.*;

public class MemaccCheckServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");// 處理中文檔名
		res.setContentType("text/html; charset=UTF-8");
		PrintWriter out = res.getWriter();
		String action = req.getParameter("action");
		
		if("memailCheck".equals(action)) {
			
			String memail = req.getParameter("memail");
			System.out.println(action);
			System.out.println(memail);
			MembersService membersSvc = new MembersService();
			int a = membersSvc.checkMemail(memail);
			if (a == 0) {
				out.write("non");

			} else {
				out.write("yes");
			}
			out.flush();
			
		}
		
		
		if("memaccCheck".equals(action)) {
			String memaccCheck = req.getParameter("memacc");
			MembersService membersSvc = new MembersService();
			int a = membersSvc.checkMemacc(memaccCheck);
			
			if (a == 0) {
				out.write("non");

			} else {
				out.write("yes");
			}
			out.flush();
			
		}
		if("memail".equals(action)) {
			String memaccCheck = req.getParameter("memacc");
			
			MembersService membersSvc = new MembersService();
			int a = membersSvc.checkMemacc(memaccCheck);
			
			if (a == 0) {
				out.write("non");

			} else {
				out.write("yes");
			}
			out.flush();
			
		}
		
		
		
			
		
				
				
			}
			
			
			
	}

