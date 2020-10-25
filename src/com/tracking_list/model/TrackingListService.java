package com.tracking_list.model;

import java.util.List;



public class TrackingListService {
	private TrackingListDAO_interface dao;

	public TrackingListService() {
		dao = new TrackingListDAO();

	}

	// insert
	public void addTracking(String memno, String courseno) {

		TrackingListVO trackinglistVO = new TrackingListVO();

		trackinglistVO.setMemno(memno);
		trackinglistVO.setCourseno(courseno);

		dao.insert(trackinglistVO);

	}

	// delete
	public int  deleteTracking(String memno, String courseno) {
		
		TrackingListVO trackinglistVO = new TrackingListVO();

		trackinglistVO.setMemno(memno);
		trackinglistVO.setCourseno(courseno);

		return dao.delete(trackinglistVO);

	}

	// getByMemno
	public List<TrackingListVO> getOneByMemno(String memno) {
		
		return dao.findByMemno(memno);
	}
	

	// getAll
	public List<TrackingListVO> getAll(String memno) {
		return dao.getAll( memno);
	}

}