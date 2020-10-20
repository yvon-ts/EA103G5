package com.promo_list.model;

import java.sql.Date;
import java.util.List;

public class PromoListService {
	private PromoListDAO dao;
	
	public PromoListService() {
		dao = new PromoListDAO();
	}
	
	public PromoListVO addPromoList(String promoname, Date startdate, Date enddate, String promoinfo){
		
		PromoListVO vo = new PromoListVO();
		vo.setPromoname(promoname);
		vo.setStartdate(startdate);
		vo.setEnddate(enddate);
		vo.setPromoinfo(promoinfo);
		dao.insert(vo);
		
		return vo;
	}
	
	public PromoListVO updatePromoList(String promono, String promoname, Date startdate, Date enddate, String promoinfo) {
		
		PromoListVO vo = new PromoListVO();
		vo.setPromoname(promoname);
		vo.setStartdate(startdate);
		vo.setEnddate(enddate);
		vo.setPromoinfo(promoinfo);
		vo.setPromono(promono);
		
		dao.update(vo);
		
		return vo;
	}
	
	public void deletePromoList(String promono) {
		dao.delete(promono);
	}

	public PromoListVO getOnePromoList(String promono) {
		return dao.findByPrimaryKey(promono);
	}

	public List<PromoListVO> getAll() {
		return dao.getAll();
	}
}
