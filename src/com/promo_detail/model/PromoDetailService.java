package com.promo_detail.model;

import java.util.List;

public class PromoDetailService {
	private PromoDetailDAO dao;
	
	public PromoDetailService() {
		dao = new PromoDetailDAO();
	}
	
	public PromoDetailVO addPromoDetail(String promono, String cstypeno, Integer percentage){
		
		PromoDetailVO vo = new PromoDetailVO();
		vo.setPromono(promono);
		vo.setCstypeno(cstypeno);
		vo.setPercentage(percentage);
		dao.insert(vo);
		
		return vo;
	}
	
	public PromoDetailVO updatePromoDetail(String promono, String cstypeno, Integer percentage) {
		
		PromoDetailVO vo = new PromoDetailVO();
		vo.setPromono(promono);
		vo.setCstypeno(cstypeno);
		vo.setPercentage(percentage);
		dao.update(vo);
		
		return vo;
	}
	
	public void deletePromoDetail(String promono, String cstypeno) {
		dao.delete(promono, cstypeno);
	}

	public PromoDetailVO getOnePromoDetail(String promono, String cstypeno) {
		return dao.findByPrimaryKey(promono, cstypeno);
	}

	public List<PromoDetailVO> getAll() {
		return dao.getAll();
	}
}
