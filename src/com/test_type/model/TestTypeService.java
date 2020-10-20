package com.test_type.model;

import java.util.List;

public class TestTypeService {
	TestTypeDAO_interface dao = null;
	public  TestTypeService() {
		dao = new TestTypeDAO();
	}
	public void update(int testtypeno, String testtype, String testdgee) {
		TestTypeVO testTypeVO = new TestTypeVO();
		testTypeVO.setTesttypeno(testtypeno);
		testTypeVO.setTesttype(testtype);
		testTypeVO.setTestdgee(testdgee);
		dao.update(testTypeVO);
	}
	void insert(String testtype, String testdgee) {
		TestTypeVO testTypeVO = new TestTypeVO();
		testTypeVO.setTesttype(testtype);
		testTypeVO.setTestdgee(testdgee);
		dao.insert(testTypeVO);
	}
	public TestTypeVO getOnebyNO(int testtypeno) {
		return dao.findByPrimaryKey(testtypeno);
	}
	public List<TestTypeVO> getAll(){
		return dao.findAll();
	}
	
}
