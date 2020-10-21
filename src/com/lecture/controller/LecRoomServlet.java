package com.lecture.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.*;

import javax.servlet.*;
import javax.servlet.http.*;

import org.json.*;

import com.lecture.model.*;
import com.classroom.model.*;

public class LecRoomServlet extends HttpServlet {
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		res.setContentType("text/html; charset=UTF-8");
		
		String lecno = req.getParameter("lecno");
		PrintWriter out = res.getWriter();
		
		LecService lecSvc = new LecService();
		LecVO lecVO = lecSvc.getOne(lecno);
		
		//use lec.roomno as PK of classroom
		String roomno = lecVO.getRoomno();
		ClassroomService roomSvc = new ClassroomService();
		ClassroomVO roomVO = roomSvc.getOneClassroom(roomno);
		
		JSONArray arr = new JSONArray();
		JSONObject obj = new JSONObject();
		
		obj.put("roomno", lecVO.getRoomno());
		obj.put("initseat", lecVO.getInitseat());
		obj.put("currseat", lecVO.getCurrseat());
		obj.put("roomrow", roomVO.getRoomrow());
		obj.put("roomcolumn", roomVO.getRoomcolumn());
		arr.put(obj);
		
		out.print(arr);
	}

}
