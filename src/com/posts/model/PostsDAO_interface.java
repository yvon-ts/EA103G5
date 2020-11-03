package com.posts.model;

import java.util.List;
//uuuuuuuuu
public interface PostsDAO_interface {
	public PostsVO insert(PostsVO postsVO,boolean childrenOrFather); //新增父子文章
	public void updateStatusRemove(PostsVO postsVO);
	public void updateStatusAdd(String postno);
	public void update(PostsVO postsVO);
	public PostsVO findByPrimaryKey(String postno);
	public List<PostsVO> getAll(String  childrenOrFather); //查詢父子文章
	public PostsVO findByMemno(String memno);
	 
	
}
