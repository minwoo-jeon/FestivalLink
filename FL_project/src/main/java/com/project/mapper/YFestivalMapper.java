package com.project.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.project.domain.FestivalPagingVO;
import com.project.domain.MyPagingVO;
import com.project.domain.ReviewVO;
import com.project.domain.YFestivalVO;
@Mapper
public interface YFestivalMapper {
    public YFestivalVO getFestivalInfoById(String festival_id);

    //festivalId로 리뷰목록 가져오기
    public List<ReviewVO> getReviewByFid(MyPagingVO mypaging);
    //festival아이디로 리뷰 개수 가져오기 
    public int totalReviewCountByFest(String festivalId);
    //축제 인서트
    public void insertFestival(YFestivalVO fest);

    //축제 리스트 1
    public List<YFestivalVO> getFestivalList(FestivalPagingVO vo);
    public List<YFestivalVO> getFestivalListLatest(FestivalPagingVO vo);
    public int getTotalFestivalCount();
    //축제리스트2
    public List<YFestivalVO> getFestivalListWithKeyword(FestivalPagingVO vo);
    public int getTotalFestivalCountWithKeyword(String keyword);
    public List<YFestivalVO> getFestivalListWithKeywordLatest(FestivalPagingVO vo);
    // //축제리스트3
    public List<YFestivalVO> getFestivalListWithLoc(FestivalPagingVO vo);
    public int getTotalFestivalCountWithLoc(String loc);
    public List<YFestivalVO> getFestivalListWithLocLatest(FestivalPagingVO vo);
    // //축제리스트4
    public List<YFestivalVO> getFestivalListWithKeywordNLoc(FestivalPagingVO vo);
    public int getTotalFestivalCountWithKeywordNLoc(@Param("keyword")String keyword, @Param("loc")String loc);
    public List<YFestivalVO> getFestivalListWithKeywordNLocLatest(FestivalPagingVO vo);

}
