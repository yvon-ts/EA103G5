package com.classroom.model;

import java.io.Serializable;
import java.sql.Timestamp;

public class ClassroomVO implements Serializable {
	private String roomno;
	private String roomname;
	private Integer roomrow;
	private Integer roomcolumn;
	private String defaultseat;
	private Boolean roomdelete;
	private Timestamp roomlastmod;

	public String getRoomno() {
		return roomno;
	}

	public void setRoomno(String roomno) {
		this.roomno = roomno;
	}

	public String getRoomname() {
		return roomname;
	}

	public void setRoomname(String roomname) {
		this.roomname = roomname;
	}

	public Integer getRoomrow() {
		return roomrow;
	}

	public void setRoomrow(Integer roomrow) {
		this.roomrow = roomrow;
	}

	public Integer getRoomcolumn() {
		return roomcolumn;
	}

	public void setRoomcolumn(Integer roomcolumn) {
		this.roomcolumn = roomcolumn;
	}

	public String getDefaultseat() {
		return defaultseat;
	}

	public void setDefaultseat(String defaultseat) {
		this.defaultseat = defaultseat;
	}

	public Boolean getRoomdelete() {
		return roomdelete;
	}

	public void setRoomdelete(Boolean roomdelete) {
		this.roomdelete = roomdelete;
	}

	public Timestamp getRoomlastmod() {
		return roomlastmod;
	}

	public void setRoomlastmod(Timestamp roomlastmod) {
		this.roomlastmod = roomlastmod;
	}

}
