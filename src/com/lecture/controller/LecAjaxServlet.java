package com.lecture.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.*;

import javax.servlet.*;
import javax.servlet.http.*;

import org.json.*;

import com.lecture.model.*;
import com.speaker.model.*;
import com.classroom.model.*;

public class LecAjaxServlet extends HttpServlet {
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		res.setContentType("text/html; charset=UTF-8");
		
		String action = req.getParameter("action");
		PrintWriter out = res.getWriter();
		
		if ("getJSON".equals(action)) {
			
			LecService lecSvc = new LecService();
			List<LecVO> lecList = lecSvc.getList();
			
			JSONArray arr = new JSONArray();
			
			for (LecVO lecVO : lecList) {
				
				JSONObject objLec = new JSONObject();
				objLec.put("lecno", lecVO.getLecno());
				objLec.put("lecname", lecVO.getLecname());
				objLec.put("lecprice", lecVO.getLecprice());
				objLec.put("lecstart", lecVO.getLecstart());
				objLec.put("lecend", lecVO.getLecend());
				objLec.put("signstart", lecVO.getSignstart());
				objLec.put("signend", lecVO.getSignend());
				objLec.put("roomno", lecVO.getRoomno());
				objLec.put("initseat", lecVO.getInitseat());
				objLec.put("currseat", lecVO.getCurrseat());
				arr.put(objLec);
				
				String roomno = lecVO.getRoomno();
				
				ClassroomService roomSvc = new ClassroomService();
				ClassroomVO roomVO = roomSvc.getOneClassroom(roomno);
				
				JSONObject objRoom = new JSONObject();
				
				objRoom.put("roomname", roomVO.getRoomname());
				objRoom.put("roomrow", roomVO.getRoomrow());
				objRoom.put("roomcolumn", roomVO.getRoomcolumn());
				arr.put(objRoom);
			}
			out.print(arr);
			
		}
		////////////////////////////////////////////////////////////////////
		
		if ("sendQuery".equals(action)) {
			
			String query = req.getParameter("query");
			out = res.getWriter();
			
			LecService lecSvc = new LecService();
			List<LecVO> list = lecSvc.getQuery(query);
			
			JSONArray arr = new JSONArray();
			
			for (LecVO lecVO : list) {
			
				JSONObject obj = new JSONObject();	
	
				SpkrService spkrSvc = new SpkrService();
				SpkrVO spkrVO = spkrSvc.getOne(lecVO.getSpkrno());
//					
//				ClassroomService roomSvc = new ClassroomService();
//				ClassroomVO roomVO = roomSvc.getOneClassroom(lecVO.getRoomno());
				
				//date format
				SimpleDateFormat fmtdate = new SimpleDateFormat("dd");
				SimpleDateFormat fmtmonth = new SimpleDateFormat("MMM");
				SimpleDateFormat fmttime = new SimpleDateFormat("HH:mm");
				String startdate = fmtdate.format(lecVO.getLecstart());
				String startmonth = fmtmonth.format(lecVO.getLecstart());
				String starttime = fmttime.format(lecVO.getLecstart());
				
				obj.put("lecno", lecVO.getLecno());
				obj.put("lecname", lecVO.getLecname());
				obj.put("lecprice", lecVO.getLecprice());
				obj.put("spkrno", lecVO.getSpkrno());
				obj.put("roomno", lecVO.getRoomno());
				obj.put("lecstart", lecVO.getLecstart());
				obj.put("lecend", lecVO.getLecend());
				obj.put("startdate", startdate);
				obj.put("startmonth", startmonth);
				obj.put("starttime", starttime);
				
//				obj.put("roomname", roomVO.getRoomname());
				obj.put("spkrname", spkrVO.getSpkrname());
				
				arr.put(obj);
			
			}
			out.print(arr);
		}
	}

}
