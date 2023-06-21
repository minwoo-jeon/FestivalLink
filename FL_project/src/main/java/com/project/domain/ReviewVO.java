package com.project.domain;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ReviewVO {
	private int reviewId;
	private int userId;
	private int festivalId;
	
	//private String image;
	private String title;
	private String festival;
	private String nickname;
	private String content;
	private Date wdate;
	private int readnum;
	private int likes;
}
