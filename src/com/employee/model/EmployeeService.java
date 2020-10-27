package com.employee.model;

import java.util.List;
import java.util.Optional;

public class EmployeeService {
	
	private EmployeeDAO_interface dao;

//	public EmployeeService() {
//		dao = new EmployeeJDBCDAO();
//	}
//	
	public EmployeeService() {
		dao = new EmployeeJNDIDAO();
	}
//	
	//增加員工
	public EmployeeVO addEmp(String empacc, String emppwd, String empname, Integer empsalary
			, java.sql.Date hiredate, String empemail, byte[] emppic) {
		
		EmployeeVO employeeVO = new EmployeeVO();
		
		employeeVO.setEmpacc(empacc);
		employeeVO.setEmppwd(emppwd);
		employeeVO.setEmpname(empname);
		employeeVO.setEmpsalary(empsalary);
		employeeVO.setHiredate(hiredate);
		employeeVO.setEmpemail(empemail);
		employeeVO.setEmppic(emppic);
		employeeVO.setEmpno(dao.insertWithEmp(employeeVO));
		return employeeVO;	
	}
	//更新員工資料
	 public EmployeeVO updateEmp(String empno,String empacc, String emppwd, String empname, Integer empsalary
			 , java.sql.Date hiredate, String empemail, Integer empdelete, byte[] emppic) {
		 
		 EmployeeVO employeeVO = new EmployeeVO();
		 employeeVO.setEmpno(empno);
		 employeeVO.setEmpacc(empacc); 
		 employeeVO.setEmppwd(emppwd);
		 employeeVO.setEmpname(empname);
		 employeeVO.setEmpsalary(empsalary);
		 employeeVO.setHiredate(hiredate);
		 employeeVO.setEmpemail(empemail);
		 employeeVO.setEmpdelete(empdelete);
		 employeeVO.setEmppic(emppic);
		 dao.update(employeeVO);
		 return employeeVO;		 
	 }
	 
	 public EmployeeVO updatepwd(String empno, String emppwd, String empemail, byte[] emppic) {
		 
		 EmployeeVO employeeVO = new EmployeeVO();
		 employeeVO.setEmpno(empno);
		 employeeVO.setEmppwd(emppwd);
		 employeeVO.setEmpemail(empemail);
		 employeeVO.setEmppic(emppic);
		 dao.updatePwd(employeeVO);
		 return employeeVO;		 
	 }

	 
	 //查詢
	 public EmployeeVO getEmp(String empno) {
		 return dao.findByPrimaryKey(empno);
	 }
	 
	 public List<EmployeeVO> getAll(){
		 return dao.getAll();
	 }
	 
	 public EmployeeVO logIn(String empacc, String emppwd) {
		 return dao.logIn(empacc, emppwd);
	 }
	 
	 public EmployeeVO getEmpAcc(String empacc) {
		 return dao.getOneAcc(empacc);
	 }
	 
	 public Optional<EmployeeVO> getEmpPicByEmpno(String empno){
			return dao.findEmpPicByEmpno(empno);
		}
}
