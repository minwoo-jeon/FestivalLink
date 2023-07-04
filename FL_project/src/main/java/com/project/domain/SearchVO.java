package com.project.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class SearchVO {
    private String FESTIVAL_ID;
    private String FESTIVAL_CONTENTS;
    private String FESTIVAL_NAME;
    private String FESTIVAL_START;
    private String FESTIVAL_END;
    private String FESTIVAL_HOST;
    private String FESTIVAL_PLACE;
    private String FESTIVAL_ADDR;
    private String FESTIVAL_LATITUDE;
    private String FESTIVAL_LONGITUDE;
    private String FESTIVAL_HOMEPAGE;
    private String FESTIVAL_IMAGE;
    private PaginationVO pagination;
	}