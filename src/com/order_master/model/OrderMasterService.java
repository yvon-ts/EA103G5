package com.order_master.model;

import java.util.List;

public class OrderMasterService {
	
	private OrderMasterDAO dao;
	
	public OrderMasterService() {
		dao = new OrderMasterDAO();
	}
	
	public OrderMasterVO addOrder(String memno, java.sql.Date orderdate, Integer orderamt, String coupno, String payby){
		
		OrderMasterVO vo = new OrderMasterVO();
		vo.setMemno(memno);
		vo.setOrderdate(orderdate);
		vo.setOrderamt(orderamt);
		vo.setCoupno(coupno);
		vo.setPayby(payby);
		dao.insert(vo,null);
		
		return vo;
	}
	
	public OrderMasterVO updateOrder(String orderno, String orderstatus) {
		
		OrderMasterVO vo = new OrderMasterVO();
		vo.setOrderno(orderno);
		vo.setOrderstatus(orderstatus);
		dao.update(vo);
		
		return getOneOrder(orderno);
	}
	

	public OrderMasterVO getOneOrder(String orderno) {
		return dao.findByPrimaryKey(orderno);
	}

	public List<OrderMasterVO> getAll() {
		return dao.getAll();
	}
	
	public List<OrderMasterVO> getOnesOrder(String memno) {
		return dao.findByMemno(memno);
	}
}
