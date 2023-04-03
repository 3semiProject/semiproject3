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

	public int insertFaq(Faq faq) {
		return session.insert("faqMapper.insertFaq", faq);
	}

	public int updateFaq(Faq faq) {
		return session.update("faqMapper.updateFaq", faq);
	}

	public int deleteFaq(int faq_no) {
		return session.delete("faqMapper.deleteFaq", faq_no);
	}

	public int selectListCount() {
		return session.selectOne("faqMapper.selectListCount");
	}

	public Faq selectFaq(int faq_no) {
		return session.selectOne("faqMapper.selectFaq", faq_no);
	}
}
