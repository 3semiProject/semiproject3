package org.sixpack.semi.body.model.service;

import org.sixpack.semi.body.model.vo.Body;
import org.sixpack.semi.diary.model.vo.Diary;

public interface BodyService {

	Body selectOneBody(Diary diary); //id, 날짜 넣어서 체형다이어리 1개 조회

	Body selectCompareBody(Diary diary); //증감률 비교용 다이어리값.
	
	int insertBody(Body body);
}
