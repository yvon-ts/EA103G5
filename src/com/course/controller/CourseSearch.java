package com.course.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONObject;

import com.course.model.CourseService;
import com.course.model.CourseVO;
import com.tracking_list.model.TrackingListService;
import com.tracking_list.model.TrackingListVO;

public class CourseSearch extends HttpServlet {

	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		res.setCharacterEncoding("UTF-8");
		
		List<String> parameter = new ArrayList<>();
		
		String action = req.getParameter("action");
		
		System.out.println(action);
		
		String searchText = req.getParameter("searchText");
		String cstypeno = req.getParameter("cstypeno");
		String min =  req.getParameter("min");
		String max =  req.getParameter("max");
		String order  = req.getParameter("order");
		String memno = req.getParameter("memno");
		
		CourseService courseSvc = new CourseService();
		Map<String, String[]> map = new HashMap<>();
		
		if ("search".equals(action)) {
			
			if (searchText == null || searchText.trim().isEmpty()) { // 沒有輸入導到全部課程頁面
				RequestDispatcher courseList = req.getRequestDispatcher("/front-end/course/listAllCourseForUser.jsp");
				courseList.forward(req, res);
			} else {
				
			
				map.put("searchText",new String[]{searchText.trim()});
				List<CourseVO> list = courseSvc.getAll(map);


				req.setAttribute("list", list);
				RequestDispatcher courseList = req.getRequestDispatcher("/front-end/course/listAllCourseForUser.jsp");
				courseList.forward(req, res);
			}
		}else if("mutlipleSearch".equals(action)){
			TrackingListService  TrackingListSvc = new TrackingListService();
			
			if( searchText!= null && !searchText.trim().isEmpty()) {
				map.put("searchText", new String[]{searchText.trim()});
			}
			System.out.println(cstypeno);
			if(!"all".equals(cstypeno)) {
				map.put("cstypeno", new String[]{cstypeno});
			}
			
			if(!("".equals(min)) && !("".equals(max))) {
				map.put("max", new String[]{max});
				map.put("min", new String[]{min});
			}
				map.put("order", new String[]{order});
				map.put("csstatus", new String[]{"上架"});
				
				List<CourseVO> searchList = courseSvc.getAll(map);
				
				JSONArray JSONarray = new JSONArray(searchList);
				
				for(int i = 0 ; i <JSONarray.length();i++ ) {
					JSONObject json_book = JSONarray.getJSONObject(i);
					
					List<TrackingListVO> TrackingList = TrackingListSvc.getAll(memno);
					
					boolean  flag = true;
					
					for(TrackingListVO vo : TrackingList ) {
						if(vo.getCourseno().equals(json_book.getString("courseno")) ) {
							json_book.put("class", "fa fa-heart");
							flag =	false;
						}
					}
					
					if(flag) {
						json_book.put("class", "fa fa-heart-o");
					}
					
					
				}
				
				
				
				
				
				
				
				String str = JSONarray.toString();
				
				
				res.setContentType("text/plain");
				res.setCharacterEncoding("UTF-8");
				PrintWriter out =res.getWriter();
				out.write(str);
				out.flush();
				out.close();
				
		}
		

		
		
	}
}