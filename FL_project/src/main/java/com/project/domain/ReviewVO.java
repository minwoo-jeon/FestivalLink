package com.project.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ReviewVO {
	private String review_id;
	//private String userId;
	//private String festivalId;
	
	//private String image;
	//private String title;
	//private String festival;
	private String review_nickname;
	private String review_content;
	private String review_date1;
	private int review_readnum = 0;
	private int likes = 0;
	private int likeState = 0;
	
	private PaginationVO pagination;
}
