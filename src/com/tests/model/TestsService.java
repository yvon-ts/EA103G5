package com.tests.model;

import java.sql.Timestamp;
import java.util.List;

import com.anwser_list.model.AnwserListVO;

public class TestsService {
	TestsDAO_interface  dao = null;
	
	private String testno;
	
	public String getTestno() {
		return testno;
	}

	public void setTestno(String testno) {
		this.testno = testno;
	}

	public  TestsService() {
		dao = new TestsDAO();
	}
	public  TestsService(String testno) {
		this.setTestno(testno);
		dao = new TestsDAO();
	}
	
	public String insert(TestsVO test) {
		this.setTestno(dao.insert(test));
		return this.getTestno();
	}
	
	public TestsVO getOneByNO(String testno) {
		return dao.findById(testno);
	}
	
	public List<TestsVO> getAll(String memno,String courseno){
		return dao.findByAll(memno , courseno);
	}
	
	public void  writeScore(int correctNumber,String testno) {
		dao.updateScore(correctNumber, testno);
	}
	
	public String insertToAnwserList(TestsVO test,List<AnwserListVO> list) {
		String testno = dao.insertToAnwserList(test, list);
		this.setTestno(testno);
		return testno;
	}
}
