package org.sixpack.semi.member.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.sixpack.semi.common.Paging;
import org.sixpack.semi.member.controller.AdminController;
import org.sixpack.semi.member.model.vo.AllBoardList;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;


@Repository("adminDao")
public class AdminDao {
	
	@Autowired SqlSessionTemplate session;
	
	private static final Logger logger = LoggerFactory.getLogger(AdminController.class);
	
	
	
	public int selectListCount() {
		return session.selectOne("adminMapper.selectListCount");
	}
	

	public ArrayList<AllBoardList> selectAllBoard() {
		List<AllBoardList> list = session.selectList("adminMapper.selectAllBoard");
		 return (ArrayList<AllBoardList>)list;
	}

	
}
