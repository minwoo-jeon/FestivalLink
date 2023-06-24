package com.project.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class MyFestivalVO {
    private String f_like_id;
	private String user_id_fk;
	private String festival_id_fk;

    private String festival_name;
	private String festival_start;
    private String festival_end;
    private String festival_place;
	private String festival_image;
	private int r_like;
}
