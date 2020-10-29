package com.order_detail.model;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.course.model.CourseVO;

public class OrderDetailService {

	private OrderDetailDAO dao;

	public OrderDetailService() {
		dao = new OrderDetailDAO();
	}

	public OrderDetailVO addOrder(String orderno, String courseno, Integer sellprice, String promono) {

		OrderDetailVO vo = new OrderDetailVO();
		vo.setOrderno(orderno);
		vo.setCourseno(courseno);
		vo.setSellprice(sellprice);
		vo.setPromono(promono);
		dao.insert(vo, null);

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

	public List<OrderDetailVO> getAll(Map<String, String[]> map) {
		return dao.getAll(map);
	}

	public List<OrderDetailVO> getOneOrder(String orderno) {
		return dao.findByOrderNo(orderno);
	}

	public OrderDetailVO getOneOrderDetail(String orderno, String courseno) {
		return dao.findByPrimaryKey(orderno, courseno);
	}

	public OrderDetailVO updateRefund(String orderno, String courseno) {

		OrderDetailVO vo = new OrderDetailVO();
		vo.setOrderno(orderno);
		vo.setCourseno(courseno);
		vo.setOdstatus("申請退款");
		dao.update(vo);
		
		return dao.findByPrimaryKey(orderno, courseno);
	}
	
	public boolean boughtNot(List<OrderDetailVO> list, String couseno, String memno) {
		
		boolean own = false;
		
		List<String> coursenos = new ArrayList<String>();
		list =  dao.findByMemberNo(memno);
		for(OrderDetailVO a : list) {
			coursenos.add(a.getCourseno()) ;
		}
		own = coursenos.contains(couseno);
		
		return own;
	}
}
