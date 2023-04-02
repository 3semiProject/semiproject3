package org.sixpack.semi.faq.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.sixpack.semi.common.Paging;
import org.sixpack.semi.faq.model.vo.Faq;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("faqDao")
public class FaqDao {
	@Autowired
	private SqlSessionTemplate session;

	public ArrayList<Faq> selectList(Paging page) {
		List<Faq> list = session.selectList("faqMapper.selectList", page);
		return (ArrayList<Faq>)list;
	}

	public int writeFaq(Faq faq) {
		// TODO Auto-generated method stub
		return 0;
	}

	public int updateFaq(Faq faq) {
		// TODO Auto-generated method stub
		return 0;
	}

	public int deleteFaq(int faq_no) {
		// TODO Auto-generated method stub
		return 0;
	}

	public int selectListCount() {
		return session.selectOne("faqMapper.selectListCount");
	}
}
