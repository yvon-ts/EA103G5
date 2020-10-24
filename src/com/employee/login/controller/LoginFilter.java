package com.employee.login.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.emp_authority.model.EmpAuthorityService;
import com.emp_authority.model.EmpAuthorityVO;
import com.employee.model.EmployeeService;
import com.employee.model.EmployeeVO;
import com.functionx.model.FunctionxService;
import com.functionx.model.FunctionxVO;

public class LoginFilter implements Filter {

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
		Object empacc = session.getAttribute("empacc");
		
		List<EmpAuthorityVO> empauthlist =  (List<EmpAuthorityVO>) session.getAttribute("empauth");
		
		String urls = req.getRequestURI();
		System.out.println(urls);
		FunctionxService funSvc = new FunctionxService();
		FunctionxVO funurl = funSvc.getUrl(urls);
		
		if (empacc == null) {
			session.setAttribute("location", req.getRequestURI());
			res.sendRedirect(req.getContextPath() + "/back-end/login/login.jsp");
			return;
		}
		
		
		
		if (funurl == null) {
			chain.doFilter(request, response);
			return;
		}
		if (empauthlist.isEmpty()) {
			session.setAttribute("error", "你沒有權限!");
			res.sendRedirect(req.getContextPath() + "/front-end/back-endHomePage.jsp");
			return;
		}

		String funcno = funurl.getFuncno();
		System.out.println(funcno+"========================");
		
		//細節權限還是無法阻擋
		for (EmpAuthorityVO auth : empauthlist) {
			System.out.println(auth.getFuncno().equals(funcno));
			if (auth.getFuncno().equals(funcno)) {
				session.setAttribute("error", "你沒有權限!");
				res.sendRedirect(req.getContextPath() + "/front-end/back-endHomePage.jsp");
			}
		}

		chain.doFilter(request, response);
		
		
		
	}

}
