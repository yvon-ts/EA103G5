package com.employee.controller;

import java.io.IOException;
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



public class AuthorityFilter implements Filter {

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
		Object empacc = session.getAttribute("empacc");
		
		System.out.println(empacc);
		
		EmployeeService empSvc = new EmployeeService();		
		EmployeeVO empVO =  empSvc.getEmpAcc((String) empacc);
		String empno = empVO.getEmpno();
	
		EmpAuthorityService  empAuth = new EmpAuthorityService();
		List<EmpAuthorityVO> empAuthList = empAuth.findByEmp(empno);
		
		FunctionxService funcSvc = new FunctionxService();
		List<FunctionxVO> funcVO = funcSvc.getAll();		
//		
//		for(EmpAuthorityVO empauthvo : empAuthList) {
//			empauthvo.getEmpno().equals()
//		}

//		if (empAuthorityVO != null) {
//			session.setAttribute("location", req.getRequestURI());
//			res.sendRedirect(req.getContextPath() + "/back-end/login/login.jsp");
//			return;
//		} else	
//			System.out.println("成功轉");	
		chain.doFilter(request, response);
	}

}
