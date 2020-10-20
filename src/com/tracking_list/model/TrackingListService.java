package com.tracking_list.model;

import java.util.List;



public class TrackingListService {
	private TrackingListDAO_interface dao;

	public TrackingListService() {
		dao = new TrackingListDAO();

	}

	// insert
	public TrackingListVO addTracking(String memno, String courseno) {

		TrackingListVO trackinglistVO = new TrackingListVO();

		trackinglistVO.setMemno("memno");
		trackinglistVO.setCourseno("courseno");

		return trackinglistVO;

	}

	// delete
	public TrackingListVO deleteTracking(String memno, String courseno) {
		
		TrackingListVO trackinglistVO = new TrackingListVO();

		trackinglistVO.setMemno("memno");
		trackinglistVO.setCourseno("courseno");

		return trackinglistVO;

	}

	// getByMemno
	public List<TrackingListVO> findByMemno(String memno) {
		return dao.findByMemno(memno);
	}
	

	// getAll
	public List<TrackingListVO> getAll() {
		return dao.getAll();
	}

}