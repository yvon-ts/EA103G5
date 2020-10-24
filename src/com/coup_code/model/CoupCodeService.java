package com.coup_code.model;

import java.sql.Date;
import java.util.List;


public class CoupCodeService {
	private CoupCodeDAO dao;
	
	public CoupCodeService() {
		dao = new CoupCodeDAO();
	}
	
	public CoupCodeVO addCoupCode(String memno, String coupcode, Integer discamt, Date coupexp){
		
		CoupCodeVO vo = new CoupCodeVO();
		vo.setMemno(memno);
		vo.setCoupcode(coupcode);
		vo.setDiscamt(discamt);
		vo.setCoupexp(coupexp);
		dao.insert(vo);
		
		return vo;
	}
	
	public CoupCodeVO updateCoupCode(String coupno, Integer discstatus) {
		
		CoupCodeVO vo = new CoupCodeVO();
		vo.setCoupno(coupno);
		vo.setDiscstatus(discstatus);
		dao.update(vo);
		
		return getOneCoupCode(coupno);
	}
	

	public CoupCodeVO getOneCoupCode(String coupno) {
		return dao.findByPrimaryKey(coupno);
	}
	
	public CoupCodeVO getOneCoupno(String coupname) {
		return dao.findByCoupCode(coupname);
	}

	public List<CoupCodeVO> getAll() {
		return dao.getAll();
	}
}
