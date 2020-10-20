package com.tests.model;

import java.util.List;

import com.anwser_list.model.AnwserListVO;

public interface TestsDAO_interface {
	String insert(TestsVO test);//新增考試
	TestsVO findById(String testno);//更新考題
	List<TestsVO> findByAll(String memno);//查某會員的考試紀錄
	void updateScore(int correctNumber,String testno);//將計算後的分數放進此次的分數欄位
	
	String  insertToAnwserList(TestsVO test,List<AnwserListVO> list);
}
