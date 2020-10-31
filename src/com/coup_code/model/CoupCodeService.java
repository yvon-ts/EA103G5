package com.coup_code.model;

import java.sql.Connection;
import java.sql.Date;
import java.util.List;
import java.util.Random;

public class CoupCodeService {
	private CoupCodeDAO dao;

	public CoupCodeService() {
		dao = new CoupCodeDAO();
	}

	public CoupCodeVO addCoupCode(String memno, String coupcode, Integer discamt, Date coupexp) {

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

	public List<CoupCodeVO> getMemberCoup(String memno) {
		return dao.findByMemno(memno);
	}

	public CoupCodeVO welcome1(String memno, Connection con) {

		CoupCodeVO vo = new CoupCodeVO();

		// 隨機四碼英數
		String val = "";
		Random random = new Random();
		for (int i = 0; i < 4; i++) {
			String charOrNum = random.nextInt(2) % 2 == 0 ? "char" : "num";
			if ("char".equalsIgnoreCase(charOrNum)) {
				int temp = random.nextInt(2) % 2 == 0 ? 65 : 97;
				val += (char) (random.nextInt(26) + temp);
			} else if ("num".equalsIgnoreCase(charOrNum)) {
				val += String.valueOf(random.nextInt(10));
			}
		}

		vo.setMemno(memno);
		vo.setCoupcode(val);
		vo.setDiscamt(200);
		vo.setCoupexp(java.sql.Date.valueOf("2020-11-30"));
		dao.autogive(vo, con);

		return vo;
	}
	
	public CoupCodeVO welcome2(String memno,  Connection con) {

		CoupCodeVO vo = new CoupCodeVO();

		// 隨機四碼英數
		String val = "";
		Random random = new Random();
		for (int i = 0; i < 4; i++) {
			String charOrNum = random.nextInt(2) % 2 == 0 ? "char" : "num";
			if ("char".equalsIgnoreCase(charOrNum)) {
				int temp = random.nextInt(2) % 2 == 0 ? 65 : 97;
				val += (char) (random.nextInt(26) + temp);
			} else if ("num".equalsIgnoreCase(charOrNum)) {
				val += String.valueOf(random.nextInt(10));
			}
		}

		vo.setMemno(memno);
		vo.setCoupcode(val);
		vo.setDiscamt(150);
		vo.setCoupexp(java.sql.Date.valueOf("2020-11-30"));
		dao.autogive(vo, con);

		return vo;
	}
}
