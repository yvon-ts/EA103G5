package com.posts.model;

import java.sql.Timestamp;
import java.sql.Date;
import java.util.List;

public class PostsService {

	private PostsDAO_interface dao;

	public PostsService() {
		dao = new PostsDAO();
	}

	// insert
	public PostsVO addPosts(PostsVO postsVO,boolean FatherOrChildren) {

        dao.insert(postsVO, FatherOrChildren);
		return postsVO;

	}

	

	// update
	public PostsVO updatePosts(PostsVO postsVO) {

		dao.update(postsVO);
		return postsVO;

	}
	
	//updateStatusRemove
	public void updateStatusRemove(PostsVO postsVO) {
		
		dao.updateStatusRemove(postsVO);
	}
	
	//updateStatudAdd
	public void updateStatusAdd(String postno) {
		
		dao.updateStatusAdd(postno);
	}
	
	
	//getOne
	public PostsVO getOnePost(String postno) {
		return dao.findByPrimaryKey(postno);
	}
	
	//getAll
	public List<PostsVO> getAll(String FatherOrChildren) {
		
		List<PostsVO> list = dao.getAll(FatherOrChildren);
		
		return list;
	}
	//getByMemNo
	public PostsVO findByMemno(String memno) {
		return dao.findByMemno(memno);
	}
	
	
	

}
