package com.teacher.controller;

import java.io.*;
import java.util.*;

import javax.servlet.*;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.*;

import com.teacher.model.*;


@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 10 * 1024 * 1024, maxRequestSize = 5 * 5 * 1024 * 1024)

public class TeacherServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req,res);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");// 處理中文檔名
		res.setContentType("text/html; charset=UTF-8");
		ServletContext ct = req.getServletContext();

		String action = req.getParameter("action");

//===================以下為新增會員區塊===================
		if ("insert".equals(action)) {
			insert(req, res);
		}
		if("updateStatus".equals(action)) {
			updateStatus(req,res);
		}
		if("getOne_For_Display".equals(action)) {
			getOne_For_Display(req,res);
		}
		if("updateTeacher".equals(action)) {
			updateTeacher(req,res);
		}
		
		
	}
	public String getFileNameFromPart(Part part) {
		String header = part.getHeader("content-disposition");
		String filename = new File(header.substring(header.lastIndexOf("=") + 2, header.length() - 1)).getName();
		if (filename.length() == 0) {
			return null;
		}
		return filename;
	}

	private void insert(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException{
		List<String> errorMsgs = new LinkedList<String>();
		req.setAttribute("errorMsgs", errorMsgs);
		try {
			String memno = req.getParameter("memno");
			String tchrintro = req.getParameter("tchrintro");
			if(null == tchrintro||0==tchrintro.trim().length()) {
				errorMsgs.add("老師簡介:為必填欄位");
			}
			
		
			String bankacc = req.getParameter("bankacc");
			String bankaccReg = "[0-9]{0,20}";
			if(null==bankacc||0==bankacc.trim().length()) {
				errorMsgs.add("銀行帳號:為必填欄位");
			}else if(!bankacc.matches(bankaccReg)) {
				errorMsgs.add("銀行帳號:只能是數字,且長度必須在20字內");
			}
			
//			byte[] tchrcert1 = null;
//			byte[] tchrcert2 = null;
			byte[] pic = null;
			TeacherVO teacherVO = null;
			
			Collection<Part> parts = req.getParts();
			// Servlet3.0新增了Part介面，讓我們方便的進行檔案上傳處理
			List<byte[]> picArr = new ArrayList<byte[]>(); 
			for (Part part : parts) {
				if (getFileNameFromPart(part) != null && part.getContentType() != null) {
					// 額外測試 InputStream 與 byte[] (幫將來model的VO預作準備)
					InputStream in = part.getInputStream();
					pic = new byte[in.available()];
					in.read(pic);
					in.close();
					
					picArr.add(pic);
				}
			}
			
			byte[] tchrcert1 = null;
			byte[] tchrcert2 = null;
			
			
			for(int i = 0; i < picArr.size(); i++) {
				teacherVO = new TeacherVO();
				if(i==0) {
					tchrcert1 = picArr.get(i);
					teacherVO.setTchrcert1(picArr.get(i));
				}else {
					tchrcert2 = picArr.get(i);
					teacherVO.setTchrcert2(picArr.get(i));
				}
			}
			
			if(tchrcert1==null||tchrcert2==null) {
				errorMsgs.add("專業證照:一定要上傳");
			}
			teacherVO.setMemno(memno);
			teacherVO.setTchrintro(tchrintro);
			teacherVO.setBankacc(bankacc);
//			tVO.setTchrcert1(tchrcert1);
//			tVO.setTchrcert2(tchrcert2);
			if (!errorMsgs.isEmpty()) {
				req.setAttribute("teacherVO", teacherVO); // 含有輸入格式錯誤的empVO物件,也存入req
				RequestDispatcher failureView = req.getRequestDispatcher("/front-end/teacher/teacherRegister.jsp");
				failureView.forward(req, res);
				return;
			}
			TeacherService teacherSvc = new TeacherService();
			teacherVO = teacherSvc.addTeacher(memno, tchrintro, tchrcert1, tchrcert2, bankacc);
			String inform6 = "200";
			req.setAttribute("inform6", inform6);
			String url = "/front-end/teacher/teacherIndex.jsp";
			RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllEmp.jsp
			successView.forward(req, res);
			
	} catch (Exception e) {
		errorMsgs.add(e.getMessage());
		RequestDispatcher failureView = req.getRequestDispatcher("/front-end/teacher/teacherRegister.jsp");
		failureView.forward(req, res);
	}

}
	
	
	private void updateStatus(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException{
		List<String> errorMsgs = new LinkedList<String>();
		req.setAttribute("errorMsgs", errorMsgs);

		try {
		String tchrstatus = req.getParameter("tchrstatus");
		String tchrno = req.getParameter("tchrno");
		String rejreason = req.getParameter("rejreason");
		
		TeacherService teacherSvc = new TeacherService();
		teacherSvc.updateStatusTeacher(tchrno, tchrstatus,rejreason);
		String url = "/back-end/teacher/showOneTeacher.jsp";
		RequestDispatcher successView = req.getRequestDispatcher(url);
		successView.forward(req, res);
		}catch (Exception e) {
			errorMsgs.add("修改資料失敗:"+e.getMessage());
			RequestDispatcher failureView = req.getRequestDispatcher("/back-end/teacher/listAllPendingTeachers.jsp");
			failureView.forward(req, res);
		}
		

		
	}

	private void getOne_For_Display(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException{
		List<String> errorMsgs = new LinkedList<String>();
		req.setAttribute("errorMsgs", errorMsgs);
		String tchrno = req.getParameter("tchrno");
		String tchrnoReg = "TCHR[0-9]{4}";
		if (tchrno == null || (tchrno.trim()).length() == 0) {
			errorMsgs.add("請輸入老師編號");
			
		}else if (!tchrno.trim().matches(tchrnoReg)) { // 以下練習正則(規)表示式(regular-expression)
			errorMsgs.add("老師編號格式不正確");
		}
			
		if (!errorMsgs.isEmpty()) {
			RequestDispatcher failureView = req.getRequestDispatcher("/back-end/teacher/select_teacher.jsp");
			failureView.forward(req, res);
			return;//程式中斷
		}
		TeacherService teacherSvc = new TeacherService();
		TeacherVO teacherVO = teacherSvc.getOneTeacher(tchrno);
		if (teacherVO == null) {
			errorMsgs.add("查無資料");
		}
		if (!errorMsgs.isEmpty()) {
			RequestDispatcher failureView = req
					.getRequestDispatcher("/back-end/teacher/select_teacher.jsp");
			failureView.forward(req, res);
			return;//程式中斷
		}
		req.setAttribute("teacherVO", teacherVO); // 資料庫取出的empVO物件,存入req
		String url = "/back-end/teacher/showOneTeacher.jsp";
		RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 listOneEmp.jsp
		successView.forward(req, res);
		
		
		
		
		
		
	}
	
    private void updateTeacher(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException{
    	System.out.println("有進來Teacher_update");
    	List<String> errorMsgs = new LinkedList<String>();
		req.setAttribute("errorMsgs", errorMsgs);
//		String tchrno =null;
		try {
			String tchrno = req.getParameter("tchrno").trim();
			String tchrintro = req.getParameter("tchrintro");
			if(null == tchrintro||0==tchrintro.trim().length()) {
				errorMsgs.add("老師簡介:為必填欄位");
			}
			String bankacc = req.getParameter("bankacc");
			String bankaccReg = "[0-9]{0,20}";
			if(null==bankacc||0==bankacc.trim().length()) {
				errorMsgs.add("銀行帳號:為必填欄位");
			}else if(!bankacc.matches(bankaccReg)) {
				errorMsgs.add("銀行帳號:只能是數字,且長度必須在20字內");
			}
			byte[] pic = null;
			
			Collection<Part> parts = req.getParts();
			// Servlet3.0新增了Part介面，讓我們方便的進行檔案上傳處理
			List<byte[]> picArr = new ArrayList<byte[]>(); 
			for (Part part : parts) {
				if (getFileNameFromPart(part) != null && part.getContentType() != null) {
					// 額外測試 InputStream 與 byte[] (幫將來model的VO預作準備)
					InputStream in = part.getInputStream();
					pic = new byte[in.available()];
					in.read(pic);
					in.close();
					
					picArr.add(pic);
				}
			}
			
			byte[] tchrcert1 = null;
			byte[] tchrcert2 = null;
			
			
			for(int i = 0; i < picArr.size(); i++) {
				if(i==0) {
					tchrcert1 = picArr.get(i);
				}else {
					tchrcert2 = picArr.get(i);
				}
			}
			
			if(tchrcert1==null||tchrcert2==null) {
				System.out.println("照片空的");
				TeacherDAO dao = new TeacherDAO();
				TeacherVO teacherVO = dao.findByPrimaryKey(tchrno);
				tchrcert1 = teacherVO.getTchrcert1();
				tchrcert2 = teacherVO.getTchrcert2();
				
			}
			if (!errorMsgs.isEmpty()) {
				
				RequestDispatcher failureView = req.getRequestDispatcher("/front-end/teacher/teacherUpdate.jsp");
				failureView.forward(req, res);
				return;
			}
			
			TeacherService teacherSvc = new TeacherService();
			teacherSvc.updateTeacher(tchrno, tchrintro, bankacc, tchrcert1, tchrcert2);
			String url = "/front-end/teacher/teacherIndex.jsp";
			RequestDispatcher successView = req.getRequestDispatcher(url); 
			successView.forward(req, res);
			
			
			
		}catch (Exception e) {
			errorMsgs.add(e.getMessage());
			RequestDispatcher failureView = req.getRequestDispatcher("/front-end/teacher/teacherUpdate.jsp");
			failureView.forward(req, res);
		}
    	
    	
    	
    	
    }
	
}
