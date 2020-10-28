package com.order_detail.model;

import java.sql.Connection;
import java.util.List;
import java.util.Map;


public interface OrderDetailDAO_interface {
	public void insert(OrderDetailVO orderDetailVO, Connection con);
	public void update(OrderDetailVO orderDetailVO);
	public void refund(OrderDetailVO orderDetailVO);
	public List<OrderDetailVO> getAll(Map<String, String[]> map);
	public List<OrderDetailVO> findByOrderNo(String orderno);
	public OrderDetailVO findByPrimaryKey(String orderno, String courseno);
	
}
