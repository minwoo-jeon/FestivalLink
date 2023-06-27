package com.project.domain;

import org.springframework.stereotype.Component;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Component
@Data
@AllArgsConstructor
@NoArgsConstructor
public class R_likesVO {
    private String r_likes_id;
    private String user_id_fk;
    private String review_id_fk;
}
