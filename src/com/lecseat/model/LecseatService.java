package com.lecseat.model;

import java.util.List;

import com.lecorder.model.LodrVO;

public class LecseatService {
		
		private LecseatDAO_Interface dao;
		
		public LecseatService() {
			dao = new LecseatDAO();
		}
		
		public List<LecseatVO> getSeatsByOrder(String lodrno) {
			return dao.getOrderDetails(lodrno);
		}
		
		public int hasBooked(String memno, String lecno) {
			return dao.countMemSeats(memno, lecno);
		}

}

