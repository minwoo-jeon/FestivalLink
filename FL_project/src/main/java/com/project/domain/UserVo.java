package com.project.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor //기본생성자
public class UserVo {
    private String user_id; //uuid?
    private String email;
    private String password;
    private String nickname;
    private int state;
    private java.sql.Date indate;

}