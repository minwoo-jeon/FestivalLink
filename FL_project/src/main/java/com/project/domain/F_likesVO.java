package com.project.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class F_likesVO {
    private String f_like_id;
    private String user_id_fk;
    private String festival_id_fk;
    
}
