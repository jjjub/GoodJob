package com.good.company.model;


import java.util.ArrayList;

import lombok.Data;


@Data
public class ReviewDTO {
	
	 private String cp_seq;
	 private String id;
	 private String cp_rv_seq;
	
	 //private String tag_seq;
	 //private String tag_keyword;

	 private double salary_score;
	 private double welfare_score;
	 private double stability_score;
	 private double culture_score;
	 private double growth_score;
	 private double avg_score; // 리뷰당 기업 평균 별점
	 private String linereview;
	 private String good;
	 private String bad;
	 private String cp_rv_regdate;
	 private int cp_rv_confirm;

	 private String nickname;
	 
	 private String tag_keyword;
	 private ArrayList<String> tag_list;
	

}
