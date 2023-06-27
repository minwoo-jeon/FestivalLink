package com.project.mapper;


import org.apache.ibatis.annotations.Param;

import com.project.domain.R_likesVO;

public interface LikeOrUnlikeMapper {
    public void likeReview(R_likesVO vo);
    public void unlikeReview(@Param("userId") String userId, @Param("reviewId") String reviewId);
}
