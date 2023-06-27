package com.project.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.project.domain.PaginationVO;
import com.project.domain.ReviewVO;

@Mapper
public interface CommunityMapper {
	List<ReviewVO> getReviewList();
	List<ReviewVO> getReviewListPaging(PaginationVO vo);
	int insertReview(String uuid, String nickname, String content);
	ReviewVO getReview(String review_id);
	int getTotalCount();
	int deleteReview(String review_id);
}
