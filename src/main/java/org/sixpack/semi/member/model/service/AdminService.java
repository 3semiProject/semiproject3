package org.sixpack.semi.member.model.service;

import java.util.ArrayList;

import org.sixpack.semi.common.Paging;
import org.sixpack.semi.member.model.vo.AllBoardList;

public interface AdminService {

	int selectListCount();

	ArrayList<AllBoardList> selectAllBoard();


}
