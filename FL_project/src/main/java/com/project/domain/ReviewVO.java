package com.project.domain;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ReviewVO {
	//private int reviewId;
	//private int userId;
	//private int festivalId;
	
	//private String image;
	//private String title;
	//private String festival;
	private String review_nickname;
	private String review_content;
	private String review_date;
	private int review_readnum;
	//private int likes;
}
