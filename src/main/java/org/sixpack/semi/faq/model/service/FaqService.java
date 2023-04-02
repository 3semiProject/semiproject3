package org.sixpack.semi.faq.model.service;

import java.util.ArrayList;

import org.sixpack.semi.common.Paging;
import org.sixpack.semi.faq.model.vo.Faq;

public interface FaqService {
	int selectListCount();
	ArrayList<Faq> selectList(Paging page);
	int writeFaq(Faq faq);
	int updateFaq(Faq faq);
	int deleteFaq(int faq_no);
}
