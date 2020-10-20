package com.video_bar.controller;

import java.io.*;
import java.util.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.video_bar.model.*;

@WebServlet("/VideoBarServlet_TestJNDI")
public class VideoBarServlet_TestJNDI extends HttpServlet {

	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		res.setContentType("text/plain; charset=UTF-8");
		PrintWriter out = res.getWriter();
		
		VideoBarService videoBarSvc = new VideoBarService();

		out.println("=== TEST === GET ONE ===");
		VideoBarVO videoBarVO = videoBarSvc.getOneVideoBar("MEM0001", "VID0001");

		out.println("MEMNO:\t" + videoBarVO.getMemno());
		out.println("VIDEONO:\t" + videoBarVO.getVideono());
		out.println("VIDEOSEC:\t" + videoBarVO.getVideosec());
		out.println("VIDEOTTLTIME:\t" + videoBarVO.getVideottltime());
		out.println("VIDEOLASTTIME:\t" + videoBarVO.getVideolasttime());

		out.println("=== TEST === ADD ONE ===");
//		VideoBarVO videoBarVO_add = new VideoBarVO();
//		videoBarVO_add.setMemno("MEM0001");
//		videoBarVO_add.setVideono("VID0003");
//		videoBarVO_add.setVideosec(50);
//		videoBarVO_add.setVideottltime(99);
		videoBarSvc.addVideoBar("MEM0003", "VID0003", 66, 66);
		out.println("add good good");

		out.println("=== TEST === UPDATE ONE ===");
		videoBarSvc.updateVideoBar("MEM0001", "VID0003", 999, 999);

		out.println("=== TEST === GET ALL ===");
		List<VideoBarVO> list = videoBarSvc.getAll();

		for (VideoBarVO videoBarVO_L : list) {
			out.println("MEMNO:\t" + videoBarVO_L.getMemno());
			out.println("VIDEONO:\t" + videoBarVO_L.getVideono());
			out.println("VIDEOSEC:\t" + videoBarVO_L.getVideosec());
			out.println("VIDEOTTLTIME:\t" + videoBarVO_L.getVideottltime());
			out.println("VIDEOLASTTIME:\t" + videoBarVO_L.getVideolasttime());
		}
	}
}
