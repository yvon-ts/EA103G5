package com.tracking_list.model;

import java.util.List;


public interface TrackingListDAO_interface {
	public void insert(TrackingListVO trackVO);
	public int  delete(TrackingListVO trackVO);
	public List<TrackingListVO> findByMemno(String memno);
	public List<TrackingListVO> getAll(String memno);
	

}
