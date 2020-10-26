package com.employee.controller;


import java.io.IOException;
import java.io.OutputStream;
import java.util.Optional;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.employee.model.EmployeeService;
import com.employee.model.EmployeeVO;



@WebServlet("/ShowEmpPic")
public class ShowEmpPic extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		res.setContentType("image/*");
		String empno = req.getParameter("empno");
		if (empno != null) {
			EmployeeService empSvc = new EmployeeService();
			Optional<EmployeeVO> employeeVO = empSvc.getEmpPicByEmpno(empno);
			
			if (employeeVO.isPresent()) {
				OutputStream os = res.getOutputStream();
				os.write(employeeVO.get().getEmppic());
			}
		}
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		doGet(req, res);
	}

}
