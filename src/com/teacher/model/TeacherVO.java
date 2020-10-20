package com.teacher.model;

import java.sql.*;
import java.util.Arrays;

public class TeacherVO implements java.io.Serializable {
	private String tchrno;
	private String memno;
	private String tchrintro;
	private byte[] tchrcert1;
	private byte[] tchrcert2;
	private String tchrstatus;
	private String rejreason;
	private String bankacc;
	
	public TeacherVO() {
		
	}
    
//	@Override
//	public String toString() {
//		return "TeacherVO [tchrno=" + tchrno + ", memno=" + memno + ", tchrintro=" + tchrintro + ", tchrcert1="
//				+ Arrays.toString(tchrcert1) + ", tchrcert2=" + Arrays.toString(tchrcert2) + ", tchrstatus="
//				+ tchrstatus + ", rejreason=" + rejreason + ", bankacc=" + bankacc + "]";
//	}

	public String getTchrno() {
		return tchrno;
	}

	public void setTchrno(String tchrno) {
		this.tchrno = tchrno;
	}

	public String getMemno() {
		return memno;
	}

	public void setMemno(String memno) {
		this.memno = memno;
	}

	public String getTchrintro() {
		return tchrintro;
	}

	public void setTchrintro(String tchrintro) {
		this.tchrintro = tchrintro;
	}

	public byte[] getTchrcert1() {
		return tchrcert1;
	}

	public void setTchrcert1(byte[] tchrcert1) {
		this.tchrcert1 = tchrcert1;
	}

	public byte[] getTchrcert2() {
		return tchrcert2;
	}

	public void setTchrcert2(byte[] tchrcert2) {
		this.tchrcert2 = tchrcert2;
	}

	public String getTchrstatus() {
		return tchrstatus;
	}

	public void setTchrstatus(String tchrstatus) {
		this.tchrstatus = tchrstatus;
	}

	public String getRejreason() {
		return rejreason;
	}

	public void setRejreason(String rejreason) {
		this.rejreason = rejreason;
	}

	public String getBankacc() {
		return bankacc;
	}

	public void setBankacc(String bankacc) {
		this.bankacc = bankacc;
	}
}
	
	