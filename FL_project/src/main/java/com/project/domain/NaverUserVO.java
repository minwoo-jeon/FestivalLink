package com.project.domain;

import lombok.Data;

@Data
public class NaverUserVO {
    private String email;
    private String user_id;
    private String nickname;
    private int state;
}
