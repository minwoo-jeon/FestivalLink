package com.project.mapper;

import java.util.List;

import com.project.domain.MyFestivalVO;
import com.project.domain.MyPagingVO;
import com.project.domain.MyReviewVO;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface MyPageMapper {
    public int getTotalReviewCount(String userId);
    public List<MyReviewVO>listMyReview(MyPagingVO mypaging);
    public int getTotalFestivalCount(String userId);
    public List<MyFestivalVO>listMyFestival(MyPagingVO myPagingVO);
    public List<MyReviewVO>listLikedReview(MyPagingVO mypaging);
    
}
