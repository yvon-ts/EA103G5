package com.order_master.model;

import java.util.List;
import com.coup_code.model.*;

import com.order_detail.model.OrderDetailVO;

public class OrderMasterService {
	
	private OrderMasterDAO dao;
	
	public OrderMasterService() {
		dao = new OrderMasterDAO();
	}
	
	public OrderMasterVO addOrder(String memno, Integer orderamt, String coupno, String payby, List<OrderDetailVO> list){
		System.out.println("進入service");
		OrderMasterVO vo = new OrderMasterVO();
		
		vo.setMemno(memno);
		vo.setOrderamt(orderamt);
		vo.setCoupno(coupno);
		vo.setPayby(payby);
		dao.insert(vo,list);
		
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
