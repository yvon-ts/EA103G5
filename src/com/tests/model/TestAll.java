package com.tests.model;

import java.sql.Timestamp;
import java.util.List;

public class TestAll {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
//		System.out.println();
		
		TestsJDBCDAO dao = new TestsJDBCDAO();
//		TestVO vo = new TestVO();
//		vo.setCourseno("COUR0001");
//		vo.setMemno("MEM0001");
//		vo.setTestscope("7");
//		vo.setScore(60.0);
//		vo.setTesttime(new Timestamp(new java.util.Date().getTime()));
//		System.out.println(dao.insert(vo));
		
		TestsVO vo = dao.findById("TEST0001");
		System.out.println(vo);
		
		
//		List<TestVO> list = dao.findByAll();
//		for(TestVO testvo : list ) {
//			System.out.println(testvo);
//		}
	}

}
