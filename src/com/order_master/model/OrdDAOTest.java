package com.order_master.model;

import java.util.ArrayList;
import java.util.List;

import com.order_detail.model.OrderDetailVO;

public class OrdDAOTest {

	public static void main(String[] args) {
		OrderMasterDAO dao = new OrderMasterDAO();
		// 新增
		OrderMasterVO vo = new OrderMasterVO();
		vo.setMemno("MEM0001");
		vo.setOrderamt(1500);
		vo.setPayby("信用卡");
		
		OrderDetailVO detailVO1 = new OrderDetailVO();
		detailVO1.setCourseno("COUR0001");
		detailVO1.setSellprice(150);
		detailVO1.setPromono(null);
		
		OrderDetailVO detailVO2 = new OrderDetailVO();
		detailVO2.setCourseno("COUR0002");
		detailVO2.setSellprice(3000);
		detailVO2.setPromono(null);
		
		List<OrderDetailVO> detailList = new ArrayList<>();
		detailList.add(detailVO1);
		detailList.add(detailVO2);
		
		System.out.println(detailVO1);
		
		dao.insert(vo, detailList);
		System.out.println("新增成功!!");

		// 修改
//		OrderMasterVO orderMasterVO2 = new OrderMasterVO();
//		orderMasterVO2.setOrderno("ORD0001");
//		orderMasterVO2.setOrderstatus("已結單");
//		dao.update(orderMasterVO2);

		// 查詢單一
//			OrderMasterVO orderMasterVO3 = dao.findByPrimaryKey("ORD0001");
//			System.out.print(orderMasterVO3.getOrderno() + ",");
//			System.out.print(orderMasterVO3.getMemno() + ",");
//			System.out.print(orderMasterVO3.getOrderdate() + ",");
//			System.out.print(orderMasterVO3.getOrderstatus() + ",");
//			System.out.print(orderMasterVO3.getOrderamt() + ",");
//			System.out.print(orderMasterVO3.getCoupno() + ",");
//			System.out.print(orderMasterVO3.getPayby());
//			System.out.println("\n-------------------------------");
//		

		// 查詢全部
//		List<OrderMasterVO> list = dao.getAll();
//		for (OrderMasterVO aOrderMaster : list) {
//
//			System.out.print(aOrderMaster.getOrderno() + ",");
//			System.out.print(aOrderMaster.getMemno() + ",");
//			System.out.print(aOrderMaster.getOrderdate() + ",");
//			System.out.print(aOrderMaster.getOrderstatus() + ",");
//			System.out.print(aOrderMaster.getOrderamt() + ",");
//			System.out.print(aOrderMaster.getCoupno() + ",");
//			System.out.print(aOrderMaster.getPayby());
//			System.out.println();
//		}

			// 刪除
//			dao.delete("4001");

		}
	}

