package com.anwser_list.model;

import java.util.List;
import java.util.Map;

public class AnwserListService {
	AnwserListDAO_interface dao = null;
	
	public AnwserListService() {
		dao = new AnwserListDAO();
	}
	
//	public void insert(String testno, String qbankno, Integer quno, String testans, String oporder) { //產生考卷時接著產生明細，此方法放棄
//		AnwserListVO vo = new AnwserListVO();
//		vo.setTestno(testno);
//		vo.setQbankno(qbankno);
//		vo.setQuno(quno);
//		vo.setTestans(testans);
//		vo.setOporder(oporder);
//		dao.insert(vo);
//	}
	public void submitAns(Map<String,String> studentAns,String testno) {
		dao.submitAns(studentAns,testno);
	}
	
	public List<AnwserListVO> getTestData(String testno){
		return dao.getByTestNO(testno);
	}
	public int compareToAns(String testno) {
		return dao.compareToAns(testno);
	}
	public AnwserListVO getOneByQBNO(String qbankno,String testno) {
		return dao.getOneByQBNO(qbankno,testno);
	}
}
