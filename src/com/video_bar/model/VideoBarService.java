package com.video_bar.model;

import java.util.List;

public class VideoBarService {

	private VideoBarDAO_interface dao;

	public VideoBarService() {
		dao = new VideoBarDAO();
	};

	public VideoBarVO addVideoBar(String memno, String videono, Integer videosec, Integer videottltime) {

		VideoBarVO videoBarVO = new VideoBarVO();

		videoBarVO.setMemno(memno);
		videoBarVO.setVideono(videono);
		videoBarVO.setVideosec(videosec);
		videoBarVO.setVideottltime(videottltime);
		dao.insert(videoBarVO);

		return videoBarVO;
	}

	public VideoBarVO updateVideoBar(String memno, String videono, Integer videosec, Integer videottltime) {

		VideoBarVO videoBarVO = new VideoBarVO();

		videoBarVO.setMemno(memno);
		videoBarVO.setVideono(videono);
		videoBarVO.setVideosec(videosec);
		videoBarVO.setVideottltime(videottltime);
		dao.update(videoBarVO);

		return videoBarVO;
	}

	public VideoBarVO getOneVideoBar(String memno, String videono) {
		return dao.findByPrimaryKey(memno, videono);
	}

	public List<VideoBarVO> getAll() {
		return dao.getAll();
	}

}
