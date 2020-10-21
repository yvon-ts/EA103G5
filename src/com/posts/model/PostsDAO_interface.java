package com.posts.model;

import java.util.List;
//uuuuuuuuu
public interface PostsDAO_interface {
	public PostsVO insert(PostsVO postsVO);
	public void updateStatusRemove(String postno);
	public void updateStatusAdd(String postno);
	public void update(PostsVO postsVO);
	public PostsVO findByPrimaryKey(String postno);
	public List<PostsVO> getAll();
	public PostsVO findByMemno(String memno);
	 

}
