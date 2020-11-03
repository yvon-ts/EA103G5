package com.employee.login.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.emp_authority.model.EmpAuthorityVO;

public class Emp_authFilter implements Filter {

	private FilterConfig config;

	public void init(FilterConfig config) throws ServletException {
		this.config = config;
	}

	public void destroy() {
		config = null;
	}

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {

		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse res = (HttpServletResponse) response;

		HttpSession session = req.getSession();
		List<EmpAuthorityVO> empauthlist = (List<EmpAuthorityVO>) session.getAttribute("empauth");

		List<String> list = new ArrayList<>();

		for (int i = 0; i < empauthlist.size(); i++) {
			list.add(empauthlist.get(i).getFuncno());
		}

		String urls = req.getRequestURI();
		System.out.println(urls);
		List<String> FUN0001 = new ArrayList<>();
		FUN0001.add(req.getContextPath() + "/back-end/employee/empall/newallemp.jsp");
		FUN0001.add(req.getContextPath() + "/back-end/employee/empall/newadd_emp.jsp");
		FUN0001.add(req.getContextPath() + "/back-end/employee/empall/newupdate_emp.jsp");

		List<String> FUN0002 = new ArrayList<>();
		FUN0002.add(req.getContextPath() + "/back-end/members/select_members.jsp");
		FUN0002.add(req.getContextPath() + "/back-end/members/listAllMembers.jsp");
		FUN0002.add(req.getContextPath() + "/back-end/members/listOneMembers.jsp");

		List<String> FUN0003 = new ArrayList<>();
		FUN0003.add(req.getContextPath() + "/back-end/teacher/select_teacher.jsp");
		FUN0003.add(req.getContextPath() + "/back-end/teacher/showOneTeacher.jsp");
		FUN0003.add(req.getContextPath() + "/back-end/teacher/listAllTeachersCompositeQuery.jsp");
		FUN0003.add(req.getContextPath() + "/back-end/teacher/listAllTeachers.jsp");

		List<String> FUN0004 = new ArrayList<>();
		FUN0004.add(req.getContextPath() + "/back-end/classroom/listAllClassroom.jsp");
		FUN0004.add(req.getContextPath() + "/back-end/classroom/addClassroom.jsp");
		FUN0004.add(req.getContextPath() + "/back-end/classroom/listOneClassroom.jsp");
		FUN0004.add(req.getContextPath() + "/back-end/classroom/select_page.jsp");
		FUN0004.add(req.getContextPath() + "/back-end/classroom/update_classroom_input.jsp");
		FUN0004.add(req.getContextPath() + "/back-end/lecture/addLec.jsp");
		FUN0004.add(req.getContextPath() + "/back-end/lecture/addLecIndex.jsp");
		FUN0004.add(req.getContextPath() + "/back-end/lecture/lectureIndex.jsp");
		FUN0004.add(req.getContextPath() + "/back-end/lecture/listAllLec.jsp");
		FUN0004.add(req.getContextPath() + "/back-end/lecture/listOneLec.jsp");
		FUN0004.add(req.getContextPath() + "/back-end/lecture/select_page.jsp");
		FUN0004.add(req.getContextPath() + "/back-end/lecture/updateLec.jsp");
		FUN0004.add(req.getContextPath() + "/back-end/lecseat/listOneSeat.jsp");
		FUN0004.add(req.getContextPath() + "/back-end/lecorder/listAllLodr.jsp");
		FUN0004.add(req.getContextPath() + "/back-end/speaker/addSpkr.jsp");
		FUN0004.add(req.getContextPath() + "/back-end/speaker/listAllSpkr.jsp");
		FUN0004.add(req.getContextPath() + "/back-end/speaker/listOneSpkr.jsp");
		FUN0004.add(req.getContextPath() + "/back-end/speaker/select_page.jsp");
		FUN0004.add(req.getContextPath() + "/back-end/speaker/updateSpkr.jsp");
		
		
		List<String> FUN0005 = new ArrayList<>();
		FUN0005.add(req.getContextPath() + "/back-end/Order_Master/ListAllOrder.jsp");
		FUN0005.add(req.getContextPath() + "/back-end/Order_Master/ListOneOrder.jsp");
		FUN0005.add(req.getContextPath() + "/back-end/Order_Master/OrderMasterDB.jsp");
		FUN0005.add(req.getContextPath() + "/back-end/Order_Master/update_order_input.jsp");
		FUN0005.add(req.getContextPath() + "/back-end/Order_Detail/listAllOrderDetail.jsp");
		FUN0005.add(req.getContextPath() + "/back-end/Order_Detail/listOneOrderDetail.jsp");
		FUN0005.add(req.getContextPath() + "/back-end/Order_Detail/listOneOrderNo.jsp");
		FUN0005.add(req.getContextPath() + "/back-end/Order_Detail/update_order_input.jsp");
		FUN0005.add(req.getContextPath() + "/back-end/course/editCourseStatus.jsp");

		if (list.contains("FUN0001") && FUN0001.contains(urls)) {
			chain.doFilter(request, response);
		} else if (list.contains("FUN0002") && FUN0002.contains(urls)) {
			chain.doFilter(request, response);
		} else if (list.contains("FUN0003") && FUN0003.contains(urls)) {
			chain.doFilter(request, response);
		} else if (list.contains("FUN0004") && FUN0004.contains(urls)) {
			chain.doFilter(request, response);
		} else if (list.contains("FUN0005") && FUN0005.contains(urls)) {
			chain.doFilter(request, response);
		} else {
			session.setAttribute("error", "你沒有權限!");
			System.out.println("跑到這");
			res.sendRedirect(req.getContextPath() + "/back-end/employee/loginsuccess.jsp");
		}

	}

}
