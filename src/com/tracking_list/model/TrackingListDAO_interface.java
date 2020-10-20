package com.tracking_list.model;

import java.util.List;


public interface TrackingListDAO_interface {
	public void insert(TrackingListVO trackVO);
	public void delete(TrackingListVO trackVO);
	public List<TrackingListVO> findByMemno(String memno);
	public List<TrackingListVO> getAll();
	

}
