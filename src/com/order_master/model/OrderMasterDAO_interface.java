package com.order_master.model;

import java.util.List;

import com.order_detail.model.OrderDetailVO;

public interface OrderMasterDAO_interface {
	public void insert(OrderMasterVO orderMasterVO, List<OrderDetailVO> detailList);
	public void update(OrderMasterVO orderMasterVO);
	public OrderMasterVO findByPrimaryKey(String orderNo);
	public List<OrderMasterVO> getAll();
	public List<OrderMasterVO> findByMemno(String memno);
}
