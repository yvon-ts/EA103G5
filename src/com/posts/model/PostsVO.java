package com.posts.model;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.List;

public class PostsVO implements Serializable{
	
	private static final long serialVersionUID = 1L;
	private String postno;
	private String superpostno; //父文章編號
	private String courseno;
	private String memno;
	private String postcontent;
	private Timestamp posttime;
	private Integer ishidden; //??? 是否隱藏
	private List<PostsVO> list;
	
	
	public PostsVO() {
		super();
	}
	public String getPostno() {
		return postno;
	}
	public void setPostno(String postno) {
		this.postno = postno;
	}
	public String getSuperpostno() {
		return superpostno;
	}
	public void setSuperpostno(String superpostno) {
		this.superpostno = superpostno;
	}
	public String getCourseno() {
		return courseno;
	}
	public void setCourseno(String courseno) {
		this.courseno = courseno;
	}
	public String getMemno() {
		return memno;
	}
	public void setMemno(String memno) {
		this.memno = memno;
	}
	public String getPostcontent() {
		return postcontent;
	}
	public void setPostcontent(String postcontent) {
		this.postcontent = postcontent;
	}
	public Timestamp getPosttime() {
		return posttime;
	}
	public void setPosttime(Timestamp posttime) {
		this.posttime = posttime;
	}
	public Integer getIshidden() {
		return ishidden;
	}
	public void setIshidden(Integer ishidden) {
		this.ishidden = ishidden;
	}
	public List<PostsVO> getList() {
		return list;
	}
	public void setIshidden(List<PostsVO> list) {
		this.list = list;
	}
	
	
	
	
	
	
	

}
