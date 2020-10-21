package com.lecseat.controller;

import java.io.IOException;

import javax.servlet.*;
import javax.servlet.http.*;

public class LecseatServlet extends HttpServlet {
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");

//		// =========開始修改=========//
//		if ("update".equals(action)) {
//
//			List<String> errorMsgs = new LinkedList<String>();
//			req.setAttribute("errorMsgs", errorMsgs);
//
//			try {
//				// lecseat
//				String lodrno = req.getParameter("lodrno").trim();
//				System.out.println(lodrno);
//				String seats = req.getParameter("seatno").trim();
//				System.out.println(seats);
//				String[] seatArray = seats.split(" ");
//				
//				//lecorder
//				Integer lecamt = Integer.parseInt(req.getParameter("lecamt").trim());
//				System.out.println("修改總金額為" + lecamt);
//				String lodrseat = req.getParameter("currseat").trim();
//				System.out.println("original currseat = " + lodrseat);
//				if (lodrseat.indexOf("*") != -1) {
//					lodrseat = lodrseat.replace("*", "1");
//				}
//				System.out.println("transformed lodrseat=" + lodrseat);
//				
//				Timestamp lodrlmod = new java.sql.Timestamp(System.currentTimeMillis());
//				LodrService lodrSvc = new LodrService();
//				LodrVO lodrVO = lodrSvc.getOne(lodrno);
////
////				req.setAttribute("seatList", seatList);
////				req.setAttribute("lodrVO", lodrVO);
//				
//				LecseatService seatSvc = new LecseatService();
//				for (int i = 0; i < seatArray.length; i++) {
//					LecseatVO aSeat = new LecseatVO();
//					aSeat.setLodrno(lodrno);
//					aSeat.setSeatno(seatArray[i]);
//					seatSvc.updateOne(aSeat,); // 這裡要改
//				}
//				
//				RequestDispatcher successView = req.getRequestDispatcher("/success.jsp");
//				successView.forward(req, res);
//				return;
//			} catch (Exception e) {
//				e.printStackTrace();
//			}
//		}

	}

}
