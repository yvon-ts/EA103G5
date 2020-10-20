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
	public PostsVO addPosts(String superpostsno, String courseno, String memno, String postcontent) {

		PostsVO postsVO = new PostsVO();
		
		postsVO.setSuperpostno(superpostsno);
		postsVO.setCourseno(courseno);
		postsVO.setMemno(memno);
		postsVO.setPostcontent(postcontent);
        dao.insert(postsVO);
		return postsVO;

	}

	

	// update
	public PostsVO updatePosts(String postno, String postcontent, String superpostno, String memno, String courseno, Timestamp posttime) {

		PostsVO postsVO = new PostsVO();
		
		postsVO.setPostno(postno);
		postsVO.setPostcontent(postcontent);
		postsVO.setSuperpostno(superpostno);
		postsVO.setMemno(memno);
		postsVO.setCourseno(courseno);
		postsVO.setPosttime(posttime);

		dao.update(postsVO);
		


		return postsVO;

	}
	
	//updateStatusRemove
	public void updateStatusRemove(String postno) {
		
		dao.updateStatusRemove(postno);
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
	public List<PostsVO> getAll() {
		
		List<PostsVO> list = dao.getAll();
		
		return dao.getAll();
	}
	
	//getByMemNo
	public PostsVO findByMemno(String memno) {
		return dao.findByMemno(memno);
	}
	
	
	

}
