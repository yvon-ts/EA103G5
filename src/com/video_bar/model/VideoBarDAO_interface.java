package com.video_bar.model;

import java.util.List;

public interface VideoBarDAO_interface {
	public void insert(VideoBarVO videoBarVO);
	public void update(VideoBarVO videoBarVO);
	public VideoBarVO findByPrimaryKey(String memno, String videono);
	public List<VideoBarVO> getAll();
	// 萬用複合查詢(傳入參數型態Map)(回傳 List)
	// public List<EmpVO> getAll(Map<String, String[]> map);
}
