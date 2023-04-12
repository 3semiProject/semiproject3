package org.sixpack.semi.member.model.service;

import java.util.ArrayList;

import org.sixpack.semi.common.Paging;
import org.sixpack.semi.member.model.dao.AdminDao;
import org.sixpack.semi.member.model.vo.AllBoardList;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("adminService")
public class AdminServiceImpl implements AdminService{
	@Autowired
	private AdminDao adminDao;

	@Override
	public int selectListCount() {
		return adminDao.selectListCount();
		
	}
	@Override
	public ArrayList<AllBoardList> selectAllBoard() {
		return adminDao.selectAllBoard();
	}

}
