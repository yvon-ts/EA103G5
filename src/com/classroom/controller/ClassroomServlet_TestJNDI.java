package com.classroom.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.util.*;
import com.classroom.model.*;

@WebServlet("/ClassroomServlet_TestJNDI")
public class ClassroomServlet_TestJNDI extends HttpServlet {
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");
		res.setContentType("text/plain; charset=UTF-8");
		PrintWriter out = res.getWriter();

		out.println("=== GET ONE===");
		String roomno = "ROOM0001";
		ClassroomService classroomSvc = new ClassroomService();
		ClassroomVO classroomVO = classroomSvc.getOneClassroom("ROOM0001");
		
		java.text.DateFormat df = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

		out.println("ROOMNO: \t" + classroomVO.getRoomno());
		out.println("Roomname: \t" + classroomVO.getRoomname());
		out.println("Roomrow: \t" + classroomVO.getRoomrow());
		out.println("Roomcolumn: \t" + classroomVO.getRoomcolumn());
		out.println("Defaultseat: \t" + classroomVO.getDefaultseat());
		out.println("Roomdelete: \t" + classroomVO.getRoomdelete());
		out.println("Roomlastmod: \t" + df.format(classroomVO.getRoomlastmod()));
		out.println();
		
//		out.println("=== ADD===");
//		classroomSvc.addClassroom("B305", 2, 2, "1010", false);
		
		out.println("=== UPDATE===");
		classroomSvc.updateClassroom("ROOM0001", "A020", 2, 2, "1001", false);
		

		out.println("=== GET ALL===");
		List<ClassroomVO> list = classroomSvc.getAll();
		for (ClassroomVO classroomVOL : list) {
			out.println("ROOMNO: \t" + classroomVOL.getRoomno());
			out.println("Roomname: \t" + classroomVOL.getRoomname());
			out.println("Roomrow: \t" + classroomVOL.getRoomrow());
			out.println("Roomcolumn: \t" + classroomVOL.getRoomcolumn());
			out.println("Defaultseat: \t" + classroomVOL.getDefaultseat());
			out.println("Roomdelete: \t" + classroomVOL.getRoomdelete());
			out.println("Roomlastmod: \t" + df.format(classroomVO.getRoomlastmod()));
			out.println();
		}
		
		
	}

}
