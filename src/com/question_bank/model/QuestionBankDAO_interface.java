package com.question_bank.model;

import java.util.List;
import java.util.Map;
import java.util.Set;

public interface QuestionBankDAO_interface {
	QuestionBankVO insertQuestion(QuestionBankVO questionVO);
	void delete(String qbankno);
	QuestionBankVO update(QuestionBankVO questionVO);
	QuestionBankVO findByNO(String qbankno);
	List<QuestionBankVO> findAll();
	List<QuestionBankVO> findArea(int testtypeno);
	
	List<QuestionBankVO> findAll(Map<String, String[]> map); //複合查詢
}
