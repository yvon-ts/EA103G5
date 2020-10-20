package com.video.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.video.model.*;
import com.google.gson.*;

@WebServlet("/ajax_pratice")
public class ajax_pratice extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");
		res.setContentType("text/html; charset=UTF-8");
		PrintWriter out = res.getWriter();
		
		String courseno = req.getParameter("courseno");
		
		VideoService videoSvc = new VideoService();
		List<VideoVO> list = new ArrayList<VideoVO>();
		Map<String, String[]> map = new TreeMap<String, String[]>();
		map.put("courseno", new String[] { courseno });
		
		list = videoSvc.getAll(map);
		
//		for (VideoVO vvo : list) {
//			out.println("Videono:\t" + vvo.getVideono());
//			out.println("Courseno:\t" + vvo.getCourseno());
//			out.println("Testscope:\t" + vvo.getTestscope());
//			out.println("Chapterno:\t" + vvo.getChapterno());
//			out.println("Chaptername:\t" + vvo.getChaptername());
//			out.println("Chapterlen:\t" + vvo.getChapterlen());
//			out.println();
//		}
		
		Gson gson = new Gson();
		String jsonStr = gson.toJson(list);
//		out.println("=========================================================");
		out.println(jsonStr);		
	}

}
