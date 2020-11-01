package com.members.controller;

import java.io.*;
import java.sql.Date;
import java.util.*;
import java.net.*;

import javax.servlet.*;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.*;

import com.course.model.CourseService;
import com.course.model.CourseVO;
import com.members.model.*;
import com.teacher.model.*;

@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 10 * 1024 * 1024, maxRequestSize = 5 * 5 * 1024 * 1024)

public class MembersServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");// 處理中文檔名
		res.setContentType("text/html; charset=UTF-8");
		

		String action = req.getParameter("action");

//===================以下為新增會員區塊======================
		if ("insert".equals(action)) {
			insert(req, res);
		}

//===================以下為登入會員區塊======================
		if ("signin".equals(action)) {
			signin(req, res);
		}

//===================以下為登出會員區塊======================
		if ("signout".equals(action)) {
			signout(req, res);
		}

//===================以下為修改會員區塊======================
		if ("updatemembers".equals(action)) {
			updatemembers(req, res);
		}
//===================以下為修改會員狀態區塊===================
		if("updatestatus".equals(action)) {
			updatestatus(req,res);
		}
//===================以下為查詢單一會員資料區塊================
		if("getOne_For_Display".equals(action)) {
			getOne_For_Display(req,res);
		}
//===================以下為會員驗證區塊===================
		if ("verify".equals(action)) {
					verify(req, res);
				}

		
		
	}// Post大括號尾端

	
//=======================處理照片專區========================
	public String getFileNameFromPart(Part part) {


		String header = part.getHeader("content-disposition");
		String filename = new File(header.substring(header.lastIndexOf("=") + 2, header.length() - 1)).getName();

		if (filename.length() == 0) {
			return null;
		}
		return filename;
	}
	
	public static byte[] getPictureByteArray(String path) throws IOException{
		File file = new File(path);
		FileInputStream fis = new FileInputStream(file);
		ByteArrayOutputStream baos = new ByteArrayOutputStream();
		byte[] buffer = new byte[8192];
		int i ;
		while((i=fis.read(buffer)) !=-1) {
			baos.write(buffer, 0, i);
		}
		baos.close();
		fis.close();
		
		return baos.toByteArray();
		
	}
	
//=========================================================

	
//=======================驗證碼產生法========================
	public static String getAutoCode() {
		String i ="012345QAZWS0123XEDCRF09543216789VTGBY876HNUJMKLIOP456789";
		String str="";
		for(int x=1;x<=6;x++) {
			
			str+=i.charAt((char)(Math.random()*46));
		}
		return str;
		
		
		
	}
//=========================================================
	

	private void insert(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		List<String> errorMsgs = new LinkedList<String>();
		req.setAttribute("errorMsgs", errorMsgs);
		smsSending sms = new smsSending();
		String vercode = getAutoCode();
		StringBuilder sb = new StringBuilder();
		String inform = "200";
		
		HttpSession session = req.getSession();
		session.setAttribute("inform", inform);
		Integer count = new Integer(0);
		ServletContext ct = req.getServletContext();
		String path = ct.getRealPath("/front-end/members/addMembers_css/images/defaultMprofile.jpg");
		
		
		// Store this set in the request scope, in case we need to
		// send the ErrorPage view.
		
		try {

			String memacc = req.getParameter("memacc").toUpperCase();
			String memaccReg = "[\\w]{6,16}$";
			if (memacc == null || memacc.trim().length() == 0) {
				errorMsgs.add("會員帳號: 請勿空白");
			} else if (!memacc.trim().matches(memaccReg)) { // 以下練習正則(規)表示式(regular-expression)
				errorMsgs.add("會員帳號: 只能是英文字母、數字,且長度必需在6到16之間");
			}

			String mempwd = req.getParameter("mempwd");
			String mempwdReg = "[\\w]{6,16}$";
			if (mempwd == null || mempwd.trim().length() == 0) {
				errorMsgs.add("會員密碼: 請勿空白");
			} else if (!mempwd.trim().matches(mempwdReg)) { // 以下練習正則(規)表示式(regular-expression)
				errorMsgs.add("會員密碼: 只能是英文字母、數字,且長度必需在6到16之間");
			}
			String Rmempwd = req.getParameter("Rmempwd");
			if (!(Rmempwd.equals(mempwd))) {
				errorMsgs.add("重複輸入密碼必須一致");
			}
			String memname = req.getParameter("memname");
			String memnameReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)(/S)]{2,10}";
			if (memname == null || memname.trim().length() == 0) {
				errorMsgs.add("會員姓名: 請勿空白");
			} else if (!memname.trim().matches(memnameReg)) { // 以下練習正則(規)表示式(regular-expression)
				errorMsgs.add("會員姓名: 只能是中、英文字母、數字 ,不能有任何符號, 且長度必需在2到10之間");
			}
			String nkname = req.getParameter("nkname");
			String nknameReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)()]{2,10}$";
			if (nkname == null || nkname.trim().length() == 0) {
				nkname = "Xlearner";
			} else if (!nkname.trim().matches(nknameReg)) { // 以下練習正則(規)表示式(regular-expression)
				errorMsgs.add("會員暱稱: 只能是中、英文字母和數字,不能有任何符號 , 且長度必需在2到10之間");
			}
			String memail = req.getParameter("memail");
			String memailReg = "^[_a-z0-9-]+([.][_a-z0-9-]+)*@[a-z0-9-]+([.][a-z0-9-]+)*$";
			if (memail == null || memail.trim().length() == 0) {
				errorMsgs.add("會員電郵: 請勿空白");
			} else if (!memail.trim().matches(memailReg)) { // 以下練習正則(規)表示式(regular-expression)
				errorMsgs.add("會員電郵: 不符合格式");
			}
			String mphone = req.getParameter("mphone");
			String mphoneReg = "[0-9]{4}[0-9]{6}";
			if (mphone == null || mphone.trim().length() == 0) {
				errorMsgs.add("會員電話: 請勿空白");
			} else if (!mphone.trim().matches(mphoneReg)) { // 以下練習正則(規)表示式(regular-expression)
				errorMsgs.add("會員電話: 不符合格式");
			}

			java.sql.Date membday = null;
			try {
				membday = java.sql.Date.valueOf(req.getParameter("membday").trim());
			} catch (IllegalArgumentException e) {
				membday = new java.sql.Date(System.currentTimeMillis());
				errorMsgs.add("請輸入會員生日!");
			}
			byte[] mprofile = null;

			Collection<Part> parts = req.getParts();
			for (Part part : parts) {
				if (getFileNameFromPart(part) != null && part.getContentType() != null) {
					InputStream in = part.getInputStream();
					mprofile = new byte[in.available()];
					in.read(mprofile);
					in.close();
				}
			}
			if(mprofile == null) {
				
				mprofile = getPictureByteArray(path);
				
			}
			MembersVO memVO = new MembersVO();
			memVO.setMemacc(memacc);
			memVO.setMempwd(mempwd);
			memVO.setMemname(memname);
			memVO.setNkname(nkname);
			memVO.setMembday(membday);
			memVO.setMemail(memail);
			memVO.setMphone(mphone);
			memVO.setMprofile(mprofile);
			
			if (!errorMsgs.isEmpty()) {
				req.setAttribute("membersVO", memVO);
//				session.removeAttribute("inform");
				RequestDispatcher failureView = req.getRequestDispatcher("/front-end/members/addMembersV2.jsp");
				failureView.forward(req, res);
				return;
			}
			
			
			
			sb.append("歡迎註冊Xducation線上學習平台,");
			sb.append("這是您的驗證碼:");
			sb.append(vercode);
		    sms.Process(sb, mphone);
			session.setAttribute("memVO", memVO);
			session.setAttribute("vercode", vercode);
			session.setAttribute("count", count);
			
			RequestDispatcher sucessView = req.getRequestDispatcher("/front-end/members/transitMembers.jsp");
			sucessView.forward(req, res);
			
			
			
		} catch (Exception e) {
			errorMsgs.add(e.getMessage());
			RequestDispatcher failureView = req.getRequestDispatcher("/front-end/members/addMembersV2.jsp");
			failureView.forward(req, res);
		}

	}
	
	private void verify(HttpServletRequest req, HttpServletResponse res)throws ServletException, IOException {
		HttpSession session = req.getSession();
		
		session.removeAttribute("inform");
		List<String> errorMsgs = new LinkedList<String>();
		req.setAttribute("errorMsgs", errorMsgs);
		
		Integer count =(Integer) session.getAttribute("count");
		System.out.println("錯誤次數"+count);
		
		
		
		MembersVO memVO =(MembersVO) session.getAttribute("memVO");
		String mphone = memVO.getMphone();
		System.out.println(mphone);
		String vercode = (String)session.getAttribute("vercode");
		System.out.println(vercode);
		
		
		String clientVerCode = req.getParameter("clientVerCode").toUpperCase();
		if(clientVerCode == null || clientVerCode.trim().length() == 0) {
			errorMsgs.add("不可為空白");
			System.out.println("輸入空白");
		
		}else if(count == 2) {
			session.removeAttribute("memVO");
			session.removeAttribute("vercode");
			session.removeAttribute("count");
			String inform2 = "200";
			req.setAttribute("inform2", inform2);
			String url = "/index/front-index/index.jsp";
			RequestDispatcher successView = req.getRequestDispatcher(url); 
			successView.forward(req, res);
			return;
		}else if(!vercode.equals(clientVerCode.trim())) {
			if(count.equals(1)) {
				errorMsgs.add("請小心輸入啊,再一次就得重新註冊了><");
				count +=1;
				session.setAttribute("count", count);
			}else {
				errorMsgs.add("您不想成為我們的會員了嗎:(");
				count +=1;
				session.setAttribute("count", count);
			}
		}
	
	
		
		
		if (!errorMsgs.isEmpty()) {
			
			RequestDispatcher failureView = req.getRequestDispatcher("/front-end/members/vCodeMembers.jsp");
			failureView.forward(req, res);
			return;
		}
		
		
		MembersService membersSvc = new MembersService();
		String memacc = memVO.getMemacc();
		String mempwd = memVO.getMempwd();
		String memname = memVO.getMemname();
		String nkname = memVO.getNkname();
		Date membday = memVO.getMembday();
		String memail = memVO.getMemail();
		byte[] mprofile = memVO.getMprofile();
		
		String inform3 = "200";
		req.setAttribute("inform3", inform3);		
		membersSvc.addMembers(memacc, mempwd, memname, nkname, membday, memail, mphone, mprofile);
		session.removeAttribute("memVO");
		session.removeAttribute("vercode");
		
		
		RequestDispatcher successView = req.getRequestDispatcher("/front-end/members/signIn.jsp");
		successView.forward(req, res);
		
		
		

		
	}

	private void signin(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		List<String> errorMsgs = new LinkedList<String>();
		req.setAttribute("errorMsgs", errorMsgs);
		HttpSession session = req.getSession();
		String memacc = req.getParameter("memacc").toUpperCase();
		String mempwd = req.getParameter("mempwd");
		
		
		TeacherService teacherSvc = new TeacherService();
		TeacherVO teacherVO = new TeacherVO();
		
		MembersService membersSvc = new MembersService();
		MembersVO membersVO = membersSvc.signIn(memacc, mempwd);
		
		if (membersVO == null) {
			errorMsgs.add("會員帳號or密碼有誤，請重新輸入");
			membersVO = new MembersVO();
			membersVO.setMemacc(memacc);
			req.setAttribute("membersVO", membersVO);
			String url = "/front-end/members/signIn.jsp";
			RequestDispatcher failView = req.getRequestDispatcher(url);
			failView.forward(req, res);
		} else {
			teacherVO = teacherSvc.getOneTeacherByMemno(membersVO.getMemno());
			session.setAttribute("loginTeacherVO", teacherVO);
			session.setAttribute("loginMembersVO", membersVO);
			String inform2 = "100";
			req.setAttribute("inform2", inform2);
			String url = "/index/front-index/index.jsp";
			RequestDispatcher successView = req.getRequestDispatcher(url);
			successView.forward(req, res);
//			http://localhost:8081/EA103G5/front-end/members/signIn.jsp
			
		}

	}

	private void signout(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		HttpSession session = req.getSession();
		session.removeAttribute("loginMembersVO");
		session.removeAttribute("loginTeacherVO");
		String inform2 = "300";
		req.setAttribute("inform2", inform2);
		String url = "/index/front-index/index.jsp";
		RequestDispatcher successView = req.getRequestDispatcher(url);
		successView.forward(req, res);
		
	}

	private void updatemembers(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		List<String> errorMsgs = new LinkedList<String>();
		req.setAttribute("errorMsgs", errorMsgs);
		
		
		String memno =null;
		
		try {
			HttpSession session = req.getSession();
			MembersVO membersVO = (MembersVO) session.getAttribute("loginMembersVO");
			 memno = membersVO.getMemno();

			String mempwd = req.getParameter("mempwd");
			String mempwdReg = "[\\w]{6,16}$";
			if (mempwd == null || mempwd.trim().length() == 0) {
				mempwd = membersVO.getMempwd();
			} else if (!mempwd.trim().matches(mempwdReg)) { // 以下練習正則(規)表示式(regular-expression)
				errorMsgs.add("會員密碼: 只能是英文字母、數字,且長度必需在6到16之間");
			}
			String Rmempwd = req.getParameter("Rmempwd");
			if (Rmempwd == null || Rmempwd.trim().length() == 0) {
				Rmempwd = membersVO.getMempwd();
			}else if (!(Rmempwd.equals(mempwd))) {
				errorMsgs.add("重複輸入密碼:必須一致");
			}
			
			String nkname = req.getParameter("nkname");
			String nknameReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{2,10}$";
			if (nkname == null || nkname.trim().length() == 0) {
				nkname = membersVO.getNkname();
			} else if (!nkname.trim().matches(nknameReg)) { // 以下練習正則(規)表示式(regular-expression)
				errorMsgs.add("會員暱稱: 只能是中、英文字母和數字 , 且長度必需在2到10之間");
			}

			byte[] mprofile = null;
			Collection<Part> parts = req.getParts();
			
			for (Part part : parts) {
				if (getFileNameFromPart(part) != null && part.getContentType() != null) {
					InputStream in = part.getInputStream();
					mprofile = new byte[in.available()];
					in.read(mprofile);
					in.close();
				}
			}
			if(mprofile == null) {
				MembersService membersSvc = new MembersService();
				MembersVO membersVO1;
				membersVO1 = membersSvc.getOneMembers(memno);
				mprofile = membersVO1.getMprofile();
			}
			membersVO.setMempwd(mempwd);
			membersVO.setNkname(nkname);
			membersVO.setMprofile(mprofile);
			
			
			if (!errorMsgs.isEmpty()) {
				req.setAttribute("membersVO", membersVO); // 含有輸入格式錯誤的empVO物件,也存入req
				RequestDispatcher failureView = req.getRequestDispatcher("/front-end/members/updateMembersV2.jsp");
				failureView.forward(req, res);
				return;
			}
			errorMsgs.add("200");
			MembersService membersSvc = new MembersService();
			membersVO = membersSvc.updateMembers(mempwd, nkname, mprofile, memno);
			String url = "/front-end/members/updateMembersV2.jsp";
			RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllEmp.jsp
			successView.forward(req, res);

		} catch (Exception e) {
			errorMsgs.add(e.getMessage());
			RequestDispatcher failureView = req.getRequestDispatcher("/front-end/members/updateMembersV2.jsp");
			failureView.forward(req, res);
		}

	}

    private void updatestatus(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException{
	List<String> errorMsgs = new LinkedList<String>();
	req.setAttribute("errorMsgs", errorMsgs);
	try {
	String memno = req.getParameter("memno");
	
	MembersService membersSvc = new MembersService();
	membersSvc.updateStatusMembers(memno);
	
	String url = "/back-end/members/listAllMembers.jsp";
	RequestDispatcher successView = req.getRequestDispatcher(url);
	successView.forward(req, res);
	}catch (Exception e) {
		errorMsgs.add("修改資料失敗:"+e.getMessage());
		RequestDispatcher failureView = req
				.getRequestDispatcher("/back-end/members/listAllMembers.jsp");
		failureView.forward(req, res);
	}
}
    
    private void getOne_For_Display(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException{
		String memno = req.getParameter("memno");
		String courseno = req.getParameter("courseno");
		
		MembersService membersSvc = new MembersService();
		MembersVO membersVO = membersSvc.getOneMembers(memno);
		Integer i = membersVO.getMemdelete();
		if (i == 1) {
			String inform5 = membersVO.getMemname();
			req.setAttribute("inform5", inform5);
			CourseService courseSvc = new CourseService();
			CourseVO courseVO = courseSvc.getOneCourse(courseno);
			req.setAttribute("courseVO", courseVO);
			RequestDispatcher failureView = req.getRequestDispatcher("/front-end/course/mainCoursePage.jsp");
			failureView.forward(req, res);
			return;
			
		}else {
			req.setAttribute("membersVO", membersVO); // 資料庫取出的empVO物件,存入req
			String url = "/front-end/members/disPlayMembers.jsp";
			RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 listOneEmp.jsp
			successView.forward(req, res);
			
		}
		
		
    }

    


}






// 主Class大括號尾端
