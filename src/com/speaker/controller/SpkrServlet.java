package com.speaker.controller;

import java.io.*;


import java.nio.charset.StandardCharsets;
import java.util.*;

import javax.servlet.*;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.*;

import com.speaker.model.*;

//@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 5 * 1024 * 1024, maxRequestSize = 5 * 50 * 1024 * 1024)
@MultipartConfig
//當數據量大於fileSizeThreshold值時，內容將被寫入磁碟
//上傳過程中無論是單個文件超過maxFileSize值，或者上傳的總量大於maxRequestSize 值都會拋出IllegalStateException 異常

public class SpkrServlet extends HttpServlet {
	
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
		System.out.println("baos有執行已關閉");
		return baos.toByteArray();
	}

	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");

		// =========開始查詢=========//
		if ("getOneByForm".equals(action)) {

			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				String str = req.getParameter("spkrno");
				/************************* 輸入格式錯誤 ****************************/
				if (str == null || (str.trim()).length() == 0) {
					errorMsgs.add("請輸入講師編號");
				} else if (!str.matches("SPKR[0-9]{4}")) {
					errorMsgs.add("編號格式錯誤，應為SPKR加四位數字");
				}
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/speaker/select_page.jsp");
					failureView.forward(req, res);
					return;
				}
				String spkrno = req.getParameter("spkrno");
				SpkrService spkrSvc = new SpkrService();
				SpkrVO spkrVO = spkrSvc.getOne(spkrno);

				/************************* 查無資料 ****************************/
				if (spkrVO == null) {
					errorMsgs.add("查無資料");
				}

				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/speaker/select_page.jsp");
					failureView.forward(req, res);
					return;
				}

				req.setAttribute("spkrVO", spkrVO);

				String url = "/back-end/speaker/listOneSpkr.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);
				return;

			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		// =========開始新增=========//
		if ("insert".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				String spkrname = req.getParameter("spkrname").trim();
				/************************* 姓名驗證 ****************************/
				if (spkrname == null || spkrname.length() == 0) {
					errorMsgs.add("請輸入講師姓名");
				} else if (!spkrname.matches("[\u4e00-\u9fa5a-zA-Z.\\s]{2,16}")) {
					errorMsgs.add("姓名格式錯誤（限中英文2-16字）");
				}
				/************************* 其他欄位 ****************************/
				String spkrphone = req.getParameter("spkrphone").trim();
				String spkremail = req.getParameter("spkremail").trim();
				String infoString = req.getParameter("spkrinfo");
				
				//CKeditor - String to bytes
				byte[] spkrinfo = getByteArray(infoString);
				
				//file upload
				byte[] spkricon = null;
				Part part = req.getPart("spkricon");
				System.out.println(part);
				
				if (part == null || ("application/octet-stream").equals(part.getContentType())) {
					errorMsgs.add("請上傳圖片");
				} else if (part.getContentType().indexOf("image/jpeg") < 0 && part.getContentType().indexOf("image/gif") < 0 && part.getContentType().indexOf("image/png") < 0) {
					System.out.println(part.getContentType());
					errorMsgs.add("僅支援.jpg .jpeg .gif .png 格式");
				}
				InputStream in = part.getInputStream();
				spkricon = getFileByteArray(in);
				in.close();
			
				SpkrVO spkrVO = new SpkrVO();
				spkrVO.setSpkrname(spkrname);
				spkrVO.setSpkrphone(spkrphone);
				spkrVO.setSpkremail(spkremail);
				spkrVO.setSpkrinfo(spkrinfo);
				spkrVO.setSpkricon(spkricon);
				
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("spkrVO", spkrVO);
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/speaker/addSpkr.jsp");
					failureView.forward(req, res);
					return;
				}

				SpkrService spkrSvc = new SpkrService();
				spkrVO = spkrSvc.addSpkr(spkrname, spkrphone, spkremail, spkrinfo, spkricon);
				
				RequestDispatcher successView = req.getRequestDispatcher("/back-end/speaker/listAllSpkr.jsp");
				successView.forward(req, res);
				return;
				
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		// =========開始新增(無圖片)=========//
				if ("insertText".equals(action)) {
					List<String> errorMsgs = new LinkedList<String>();
					req.setAttribute("errorMsgs", errorMsgs);

					try {
						String spkrname = req.getParameter("spkrname").trim();
						/************************* 姓名驗證 ****************************/
						if (spkrname == null || spkrname.length() == 0) {
							errorMsgs.add("請輸入講師姓名");
						} else if (!spkrname.matches("[\u4e00-\u9fa5a-zA-Z.\\s]{2,16}")) {
							errorMsgs.add("姓名格式錯誤（限中英文2-16字）");
						}
						/************************* 其他欄位 ****************************/
						String spkrphone = req.getParameter("spkrphone").trim();
						String spkremail = req.getParameter("spkremail").trim();
						String infoString = req.getParameter("spkrinfo");
						
						//CKeditor - String to bytes
						byte[] spkrinfo = getByteArray(infoString);
						
						SpkrVO spkrVO = new SpkrVO();
						spkrVO.setSpkrname(spkrname);
						spkrVO.setSpkrphone(spkrphone);
						spkrVO.setSpkremail(spkremail);
						spkrVO.setSpkrinfo(spkrinfo);
						
						if (!errorMsgs.isEmpty()) {
							req.setAttribute("spkrVO", spkrVO);
							RequestDispatcher failureView = req.getRequestDispatcher("/back-end/speaker/addSpkr.jsp");
							failureView.forward(req, res);
							return;
						}

						SpkrService spkrSvc = new SpkrService();
						spkrVO = spkrSvc.addSpkrText(spkrname, spkrphone, spkremail, spkrinfo);
						
						RequestDispatcher successView = req.getRequestDispatcher("/back-end/speaker/listAllSpkr.jsp");
						successView.forward(req, res);
						return;
						
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
		
		// =========開始修改=========//
		if ("updateOne".equals(action)) {

			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				String spkrno = req.getParameter("spkrno");
				String spkrname = req.getParameter("spkrname");
				/************************* 姓名驗證 ****************************/
				if ((spkrname.trim()).length() == 0) {
					errorMsgs.add("請輸入講師姓名");
				} else if (!spkrname.matches("[\\u4e00-\\u9fa5a-zA-Z.\\\\s]{2,16}")) {
					errorMsgs.add("姓名格式錯誤（限中英文2-16字）");
				}
				/************************* 其他欄位 ****************************/
				String spkrphone = req.getParameter("spkrphone").trim();
				String spkremail = req.getParameter("spkremail").trim();
				String infoString = req.getParameter("spkrinfo");
				//CKeditor - String to Bytes
				byte[] spkrinfo = getByteArray(infoString);
				
				//file upload
				SpkrService dbSvc = new SpkrService();
				SpkrVO dbVO = dbSvc.getOne(spkrno);
				byte[] spkricon = dbVO.getSpkricon();

				Part part = req.getPart("spkricon");
				if(("image/gif").equals(part.getContentType()) || ("image/jpeg").equals(part.getContentType()) || ("image/png").equals(part.getContentType())) {
					InputStream in = part.getInputStream();
					spkricon = getFileByteArray(in);
					in.close();
				} else {
					errorMsgs.add("僅支援.jpg .jpeg .gif .png 格式");
				}
				
				SpkrVO spkrVO = new SpkrVO();
				spkrVO.setSpkrname(spkrname);
				spkrVO.setSpkrphone(spkrphone);
				spkrVO.setSpkremail(spkremail);
				spkrVO.setSpkrinfo(spkrinfo);
				spkrVO.setSpkricon(spkricon);
				
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("spkrVO", spkrVO);
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/speaker/updateSpkr.jsp");
					failureView.forward(req, res);
					return;
				}

				SpkrService spkrSvc = new SpkrService();
				spkrVO = spkrSvc.updateSpkr(spkrno, spkrname, spkrphone, spkremail, spkrinfo, spkricon);

				req.setAttribute("spkrVO", spkrVO);

				RequestDispatcher successView = req.getRequestDispatcher("/back-end/speaker/listOneSpkr.jsp");
				successView.forward(req, res);
				return;
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		// =========開始修改(無圖片)=========//
				if ("updateText".equals(action)) {

					List<String> errorMsgs = new LinkedList<String>();
					req.setAttribute("errorMsgs", errorMsgs);

					try {
						String spkrno = req.getParameter("spkrno");
						String spkrname = req.getParameter("spkrname");
						/************************* 姓名驗證 ****************************/
						if ((spkrname.trim()).length() == 0) {
							errorMsgs.add("請輸入講師姓名");
						} else if (!spkrname.matches("[\\u4e00-\\u9fa5a-zA-Z.\\\\s]{2,16}")) {
							errorMsgs.add("姓名格式錯誤（限中英文2-16字）");
						}
						/************************* 其他欄位 ****************************/
						String spkrphone = req.getParameter("spkrphone").trim();
						String spkremail = req.getParameter("spkremail").trim();
						String infoString = req.getParameter("spkrinfo");
						//CKeditor - String to Bytes
						byte[] spkrinfo = getByteArray(infoString);
						
						SpkrVO spkrVO = new SpkrVO();
						spkrVO.setSpkrname(spkrname);
						spkrVO.setSpkrphone(spkrphone);
						spkrVO.setSpkremail(spkremail);
						spkrVO.setSpkrinfo(spkrinfo);
						
						if (!errorMsgs.isEmpty()) {
							req.setAttribute("spkrVO", spkrVO);
							RequestDispatcher failureView = req.getRequestDispatcher("/back-end/speaker/updateSpkr.jsp");
							failureView.forward(req, res);
							return;
						}

						SpkrService spkrSvc = new SpkrService();
						spkrVO = spkrSvc.updateSpkrText(spkrno, spkrname, spkrphone, spkremail, spkrinfo);

						req.setAttribute("spkrVO", spkrVO);

						RequestDispatcher successView = req.getRequestDispatcher("/back-end/speaker/listOneSpkr.jsp");
						successView.forward(req, res);
						return;
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
		
		// =========全部查詢跳轉單一查詢=========//
		if ("display_fromList".equals(action)) {

			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				String spkrno = req.getParameter("spkrno");
				SpkrService spkrSvc = new SpkrService();
				SpkrVO spkrVO = spkrSvc.getOne(spkrno);

				req.setAttribute("spkrVO", spkrVO);

				String url = "/back-end/speaker/listOneSpkr.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);
				return;

			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		
		// =========全部查詢跳轉修改頁面=========//
				if ("update_fromList".equals(action)) {

					List<String> errorMsgs = new LinkedList<String>();
					req.setAttribute("errorMsgs", errorMsgs);

					try {
						String spkrno = req.getParameter("spkrno");
						SpkrService spkrSvc = new SpkrService();
						SpkrVO spkrVO = spkrSvc.getOne(spkrno);

						req.setAttribute("spkrVO", spkrVO);

						String url = "/back-end/speaker/updateSpkr.jsp";
						RequestDispatcher successView = req.getRequestDispatcher(url);
						successView.forward(req, res);
						return;

					} catch (Exception e) {
						e.printStackTrace();
					}
				}
		// =========開始刪除(待補alert訊息)=========//
		if ("delete".equals(action)) {
			String spkrno = req.getParameter("spkrno");
			SpkrService spkrSvc = new SpkrService();
			spkrSvc.deleteSpkr(spkrno);
			
			RequestDispatcher successView = req.getRequestDispatcher("/back-end/speaker/listAllSpkr.jsp");
			successView.forward(req, res);
			return;
		}
	}	
}
