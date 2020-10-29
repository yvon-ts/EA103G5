package com.question_bank.model;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import oracle.sql.CLOB;

public class QuestionBankService {
	QuestionBankDAO_interface dao = null;

	public QuestionBankService() {
		dao = new QuestionBankDAO();
	}

	public QuestionBankVO insertQuestion(QuestionBankVO vo) {
		return dao.insertQuestion(vo);
	}

	public QuestionBankVO update(QuestionBankVO vo) {
		return dao.update(vo);
	}

	public void delete(String qbankno) {
		dao.delete(qbankno);
	}

	public QuestionBankVO getOneByNO(String qbankno) {
		return dao.findByNO(qbankno);
	}

	public List<QuestionBankVO> getAll(String courseno) {
		return dao.findAll(courseno);
	}

	public List<QuestionBankVO> findArea(int testtypeno) {
		return dao.findArea(testtypeno);
	}

	public List<QuestionBankVO> getAll(Map<String, String[]> map) {
		return dao.findAll(map);
	}

}
