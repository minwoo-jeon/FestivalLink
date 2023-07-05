package com.project.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class FestivalPagingVO {
    private String loc;
    private String keyword;
    private int start;
    private int end;
    private String userId;
}
