package org.sixpack.semi.act.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.sixpack.semi.act.model.vo.Act;
import org.sixpack.semi.act.model.vo.Move;
import org.sixpack.semi.diary.model.vo.Diary;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("actDao")
public class ActDao {
		//마이바티스 매퍼 파일에 쿼리문 별도로 작성 해야함
		//root-context.xml 에 생성된 마이바티스 매퍼 연결 객체를 사용함
			
	@Autowired //root-context.xml 에서 생성한 객체와 자동연결
	private SqlSessionTemplate session; //의존성 주입됨(DI)
	
	//하루치 운동목록 조회
	public ArrayList<Act> selectDayAct(Diary diary) {
		List<Act> list = session.selectList("actMapper.selectDayAct", diary);
		return (ArrayList<Act>)list;
	}

	public java.lang.Integer selectSumAct(Diary diary) {
		return session.selectOne("actMapper.selectSumAct",diary);
	}

	public ArrayList<Move> selectSearchMovelist(String move_name) {
		List<Move> list = session.selectList("actMapper.selectSearchMovelist", move_name);
		return (ArrayList<Move>)list;
	}

	public int insertAllAct(List<Act> acts) {
		return session.insert("actMapper.insertAllAct", acts);
	}
		
}
