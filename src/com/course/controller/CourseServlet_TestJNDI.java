package com.course.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.course.model.*;
import com.video.model.VideoVO;

@WebServlet("/CourseServlet_Test01")
public class CourseServlet_TestJNDI extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
//		res.setContentType("text/html; charset=UTF-8");
		res.setContentType("text/plain; charset=UTF-8");
		PrintWriter out = res.getWriter();
		
		CourseService courseSvc = new CourseService();

		out.println("=== TEST === GET ONE ===");
		CourseVO courseVO = courseSvc.getOneCourse("COUR0001");
		
		out.println("Courseno:\t" + courseVO.getCourseno());
		out.println("Cstypeno:\t" + courseVO.getCstypeno());
		out.println("Tchrno:\t" + courseVO.getTchrno());
		out.println("Coursename:\t" + courseVO.getCoursename());
		out.println("Courseinfo:\t" + courseVO.getCourseinfo());
		out.println("Courseprice:\t" + courseVO.getCourseprice());
		out.println("Ttltime:\t" + courseVO.getTtltime());
		out.println("Csstatus:\t" + courseVO.getCsstatus());
		out.println("Csscore:\t" + courseVO.getCsscore());
		out.println("Csscoretimes:\t" + courseVO.getCsscoretimes());
		out.println();
		
//		out.println("=== TEST === ADD ONE ===");
//		courseSvc.addCourse("TYPE0002", "TCHR0002", "真空吸引", "TEST", 666, 666, "下架", 666, 666);

		
//		out.println("=== TEST === UPDATE ONE ===");
//		courseSvc.updateCourse("COUR0015","TYPE0003", "TCHR0002", "真空吸引", "TEST", 777, 777,"下架", 777, 777);
		
//		out.println("=== TEST === GET ALL ===");
//		List<CourseVO> list = courseSvc.getAll();
//		
//		for (CourseVO courseVO_L : list) {
//			out.println("Courseno:\t" + courseVO_L.getCourseno());
//			out.println("Cstypeno:\t" + courseVO_L.getCstypeno());
//			out.println("Tchrno:\t" + courseVO_L.getTchrno());
//			out.println("Coursename:\t" + courseVO_L.getCoursename());
//			out.println("Courseinfo:\t" + courseVO_L.getCourseinfo());
//			out.println("Courseprice:\t" + courseVO_L.getCourseprice());
//			out.println("Ttltime:\t" + courseVO_L.getTtltime());
//			out.println("Csstatus:\t" + courseVO_L.getCsstatus());
//			out.println("Csscore:\t" + courseVO_L.getCsscore());
//			out.println("Csscoretimes:\t" +courseVO_L.getCsscoretimes());
//			out.println();
//		}
		
		out.println("=== TEST === GET ALL ===");
		Map<String, String[]> map = new TreeMap<String, String[]>();
		map.put("tchrno", new String[] { "0001" });
		List<CourseVO> list2 = courseSvc.getAll(map);
		
		for (CourseVO courseVO_L : list2) {
			out.println("Courseno:\t" + courseVO_L.getCourseno());
			out.println("Cstypeno:\t" + courseVO_L.getCstypeno());
			out.println("Tchrno:\t" + courseVO_L.getTchrno());
			out.println("Coursename:\t" + courseVO_L.getCoursename());
			out.println("Courseinfo:\t" + courseVO_L.getCourseinfo());
			out.println("Courseprice:\t" + courseVO_L.getCourseprice());
			out.println("Ttltime:\t" + courseVO_L.getTtltime());
			out.println("Csstatus:\t" + courseVO_L.getCsstatus());
			out.println("Csscore:\t" + courseVO_L.getCsscore());
			out.println("Csscoretimes:\t" +courseVO_L.getCsscoretimes());
			out.println();
		}
	}

}
