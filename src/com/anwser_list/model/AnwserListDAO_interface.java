package com.anwser_list.model;

import java.sql.Connection;
import java.util.List;
import java.util.Map;

public interface AnwserListDAO_interface {
	void insert(AnwserListVO anwserListvo , Connection con);//新增考題進此紀錄
	void submitAns(Map<String,String> studentAns,String testno);//繳交答案
	List<AnwserListVO> getByTestNO(String testno);//列出某一考卷編號所有題目
	int compareToAns(String testno); //比對答案
	AnwserListVO getOneByQBNO(String  qbankno,String testno);//列出某考卷某題的紀錄
}
