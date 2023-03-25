package org.sixpack.semi.faq.model.service;

import java.util.ArrayList;

import org.sixpack.semi.faq.model.dao.FaqDao;
import org.sixpack.semi.faq.model.vo.Faq;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("faqService")
public class FaqServiceImpl implements FaqService{
	@Autowired
	private FaqDao faqDao;

	@Override
	public ArrayList<Faq> selectFaqList() {
		return faqDao.selectFaqList();
	}

	@Override
	public int writeFaq(Faq faq) {
		return faqDao.writeFaq(faq);
	}

	@Override
	public int updateFaq(Faq faq) {
		return faqDao.updateFaq(faq);
	}

	@Override
	public int deleteFaq(int faq_no) {
		return faqDao.deleteFaq(faq_no);
	}
}
