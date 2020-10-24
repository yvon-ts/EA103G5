package com.lecorder.controller;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.*;

import javax.servlet.*;
import javax.servlet.http.*;

import com.lecorder.model.*;
import com.lecseat.model.*;
import com.lecture.model.*;


public class LodrServlet extends HttpServlet {
	
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
	
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		
		// =========開始新增=========//
		if ("insert".equals(action)) {
			
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			
			try {
				// lecorder
				String memno = req.getParameter("memno"); //待刪除
				String lecno = req.getParameter("lecno").trim();
				Integer lecamt = Integer.parseInt(req.getParameter("lecamt").trim());
				if (lecamt == 0) {
					errorMsgs.add("請選擇座位");
				}
				
				String lodrseat = req.getParameter("currseat");
				System.out.println("original currseat = " + lodrseat);
				if (lodrseat.indexOf("2") != -1) {
					lodrseat = lodrseat.replace("2", "1");
					if (lodrseat.indexOf("*") != -1) {
						lodrseat = lodrseat.replace("*", "2");
					}
				} else if (lodrseat.indexOf("*") != -1) {
					lodrseat = lodrseat.replace("*", "2");
				}
				System.out.println("transformed lodrseat=" + lodrseat);
				
				// lecseat
				String seats = req.getParameter("seatno").trim();
				String[] seatArray = seats.split(" ");
				
				// lecture - layout處理
				String currseat = req.getParameter("currseat");
				if (currseat.indexOf("*") != -1) {
					currseat = currseat.replace("*", "2");
					System.out.println("transfomed currseat = " + currseat);
				}
					
				LodrVO lodrVO = new LodrVO();
				lodrVO.setMemno(memno);
				lodrVO.setLecno(lecno);
				lodrVO.setLecamt(lecamt);
				lodrVO.setLodrseat(lodrseat);
				
				List<LecseatVO> seatList = new ArrayList<LecseatVO>();
				System.out.println("seatNo=");
				for (int i = 0; i < seatArray.length; i++) {
					System.out.println("現在新增座位" + seatArray[i]);
					LecseatVO aSeat = new LecseatVO();
					aSeat.setSeatno(seatArray[i]);
					seatList.add(aSeat);
				}
				
				LecVO lecVO = new LecVO();
				lecVO.setLecno(lecno);
				lecVO.setCurrseat(currseat);
				
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("lodrVO", lodrVO);
					req.setAttribute("seatList", seatList); //好像用不到
					req.setAttribute("lecVO", lecVO);
					RequestDispatcher failureView = req.getRequestDispatcher("/front-end/lecorder/addLodr.jsp");
					failureView.forward(req, res);
					return;
				}
				LodrService lodrSvc = new LodrService();
				lodrSvc.addLodr(lodrVO, seatList, lecVO);
				
				req.setAttribute("memno", memno);
				
				RequestDispatcher successView = req.getRequestDispatcher("/front-end/lecorder/listByMemno.jsp");
				successView.forward(req, res);
				return;
			} catch (Exception e) {
				e.printStackTrace();
			}
			}
		
		// =========開始查詢(好像應該要子查詢，先放著)=========//
		if ("getOne".equals(action)) {
			
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			
			try {
			String lodrno = req.getParameter("lodrno").trim();
			
			LodrService lodrSvc = new LodrService();
			LodrVO lodrVO = lodrSvc.getOne(lodrno);
			
			LecseatService seatSvc = new LecseatService();
			List<LecseatVO> seatList = seatSvc.getSeatsByOrder(lodrno);
			
//			if (!errorMsgs.isEmpty()) {
//				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/lecorder/select_page.jsp");
//				failureView.forward(req, res);
//				return;
//			}
			req.setAttribute("lodrVO", lodrVO);
			req.setAttribute("seatLIst", seatList);
			RequestDispatcher successView = req.getRequestDispatcher("/back-end/lecorder/listOne2.jsp");
			successView.forward(req, res);
			return;
		} catch (Exception e) {
			e.printStackTrace();
		}
		}
	
		// =========開始修改=========//
				if ("update".equals(action)) {
					
					List<String> errorMsgs = new LinkedList<String>();
					req.setAttribute("errorMsgs", errorMsgs);
					
					try {
						// lecorder
						Integer lecamt = Integer.parseInt(req.getParameter("lecamt").trim());
						System.out.println("修改總金額為" + lecamt);
						String lodrseat = req.getParameter("currseat").trim();
						System.out.println("original currseat = " + lodrseat);
						if (lodrseat.indexOf("*") != -1) {
							lodrseat = lodrseat.replace("*", "1");
						}
						System.out.println("transformed lodrseat=" + lodrseat);
						
						Timestamp lodrlmod = new java.sql.Timestamp(System.currentTimeMillis());
						
						// lecseat
						String lecno = req.getParameter("lecno").trim();
						String lodrno = req.getParameter("lodrno").trim();
						System.out.println(lodrno + " / " + lecno);
						String seats = req.getParameter("seatno").trim();
						System.out.println(seats);
						String[] seatArray = seats.split(" ");
						
						// lecture - layout處理
						LecService lecSvc = new LecService();
						LecVO lvo = lecSvc.getOne(lecno);
						String currseat = lvo.getCurrseat();
						System.out.println("original lecseat = " + currseat);
						String seatStr = req.getParameter("currseat").trim();
						if (seatStr.indexOf("*") != -1) {
							seatStr = seatStr.replace("*", "3");
						}
						for (int i = 0; i < seatStr.length(); i++) {
							if (seatStr.charAt(i) == '3') {
								String head = currseat.substring(0, i);
								String foot = currseat.substring(i + 1);
								currseat = head + "1" + foot;
							}
						}
						System.out.println("transfomed currseat = " + currseat);
						
//						while (seatStr.indexOf("3") != -1) {
//							int index = seatStr.indexOf("3");
//							String head = currseat.substring(0, index);
//							String foot = currseat.substring(index + 1);
//							currseat = head + "1" + foot;
//						}
						
						Timestamp leclmod = new java.sql.Timestamp(System.currentTimeMillis());
							
						LodrVO lodrVO = new LodrVO();
						lodrVO.setLecamt(lecamt);
						lodrVO.setLodrseat(lodrseat);
						lodrVO.setLodrlmod(lodrlmod);
						lodrVO.setLodrno(lodrno);
						
						List<LecseatVO> seatList = new ArrayList<LecseatVO>();
						for (int i = 0; i < seatArray.length; i++) {
							System.out.println("現在刪除座位" + seatArray[i]);
							LecseatVO aSeat = new LecseatVO();
							aSeat.setLodrno(lodrno);
							aSeat.setSeatno(seatArray[i]);
							seatList.add(aSeat);
						}
						
						LecVO lecVO = new LecVO();
						lecVO.setLecno(lecno);
						lecVO.setCurrseat(currseat);
						lecVO.setLeclmod(leclmod);
						
						if (!errorMsgs.isEmpty()) {
							req.setAttribute("lodrVO", lodrVO);
							req.setAttribute("seatList", seatList); //好像用不到
							req.setAttribute("lecVO", lecVO);
							RequestDispatcher failureView = req.getRequestDispatcher("/front-end/lecseat/listOneForMem.jsp");
							failureView.forward(req, res);
							return;
						}
						LodrService lodrSvc = new LodrService();
						lodrSvc.updateLodr(lodrVO, seatList, lecVO);
						
						req.setAttribute("lodrno", lodrno);
						
						RequestDispatcher successView = req.getRequestDispatcher("/front-end/lecseat/listOneForMem.jsp");
						successView.forward(req, res);
						return;
					} catch (Exception e) {
						e.printStackTrace();
					}
					}
	}

}
