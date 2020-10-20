package com.test_type.model;

import java.util.List;

public class TestAll {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		TestTypeJDBCDAO t = new TestTypeJDBCDAO();
//		TestTypeVO vo = new TestTypeVO();
//		vo.setTesttypeno(5);
//		vo.setTesttype("text");
//		vo.setTestdgee("²��");
//		t.update(vo);
		List<TestTypeVO> list = t.findAll();
		for(TestTypeVO vo : list) {
			System.out.println(vo);
		}
	}

}
