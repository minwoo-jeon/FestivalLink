package com.project.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.project.domain.MyPagingVO;
import com.project.domain.YFestivalVO;
import com.project.domain.YReviewVO;
@Mapper
public interface YFestivalMapper {
    public YFestivalVO getFestivalInfoById(String festival_id);

    //festivalId로 리뷰목록 가져오기
    public List<YReviewVO> getReviewByFid(MyPagingVO mypaging);
    //festival아이디로 리뷰 개수 가져오기 
    public int totalReviewCountByFest(String festivalId);
    //축제 인서트
    public void insertFestival(YFestivalVO fest);

}
