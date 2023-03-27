package org.sixpack.semi.stats.model.vo;

import java.sql.Date;
import java.util.ArrayList;

public class Graph implements java.io.Serializable{
	private static final long serialVersionUID = -2203507430488664273L;
	private String xLabel;	//x축 label 
	private int value1;	//1번 꺽은선의 값
	private int value2;	//2번 꺽은선의 값
	private int value3;	//3번 꺽은선의 값
	
	// ArrayList<Graph>로 사용
	//그래프에 담을 수치[x축 항목(기간)에 대한, y축 수치1, y축 수치2, y축 수치3]
	public Graph(String beginDay, int value1, int value2, int value3) {
		super();
		xLabel = beginDay;
		this.value1 = value1;
		this.value2 = value2;
		this.value3 = value3;
	}
	@Override
	public String toString() {
		return "Graph [xLabel=" + xLabel + ", value1=" + value1 + ", value2=" + value2 + ", value3=" + value3 + "]";
	}
	protected Graph() {
		super();
	}

	public String getxLabel() {
		return xLabel;
	}
	public void setxLabel(String xLabel) {
		this.xLabel = xLabel;
	}
	public int getValue1() {
		return value1;
	}
	public void setValue1(int value1) {
		this.value1 = value1;
	}
	public int getValue2() {
		return value2;
	}
	public void setValue2(int value2) {
		this.value2 = value2;
	}
	public int getValue3() {
		return value3;
	}
	public void setValue3(int value3) {
		this.value3 = value3;
	}
	

	
}


