package com.video.model;

import java.io.Serializable;
import java.sql.Blob;

public class VideoVO implements Serializable {
	private String videono;
	private String courseno;
	private Integer testscope;
	private Integer chapterno;
	private String chaptername;
	private Integer chapterlen;
	private byte[] video;

	public String getVideono() {
		return videono;
	}

	public void setVideono(String videono) {
		this.videono = videono;
	}

	public String getCourseno() {
		return courseno;
	}

	public void setCourseno(String courseno) {
		this.courseno = courseno;
	}

	public Integer getTestscope() {
		return testscope;
	}

	public void setTestscope(Integer testscope) {
		this.testscope = testscope;
	}

	public Integer getChapterno() {
		return chapterno;
	}

	public void setChapterno(Integer chapterno) {
		this.chapterno = chapterno;
	}

	public String getChaptername() {
		return chaptername;
	}

	public void setChaptername(String chaptername) {
		this.chaptername = chaptername;
	}

	public Integer getChapterlen() {
		return chapterlen;
	}

	public void setChapterlen(Integer chapterlen) {
		this.chapterlen = chapterlen;
	}

	public byte[] getVideo() {
		return video;
	}

	public void setVideo(byte[] video) {
		this.video = video;
	}

}
