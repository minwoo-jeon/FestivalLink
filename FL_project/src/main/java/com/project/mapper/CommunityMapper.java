package com.project.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.project.domain.NoticeVO;
import com.project.domain.PaginationVO;
import com.project.domain.ReviewVO;
import com.project.domain.YFestivalVO;

@Mapper
public interface CommunityMapper {
	List<ReviewVO> getReviewList();
	List<ReviewVO> getReviewListLatestPaging(PaginationVO vo);
	List<ReviewVO> getReviewListPopularPaging(PaginationVO vo);
	List<String> getAutoComplete(String keyword);
	YFestivalVO getFestivalByName(String festName);
	int insertReview(String uuid, String uid, String festival_id, String nickname, String content, String festival_image);
	ReviewVO getReview(String review_id);
	YFestivalVO getFestivalById(String festival_id_fk);
	int getTotalReviewCount();
	int updateReviewReadnum(String review_id);
	int updateReview(String review_id, String content);
	int deleteLikes(String review_id);
	int deleteReports(String review_id);
	int deleteReview(String review_id);
	int pushLike(String uuid, String uid, String review_id);
	int pushUnlike(String uid, String review_id);
	Object isLiked(String uid, String review_id);
	int reportReview(String uuid, String review_id, String user_id, String content);
	
	
	
	List<NoticeVO> getNoticeList();
	List<NoticeVO> getNoticeListPaging(PaginationVO vo);
	int insertNotice(String uuid, String nickname, String content);
	NoticeVO getNotice(String notice_id);
	int getTotalNoticeCount();
	int updateNoticeReadnum(String notice_id);
	int updateNotice(String notice_id, String content);
	int deleteNotice(String notice_id);
}
