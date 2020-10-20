package com.test_type.model;

import java.util.List;

public interface TestTypeDAO_interface {
	void update(TestTypeVO testTypeVO);//新增題型
	void insert(TestTypeVO testTypeVO);//更新題型
	TestTypeVO findByPrimaryKey(int testtypeno);//查找某一題型
	List<TestTypeVO> findAll();//尋找所有題型
	
}
