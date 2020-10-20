package com.video.controller;

import java.io.*;
import java.util.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.video.model.*;

@WebServlet("/VideoServlet_TestJNDI")
public class VideoServlet_TestJDNI extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		res.setContentType("text/plain; charset=UTF-8");
		PrintWriter out = res.getWriter();

		VideoService videoSvc = new VideoService();

//		out.println("=== TEST === GET ONE ===");
//		VideoVO videoVO = videoSvc.getOneVideo("VID0003");
//
//		out.println("Videono:\t" + videoVO.getVideono());
//		out.println("Courseno:\t" + videoVO.getCourseno());
//		out.println("Testscope:\t" + videoVO.getTestscope());
//		out.println("Chapterno:\t" + videoVO.getChapterno());
//		out.println("Chaptername:\t" + videoVO.getChaptername());
//		out.println("Chapterlen:\t" + videoVO.getChapterlen());
//		out.println("Video:\t" + videoVO.getVideo());
//		out.println();
		
//		out.println("=== TEST === ADD ONE ===");
//		videoSvc.addVideo("COUR0002", "5", "5", "真空吸引", 602, null);
		
//		out.println("=== TEST === UPDATE ONE ===");
//		videoSvc.updateVideo("VID0015", "COUR0002", 9, 9, "日常對話", 602, null);
		
//		out.println("=== TEST === DELETE ONE ===");
//		videoSvc.deleteVideo("VID0006");

//		out.println("=== TEST === GET ALL ===");
//		List<VideoVO> list = videoSvc.getAll();
//
//		for (VideoVO vvo : list) {
//			out.println("Videono:\t" + vvo.getVideono());
//			out.println("Courseno:\t" + vvo.getCourseno());
//			out.println("Testscope:\t" + vvo.getTestscope());
//			out.println("Chapterno:\t" + vvo.getChapterno());
//			out.println("Chaptername:\t" + vvo.getChaptername());
//			out.println("Chapterlen:\t" + vvo.getChapterlen());
//			out.println("Video:\t" + vvo.getVideo());
//			out.println();
//		}
		
		
		out.println("=== TEST === GET ALL ===");
		Map<String, String[]> map = new TreeMap<String, String[]>();
		map.put("courseno", new String[] { "COUR0001" });
		List<VideoVO> list2 = videoSvc.getAll(map);
		
		for (VideoVO vvo : list2) {
			out.println("Videono:\t" + vvo.getVideono());
			out.println("Courseno:\t" + vvo.getCourseno());
			out.println("Testscope:\t" + vvo.getTestscope());
			out.println("Chapterno:\t" + vvo.getChapterno());
			out.println("Chaptername:\t" + vvo.getChaptername());
			out.println("Chapterlen:\t" + vvo.getChapterlen());
			out.println("Video:\t" + vvo.getVideo());
			out.println();
		}
		

	}

}
