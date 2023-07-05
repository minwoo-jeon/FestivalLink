package com.project.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class NoticeVO {
	private String notice_id;
	private String user_id_fk;
	
	private String title;
	private String notice_nickname;
	private String notice_content;
	private String notice_date1;
	private String notice_image;
	private int notice_readnum = 0;
	
	private PaginationVO pagination;
}
