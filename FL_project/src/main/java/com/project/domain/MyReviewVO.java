package com.project.domain;

import org.springframework.stereotype.Component;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Component
@Data
@AllArgsConstructor
@NoArgsConstructor
public class MyReviewVO {
    private String review_id;
	private String user_id_fk;
	private String festival_id_fk;
	private String review_image;
	private String review_nickname;
	private String review_content;
	private String review_date;
	private int review_readnum;
	private String festival_name;
	private int r_like;
	private String likeState;
}
