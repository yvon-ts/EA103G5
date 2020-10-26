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


	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		

		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse res = (HttpServletResponse) response;
		
		
		HttpSession session = req.getSession();
		List<EmpAuthorityVO> empauthlist =  (List<EmpAuthorityVO>) session.getAttribute("empauth");
		
		List<String> list = new ArrayList<>();
		
		for(int i=0 ; i<empauthlist.size() ; i++) {
			list.add(empauthlist.get(i).getFuncno());
		}
		
		String urls = req.getRequestURI();
		List<String> FUN0001 = new ArrayList<>();
		FUN0001.add(req.getContextPath()+"/front-end/back-endHomePage.jsp");
		FUN0001.add(req.getContextPath()+"/back-end/employee/newallemp.jsp");
		FUN0001.add(req.getContextPath()+"/back-end/employee/newadd_emp.jsp");
		FUN0001.add(req.getContextPath()+"/back-end/employee/newupdate_emp.jsp");

		
		if(list.contains("FUN0001") && FUN0001.contains(urls)) {
			chain.doFilter(request, response);	
		}else {
//			chain.doFilter(request, response);	
			res.sendRedirect(req.getContextPath() + "/front-end/back-endHomePage.jsp");
		}
		
	}




}
