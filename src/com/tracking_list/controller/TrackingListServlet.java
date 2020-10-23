package com.tracking_list.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;

import com.course.model.CourseService;
import com.course.model.CourseVO;
import com.report_detail.model.ReportDetailService;
import com.report_detail.model.ReportDetailVO;
import com.tracking_list.model.TrackingListService;
import com.tracking_list.model.TrackingListVO;

public class TrackingListServlet extends HttpServlet {

	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);

	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");

		String memno = req.getParameter("memno");
		String courseno = req.getParameter("courseno");
		System.out.println(action);
		System.out.println(memno);
		System.out.println(courseno);

		if ("insert".equals(action)) {

			List<String> errorMsgs = new LinkedList<String>();

			req.setAttribute("errorMsgs", errorMsgs);

			try {

				TrackingListService trackinglistSvc = new TrackingListService();

				trackinglistSvc.addTracking(memno, courseno);
			} catch (Exception e) {
				errorMsgs.add("無法取得要新增的資料:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("新增失敗小視窗.jsp");
				failureView.forward(req, res);
			}

		}

		if ("delete".equals(action)) {

			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);

			try {

				TrackingListService trackinglistSvc = new TrackingListService();
				trackinglistSvc.deleteTracking(memno, courseno);

			} catch (Exception e) {
				errorMsgs.add("無法取得要修改的資料:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("新增失敗小視窗.jsp");
				failureView.forward(req, res);
			}
		}

		if ("shoppingCart".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();

			req.setAttribute("errorMsgs", errorMsgs);

			CourseService courseSvc = new CourseService();

			CourseVO userSelectedCourse = courseSvc.getOneCourse(courseno);

			List<CourseVO> shoppingList = (List<CourseVO>) req.getSession().getAttribute("shoppingList");

			try {
				if (shoppingList == null) {
					shoppingList = new ArrayList<>();
				}
				if (shoppingList != null && !(shoppingList.contains(userSelectedCourse))) {

					shoppingList.add(userSelectedCourse);
					System.out.println(shoppingList.size());
					res.getWriter().println(true);
				} else {
					shoppingList.remove(userSelectedCourse);
					System.out.println(shoppingList.size());
					res.getWriter().println(false);
				}

				req.getSession().setAttribute("shoppingList", shoppingList);
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("新增失敗小視窗.jsp");
				failureView.forward(req, res);
			}
		}

		if ("getAllTrackingListByMemno".equals(action)) {

			List<String> errorMsgs = new LinkedList<String>();

			req.setAttribute("errorMsgs", errorMsgs);

			try {
				
				CourseService courseSvc = new CourseService();
				
				TrackingListService trackilistSvc = new TrackingListService();
				List<TrackingListVO> trackinglistVOList = trackilistSvc.getAll(memno);
				
				List<CourseVO> courseProductList = new ArrayList<>();
				
				for(TrackingListVO vo : trackinglistVOList) {
					courseProductList.add(courseSvc.getOneCourse(vo.getCourseno()));
				}
				
				
				String str = new JSONArray(courseProductList).toString();

				res.setContentType("text/plain");
				res.setCharacterEncoding("UTF-8");
				PrintWriter out = res.getWriter();
				out.write(str);
				out.flush();
				out.close();

			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("新增失敗小視窗.jsp");
				failureView.forward(req, res);
			}
		}
	}
}
