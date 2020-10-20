package previousVision;

import java.io.*;
import java.util.Collection;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.*;
import javax.servlet.http.*;

import com.members.model.*;

public class MembersUpdate extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");// 處理中文檔名
		res.setContentType("text/html; charset=UTF-8");
		PrintWriter out = res.getWriter();
		List<String> errorMsgs = new LinkedList<String>();
		req.setAttribute("errorMsgs", errorMsgs);
		
		HttpSession session = req.getSession();
		MembersVO membersVO = (MembersVO) session.getAttribute("membersVO");
		String memno = membersVO.getMemno();

	
		String mempwd = req.getParameter("mempwd");
		String mempwdReg = "[\\w]{6,16}$";
		if (mempwd == null || mempwd.trim().length() == 0) {
			errorMsgs.add("會員密碼: 請勿空白");
		} else if (!mempwd.trim().matches(mempwdReg)) { // 以下練習正則(規)表示式(regular-expression)
			errorMsgs.add("會員密碼: 只能是英文字母、數字,且長度必需在6到16之間");
		}
		String rmempwd = req.getParameter("rmempwd");
		if (!(rmempwd.equals(mempwd))) {
			errorMsgs.add("重複輸入密碼必須一致");
		}
		String mphone = req.getParameter("mphone");
		String mphoneReg = "[0-9]{4}[0-9]{6}";
		if (mphone == null || mphone.trim().length() == 0) {
			errorMsgs.add("會員電話: 請勿空白");
		} else if (!mphone.trim().matches(mphoneReg)) { // 以下練習正則(規)表示式(regular-expression)
			errorMsgs.add("會員電話不符合格式");
		}
				String nkname = req.getParameter("nkname");
				String nknameReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{2,10}";
				if (nkname == null || nkname.trim().length() == 0) {
					errorMsgs.add("會員暱稱: 請勿空白");
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
				membersVO.setMempwd(mempwd);
				membersVO.setMphone(mphone);
				membersVO.setNkname(nkname);
				membersVO.setMprofile(mprofile);
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("membersVO", membersVO); // 含有輸入格式錯誤的empVO物件,也存入req
					RequestDispatcher failureView = req.getRequestDispatcher("updateMembers.jsp");
					failureView.forward(req, res);
					return;
				}
				MembersService membersSvc = new MembersService();
//				membersVO = membersSvc.updateMembers(mempwd, nkname, mphone);
				
				
				
				
				
				
				
				
//				
//				MembersService membersSvc1 = new MembersService();
//			 membersSvc1.updateMembers(mempwd, nkname, mphone, mprofile, memno);
//				
				
			
			
			
	}
	public String getFileNameFromPart(Part part) {

		String header = part.getHeader("content-disposition");
		String filename = new File(header.substring(header.lastIndexOf("=") + 2, header.length() - 1)).getName();

		if (filename.length() == 0) {
			return null;
		}
		return filename;
	}
}
