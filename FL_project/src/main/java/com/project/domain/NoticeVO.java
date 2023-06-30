package com.project.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class NoticeVO {
	private String notice_id;
	//private String userId;
	
	//private String image;
	//private String title;
	private String notice_nickname;
	private String notice_content;
	private String notice_date1;
	private int notice_readnum = 0;
	
	private PaginationVO pagination;
}
