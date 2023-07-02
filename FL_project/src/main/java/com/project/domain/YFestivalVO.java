package com.project.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class YFestivalVO {
    private String festival_id;
    private String festival_name;
	private String festival_contents;
	private String festival_start;
    private String festival_end;
    private String festival_host;
    private String festival_place;
    private String festival_addr;
    private double festival_latitude;
    private double festival_longitude;
    private String festival_homepage;
	private String festival_image;
	private int f_like;
}
