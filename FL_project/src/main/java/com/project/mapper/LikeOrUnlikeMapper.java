package com.project.mapper;


import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.project.domain.F_likesVO;
import com.project.domain.R_likesVO;
@Mapper
public interface LikeOrUnlikeMapper {
    // 리뷰 좋아요
    public void likeReview(R_likesVO vo);
    //리뷰 좋아요 취소
    public void unlikeReview(@Param("userId") String userId, @Param("reviewId") String reviewId);
    //축제 좋아요 확인
    public int didLikeFestival(@Param("userId") String userId, @Param("festivalId") String festivalId);
    //축제 좋아요
    public void likeFestival(F_likesVO vo);
    //축제 좋아요 취소
    public void delLikeFestival(@Param("userId") String userId, @Param("festivalId") String festivalId);
    //리뷰에 좋아요 했는지 안했는지
    public int didLikeReview(String userId, String reviewId);

}
