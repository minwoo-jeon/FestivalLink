package com.project.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class R_reportVO {
    private String r_report_id;
    private String review_id_fk;
    private String user_id_fk;
    private String r_report_content;
}
