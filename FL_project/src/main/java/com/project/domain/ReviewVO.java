package com.project.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ReviewVO {
	private String review_id;
	private String user_id_fk;
	private String festival_id_fk;
	
	private String title;
	private String festival_name;
	private String review_nickname;
	private String review_content;
	private String review_date1;
	private String review_image;
	private int review_readnum = 0;
	private int likes = 0;
	private int likeState = 0;
	
	private PaginationVO pagination;
}
