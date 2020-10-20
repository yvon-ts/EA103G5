package com.anwser_list.model;

import java.util.List;

public class TestAll {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		AnwserListJDBCDAO ans = new AnwserListJDBCDAO();
		
//		AnwserListVO vo = new AnwserListVO("TEST0001","QNBK0036",2,"1234","0010");
//		ans.insert(vo);
//		String[] s = {"456"};
//		ans.submitAns(s);
		
//		List<AnwserListVO> list = ans.getByTestNO("TEST0008");
//		
//		for(AnwserListVO vo : list) {
//			System.out.println(vo);
//		}
		AnwserListVO vo = ans.getOneByQBNO("QNBK0001","TEST0004");
		System.out.println(vo);
	}

}
