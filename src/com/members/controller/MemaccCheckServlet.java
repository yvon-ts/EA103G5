package com.members.controller;

import java.io.*;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.*;
import javax.servlet.http.*;

import com.members.model.*;
import com.teacher.controller.MailService;

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
		if("getpwd".equals(action)) {
			String memacc = req.getParameter("memacc").toUpperCase();
			String memail = req.getParameter("memail");
			MembersService membersSvc = new MembersService();
			
			MembersVO membersVO =null;
			membersVO= membersSvc.getpwd(memacc, memail);
			
			if (membersVO == null) {
				out.write("non");

			} else {
				MailService mail  = new MailService();
				SimpleDateFormat sdFormat = new SimpleDateFormat("yyyy年MM月dd日 hh時mm分");
				Date date = new Date();
				String strDate = sdFormat.format(date);
				String subject = "Xducation密碼通知";
				String text1 = "誒...."+membersVO.getMemname()+"\n\n\n\n\n\n\n\n\n這是您的密碼\n"+membersVO.getMempwd()+"請妥善保管好嗎\n\n\n\n"
						+ "\n如有任何疑問歡迎隨時與我們聯絡\nXducation營運團隊\n"+strDate;
				
				mail.sendMail(memail, subject, text1);
				out.write("yes");
			}
			out.flush();
			
		}
		
		
		
			
		
				
				
			}
			
			
			
	}

