package com.order_detail.model;

import java.util.List;


public class OrderDetailService {
		
	private OrderDetailDAO dao;
		
	public OrderDetailService() {
		dao = new OrderDetailDAO();
		}
		
	public OrderDetailVO addOrder(String orderno, String courseno, Integer sellprice, String promono){
		
		OrderDetailVO vo = new OrderDetailVO();
		vo.setOrderno(orderno);
		vo.setCourseno(courseno);
		vo.setSellprice(sellprice);
		vo.setPromono(promono);;
		dao.insert(vo,null);
		
		return vo;
	}
	
	public OrderDetailVO updateOrder(String orderno, String courseno, String odstatus) {
		
		OrderDetailVO vo = new OrderDetailVO();
		vo.setOrderno(orderno);
		vo.setCourseno(courseno);
		vo.setOdstatus(odstatus);
		dao.update(vo);
		
		return dao.findByPrimaryKey(orderno, courseno);
	}

	public List<OrderDetailVO> getAll() {
		return dao.getAll();
	}
	
	public List<OrderDetailVO> getOneOrder(String orderno) {
		return dao.findByOrderNo(orderno);
	}
	
	public OrderDetailVO getOneOrderDetail(String orderno, String courseno) {
		return dao.findByPrimaryKey(orderno, courseno);
	}
}
