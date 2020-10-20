package com.video.model;

import java.util.*;

public class VideoService {

	private VideoDAO_interface dao;

	public VideoService() {
		dao = new VideoDAO();
	};

	public VideoVO addVideo(String courseno, Integer testscope, Integer chapterno, String chaptername,
			Integer chapterlen, byte[] video) {
		VideoVO videoVO = new VideoVO();

		videoVO.setCourseno(courseno);
		videoVO.setTestscope(testscope);
		videoVO.setChapterno(chapterno);
		videoVO.setChaptername(chaptername);
		videoVO.setChapterlen(chapterlen);
		videoVO.setVideo(video);
		dao.insert(videoVO);

		return videoVO;
	};

	public VideoVO updateVideo(String videono, String courseno, Integer testscope, Integer chapterno,
			String chaptername, Integer chapterlen, byte[] video) {
		// 有要更新 video 檔案
		VideoVO videoVO = new VideoVO();

		videoVO.setVideono(videono);
		videoVO.setCourseno(courseno);
		videoVO.setTestscope(testscope);
		videoVO.setChapterno(chapterno);
		videoVO.setChaptername(chaptername);
		videoVO.setChapterlen(chapterlen);
		videoVO.setVideo(video);
		dao.update(videoVO);

		return videoVO;
	}

	public VideoVO updateVideo(String videono, String courseno, Integer testscope, Integer chapterno,
			String chaptername) {
		// 不要更新 video 檔案，保有原本的檔案
		VideoVO videoVO = new VideoVO();

		videoVO.setVideono(videono);
		videoVO.setCourseno(courseno);
		videoVO.setTestscope(testscope);
		videoVO.setChapterno(chapterno);
		videoVO.setChaptername(chaptername);

		dao.update(videoVO, false);

		return videoVO;
	}

	public void deleteVideo(String videono) {
		dao.delete(videono);
	}

	public VideoVO getOneVideo(String videono) {
		return dao.findByPrimaryKey(videono);
	}

	public List<VideoVO> getAll() {
		return dao.getAll();
	}

	public List<VideoVO> getAll(Map<String, String[]> map) {
		return dao.getAll(map);
	}
}
