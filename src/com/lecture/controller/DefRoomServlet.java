package com.lecture.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.*;

import javax.servlet.*;
import javax.servlet.http.*;

import org.json.*;

import com.classroom.model.*;

public class DefRoomServlet extends HttpServlet {
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		res.setContentType("text/html; charset=UTF-8");
		
		String classroomno = req.getParameter("classroomno");
		System.out.println(classroomno);
		PrintWriter out = res.getWriter();
		
		ClassroomService roomSvc = new ClassroomService();
		ClassroomVO roomVO = roomSvc.getOneClassroom(classroomno);
		
		JSONArray arr = new JSONArray();
		JSONObject obj = new JSONObject();
		
		obj.put("roomno", roomVO.getRoomno());
		obj.put("roomrow", roomVO.getRoomrow());
		obj.put("roomcolumn", roomVO.getRoomcolumn());
		obj.put("roomname", roomVO.getRoomname());
		obj.put("defaultseat", roomVO.getDefaultseat());
		arr.put(obj);
		
		//Gson作法
		/*Map<String, String[]> map = new TreeMap<String, String[]>();
		map.put("classroomno", new String[] {classroomno});
		
		list = roomSvc.getAll(map);
		
		for (ClassroomVO roomVO : list) {
			out.println("roomno:\t" + roomVO.getRoomno());
			out.println("roomname:\t"+ roomVO.getRoomname());
			out.println("defaultseat:\t" + roomVO.getDefaultseat());
			out.println();
		}
		
		Gson gson = new Gson();
		String jsonStr = gson.toJson(list);*/
		
		out.print(arr);
	}

}
