package com.question_bank.model;

import java.util.ArrayList;
//import java.util.ArrayList;
import java.util.List;
import java.util.Set;

public class TestAll {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		QuestionBankJDBCDAO dao = new QuestionBankJDBCDAO();
//		-----------------addMultipleTest-----------------
//		int multiple = dao.insertMultiple(new QuestionVO( "COUR0001" , 7 , "下�?��?�述中�?�哪些符??�Java語�???�特�?" , " ?��?��跨平?��(Windows，Linux，Unix�?" ,"GC(?��??��?�圾??�收)，�?��?��?��?��?�碼安全??","?��?��類C??��?��?��?��?��?��??","不支?��??�其它�?��??��寫�?��?��?��?��?��?��??","1100",null));
//		System.out.println(multiple);

//		-----------------addFillTest-----------------	
//		int fill = dao.insertFill(new QuestionVO( "COUR0001" , 5, "下�?��?�述中�?�哪些符??�Java語�???�特�?" ,"1100",null));
//		System.out.println(fill);

//		-----------------deleteTest-----------------			
//		dao.delete("QNBK0092");
//		-----------------updateTest-----------------		
//		dao.update(new QuestionVO("QNBK0091","COUR0001",6,"X","B","C","D","E","A",null));
//		-----------------getOneTest-----------------		
//		System.out.println(dao.findByNO("QNBK0091"));
//		-----------------getAllTest-----------------		
//		List<QuestionBankVO> list = new ArrayList<>();
//		list = dao.findAll();
//		for(QuestionBankVO i : list) {
//			System.out.println(i);
//		}
//		-----------------findAreaTest-----------------				
//		List<QuestionVO> list = new ArrayList<>();
//		for (int i = 0; i < 3; i++) {
//			list = dao.findArea(1+3*i);
//			for (QuestionVO s : list) {
//				System.out.println(s);
//			}
//		}
//		-----------------findAreaTest-----------------	
		
//		Set<QuestionVO> set  =dao.pickFromDB(3,10);
//		System.out.println(set.size());
//		for (QuestionVO s : set) {
//			System.out.println(s);
//		}
//		
//		List<QuestionVO> list = dao.pickUp("simple");
//		System.out.println(list.size());
//		for (QuestionVO s : list) {
//			System.out.println(s);
//		}
		QuestionBankVO vo = new QuestionBankVO();
		vo.setCourseno("COUR0001");
		vo.setTypeno(2);
		vo.setTestscope("單元一");
		vo.setQustmt("1+1");
		vo.setQuans("2");
		dao.insertQuestion(vo);
	}

}
