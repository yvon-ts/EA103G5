package com.video_bar.model;

import java.io.Serializable;
import java.sql.Date;

public class VideoBarVO implements Serializable {
	private String memno;
	private String videono;
	private Integer videosec;
	private Integer videottltime;
	private Date videolasttime;

	public String getMemno() {
		return memno;
	}

	public void setMemno(String memno) {
		this.memno = memno;
	}

	public String getVideono() {
		return videono;
	}

	public void setVideono(String videono) {
		this.videono = videono;
	}

	public Integer getVideosec() {
		return videosec;
	}

	public void setVideosec(Integer videosec) {
		this.videosec = videosec;
	}

	public Integer getVideottltime() {
		return videottltime;
	}

	public void setVideottltime(Integer videottltime) {
		this.videottltime = videottltime;
	}

	public Date getVideolasttime() {
		return videolasttime;
	}

	public void setVideolasttime(Date videolasttime) {
		this.videolasttime = videolasttime;
	}
}
