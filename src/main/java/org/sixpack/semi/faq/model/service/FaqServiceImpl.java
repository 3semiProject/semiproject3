package org.sixpack.semi.faq.model.service;

import java.util.ArrayList;

import org.sixpack.semi.common.Paging;
import org.sixpack.semi.faq.model.dao.FaqDao;
import org.sixpack.semi.faq.model.vo.Faq;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("faqService")
public class FaqServiceImpl implements FaqService{
	@Autowired
	private FaqDao faqDao;

	@Override
	public ArrayList<Faq> selectList(Paging page) {
		return faqDao.selectList(page);
	}

	@Override
	public int insertFaq(Faq faq) {
		return faqDao.insertFaq(faq);
	}

	@Override
	public int updateFaq(Faq faq) {
		return faqDao.updateFaq(faq);
	}

	@Override
	public int deleteFaq(int faq_no) {
		return faqDao.deleteFaq(faq_no);
	}

	@Override
	public int selectListCount() {
		return faqDao.selectListCount();
	}

	@Override
	public Faq selectFaq(int faq_no) {
		return faqDao.selectFaq(faq_no);
	}
}
