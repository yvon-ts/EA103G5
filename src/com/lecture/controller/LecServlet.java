package com.lecture.controller;

import java.io.*;
import java.nio.charset.StandardCharsets;
import java.util.*;

import javax.servlet.*;
import javax.servlet.http.*;

import com.lecture.model.*;

public class LecServlet extends HttpServlet {
	
	public static byte[] getByteArray(String str) throws IOException{
		return str.getBytes(StandardCharsets.UTF_8);
	}
	
	public static byte[] getFileByteArray(InputStream in) throws IOException{
		ByteArrayOutputStream baos = new ByteArrayOutputStream();
		byte[] buffer = new byte[8192];
		int i;
		while((i = in.read(buffer)) != -1) {
			baos.write(buffer, 0, i);
			baos.flush();
		}
		baos.close();
		return baos.toByteArray();
	}

	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}
	
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
	
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		
		System.out.println(action);
		
		//====================================開始新增====================================//
		if ("insert".equals(action)) {
			System.out.println("有進來");
			
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			
			try {
			
				String lecname = req.getParameter("lecname").trim();
				if (lecname == null || lecname.length() == 0) {
					errorMsgs.add("請輸入講座名稱");
				} else if (lecname.length() > 16 || lecname.length() < 2) {
					errorMsgs.add("講座名稱限中英文2-16字");
				}
				String spkrno = req.getParameter("spkrno").trim();
				String roomno = req.getParameter("roomno").trim();
				String priceStr = req.getParameter("lecprice").trim();
				
				if (priceStr == null || priceStr.length() == 0) {
					errorMsgs.add("請輸入講座票價");
				} else if (!priceStr.matches("[1-9]{1}[0-9]{1,5}")) {
					errorMsgs.add("請輸入6位數以內的數字");
				}
				Integer lecprice = Integer.parseInt(priceStr);
				
				
				/***********************開始時間***********************/
				java.sql.Timestamp lecstart = null;
				try {
					lecstart = java.sql.Timestamp.valueOf(req.getParameter("lecstart").trim());
				} catch (IllegalArgumentException e) {
					lecstart = new java.sql.Timestamp(System.currentTimeMillis());
					errorMsgs.add("時間錯誤 servlet 47");
				}
				/***********************結束時間***********************/
				java.sql.Timestamp lecend = null;
				try {
					lecend = java.sql.Timestamp.valueOf(req.getParameter("lecend").trim());
				} catch (IllegalArgumentException e) {
					lecend= new java.sql.Timestamp(System.currentTimeMillis());
					errorMsgs.add("時間錯誤 servlet 56");
				}
				/***********************報名開始***********************/
				java.sql.Timestamp signstart = null;
				try {
					signstart = java.sql.Timestamp.valueOf(req.getParameter("signstart").trim());
				} catch (IllegalArgumentException e) {
					signstart = new java.sql.Timestamp(System.currentTimeMillis());
					errorMsgs.add("時間錯誤 servlet 64");
				}
				/***********************報名結束***********************/
				java.sql.Timestamp signend = null;
				try {
					signend = java.sql.Timestamp.valueOf(req.getParameter("signend").trim());
				} catch (IllegalArgumentException e) {
					signend = new java.sql.Timestamp(System.currentTimeMillis());
					errorMsgs.add("時間錯誤 servlet 72");
				}
				/***********************座位及講座資訊設定***********************/
				String initseat = req.getParameter("initseat");
				String currseat = req.getParameter("currseat");
				String infoString = req.getParameter("lecinfo");
				byte[] lecinfo = getByteArray(infoString);
				/***********************圖片設定***********************/
				byte[] lecpic = null;
				Part part = req.getPart("lecpic");
				
				if (part == null) {
					errorMsgs.add("請上傳圖片");
				} else if (part.getContentType().indexOf("image/jpeg") < 0 && part.getContentType().indexOf("image/gif") < 0 && part.getContentType().indexOf("image/png") < 0) {
					System.out.println(part.getContentType());
					errorMsgs.add("僅支援.jpg .jpeg .gif .png 格式");
				}
				InputStream in = part.getInputStream();
				lecpic = getFileByteArray(in);
				in.close();
				
				LecVO lecVO = new LecVO();
				lecVO.setLecname(lecname);
				lecVO.setLecprice(lecprice);
				lecVO.setSpkrno(spkrno);
				lecVO.setRoomno(roomno);
				lecVO.setLecstart(lecstart);
				lecVO.setLecend(lecend);
				lecVO.setSignstart(signstart);
				lecVO.setSignend(signend);
				lecVO.setInitseat(initseat);
				lecVO.setCurrseat(currseat);
				lecVO.setLecinfo(lecinfo);
				lecVO.setLecpic(lecpic);
				req.setAttribute("lecVO", lecVO);
				
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/lecture/addLec.jsp");
					failureView.forward(req, res);
					return;
				}
			/***********************驗證完畢***********************/	
				LecService lecSvc = new LecService();
				lecVO = lecSvc.addLec(lecname, lecprice, spkrno, roomno, lecstart, lecend, signstart, signend, initseat, currseat, lecinfo, lecpic);
				
				RequestDispatcher successView = req.getRequestDispatcher("/back-end/lecture/listAllLec.jsp"); 
				successView.forward(req, res);
				
			} catch (Exception e) {
				e.printStackTrace();
				
			}
		}
		//====================================開始修改====================================//
				if ("update".equals(action)) {
					
					List<String> errorMsgs = new LinkedList<String>();
					req.setAttribute("errorMsgs", errorMsgs);
					
					try {
						String lecno = req.getParameter("lecno");
						String lecname = req.getParameter("lecname").trim();
						if (lecname == null || lecname.length() == 0) {
							errorMsgs.add("請輸入講座名稱");
						} else if (lecname.length() > 16 || lecname.length() < 2) {
							errorMsgs.add("講座名稱限中英文2-16字");
						}
						String spkrno = req.getParameter("spkrno");
						String roomno = req.getParameter("roomno");
						String priceStr = req.getParameter("lecprice").trim();
						
						if (priceStr == null || priceStr.length() == 0) {
							errorMsgs.add("請輸入講座票價");
						} else if (!priceStr.matches("[1-9]{1}[0-9]{1,5}")) {
							errorMsgs.add("請輸入6位數以內的數字");
						}
						Integer lecprice = Integer.parseInt(priceStr);
						
						
						/***********************講座開始***********************/
						java.sql.Timestamp lecstart = null;
						try {
							lecstart = java.sql.Timestamp.valueOf(req.getParameter("lecstart").trim());
						} catch (IllegalArgumentException e) {
							lecstart = new java.sql.Timestamp(System.currentTimeMillis());
							errorMsgs.add("時間錯誤 servlet 130");
						}
						/***********************講座結束***********************/
						java.sql.Timestamp lecend = null;
						try {
							lecend = java.sql.Timestamp.valueOf(req.getParameter("lecend").trim());
						} catch (IllegalArgumentException e) {
							lecend= new java.sql.Timestamp(System.currentTimeMillis());
							errorMsgs.add("時間錯誤 servlet 138");
						}
						/***********************報名開始***********************/
						java.sql.Timestamp signstart = null;
						try {
							signstart = java.sql.Timestamp.valueOf(req.getParameter("signstart").trim());
						} catch (IllegalArgumentException e) {
							signstart = new java.sql.Timestamp(System.currentTimeMillis());
							errorMsgs.add("時間錯誤 servlet 147");
						}
						/***********************報名結束***********************/
						java.sql.Timestamp signend = null;
						try {
							signend = java.sql.Timestamp.valueOf(req.getParameter("signend").trim());
						} catch (IllegalArgumentException e) {
							signend = new java.sql.Timestamp(System.currentTimeMillis());
							errorMsgs.add("時間錯誤 servlet 154");
						}
						/***********************講座狀態/座位/資訊***********************/
						String initseat = req.getParameter("initseat");
						String currseat = req.getParameter("currseat");
						Integer lecstatus = Integer.parseInt(req.getParameter("lecstatus"));
						String infoString = req.getParameter("lecinfo");
						byte[] lecinfo = getByteArray(infoString);
						
						byte[] lecpic = null;
						Part part = req.getPart("lecpic");
						System.out.println(part);
						System.out.println(part.getContentType());
						
						if (("application/octet-stream").equals(part.getContentType())) {
							LecService lecSvc = new LecService();
							LecVO lecVO = lecSvc.getOne(lecno);
							lecpic = lecVO.getLecpic();
							System.out.println("lecpic remains the same as which in DB");
						}
						if(("image/gif").equals(part.getContentType()) || ("image/jpeg").equals(part.getContentType()) || ("image/png").equals(part.getContentType())) {
							InputStream in = part.getInputStream();
							lecpic = getFileByteArray(in);
							in.close();
						}
						
						LecVO lecVO = new LecVO();
						lecVO.setLecno(lecno);
						lecVO.setLecname(lecname);
						lecVO.setLecprice(lecprice);
						lecVO.setSpkrno(spkrno);
						lecVO.setRoomno(roomno);
						lecVO.setLecstart(lecstart);
						lecVO.setLecend(lecend);
						lecVO.setSignstart(signstart);
						lecVO.setSignend(signend);
						lecVO.setInitseat(initseat);
						lecVO.setCurrseat(currseat);
						lecVO.setLecstatus(lecstatus);
						lecVO.setLecinfo(lecinfo);
						lecVO.setLecpic(lecpic);
						req.setAttribute("lecVO", lecVO);
						
						if (!errorMsgs.isEmpty()) {
							RequestDispatcher failureView = req.getRequestDispatcher("/back-end/lecture/updateLec.jsp");
							failureView.forward(req, res);
							return;
						}
					/***********************驗證完畢***********************/	
						LecService lecSvc = new LecService();
						lecVO = lecSvc.updateLec(lecno, lecname, lecprice, spkrno, roomno, lecstart, lecend, signstart, signend, initseat, currseat, lecstatus, lecinfo, lecpic);
						
						RequestDispatcher successView = req.getRequestDispatcher("/back-end/lecture/listAllLec.jsp"); 
						successView.forward(req, res);
						
					} catch (Exception e) {
						e.printStackTrace();
						
					}
				}
		
		//====================================從列表查詢====================================//
		if ("getOne".equals(action)) {
			
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			
			try {
				String lecno = req.getParameter("lecno");
				LecService lecSvc = new LecService();
				LecVO lecVO = lecSvc.getOne(lecno);

				req.setAttribute("lecVO", lecVO);

				String url = "/back-end/lecture/listOneLec.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);
				return;

			} catch (Exception e) {
				e.printStackTrace();
			}
		
			
		}
		//====================================從列表到修改====================================//
				if ("update_fromList".equals(action)) {
					
					List<String> errorMsgs = new LinkedList<String>();
					req.setAttribute("errorMsgs", errorMsgs);
					
					try {
						String lecno = req.getParameter("lecno");
						LecService lecSvc = new LecService();
						LecVO lecVO = lecSvc.getOne(lecno);

						req.setAttribute("lecVO", lecVO);

						String url = "/back-end/lecture/updateLec.jsp";
						RequestDispatcher successView = req.getRequestDispatcher(url);
						successView.forward(req, res);
						return;

					} catch (Exception e) {
						e.printStackTrace();
					}
				
					
				}
		/*前台*/
				//====================================從列表查詢====================================//
				if ("frontOne".equals(action)) {
					
					List<String> errorMsgs = new LinkedList<String>();
					req.setAttribute("errorMsgs", errorMsgs);
					
					try {
						String lecno = req.getParameter("lecno");
						LecService lecSvc = new LecService();
						LecVO lecVO = lecSvc.getOne(lecno);

						req.setAttribute("lecVO", lecVO);

						String url = "/front-end/lecture/listOneLec/frontOneLec.jsp";
						RequestDispatcher successView = req.getRequestDispatcher(url);
						successView.forward(req, res);
						return;

					} catch (Exception e) {
						e.printStackTrace();
					}
				}
				//====================================從詳情訂購====================================//
				if ("bookOne".equals(action)) {
					
					List<String> errorMsgs = new LinkedList<String>();
					req.setAttribute("errorMsgs", errorMsgs);
					
					try {
						String lecno = req.getParameter("lecno");
						LecService lecSvc = new LecService();
						LecVO lecVO = lecSvc.getOne(lecno);

						req.setAttribute("lecVO", lecVO);

						String url = "/front-end/lecorder/addLodr.jsp";
						RequestDispatcher successView = req.getRequestDispatcher(url);
						successView.forward(req, res);
						return;

					} catch (Exception e) {
						e.printStackTrace();
					}
				}
				
				//====================================確認訂購====================================//
				if ("confirmOne".equals(action)) {
					
					List<String> errorMsgs = new LinkedList<String>();
					req.setAttribute("errorMsgs", errorMsgs);
					
					try {
						String lecno = req.getParameter("lecno");
						LecService lecSvc = new LecService();
						LecVO lecVO = lecSvc.getOne(lecno);

						req.setAttribute("lecVO", lecVO);

						String url = "/front-end/lecorder/confirmLodr.jsp";
						RequestDispatcher successView = req.getRequestDispatcher(url);
						successView.forward(req, res);
						return;

					} catch (Exception e) {
						e.printStackTrace();
					}
				}
	}
}
