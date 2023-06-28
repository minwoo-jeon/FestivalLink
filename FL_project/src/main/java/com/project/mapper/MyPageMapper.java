package com.project.mapper;

import java.util.List;

import com.project.domain.MyFestivalVO;
import com.project.domain.MyPagingVO;
import com.project.domain.MyReviewVO;
import com.project.domain.R_reportVO;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface MyPageMapper {
    //내가 쓴  리뷰 
    public int getTotalMyReviewCount(String userId);
    public List<MyReviewVO>listMyReview(MyPagingVO mypaging);

    //내가 좋아요 한  리뷰 
    public int getTotalLikedReviewCount(String userId);
    public List<MyReviewVO>listLikedReview(MyPagingVO mypaging);

    //리뷰 신고 
    public int getTotalReviewReportCount();
    public List<R_reportVO>listReviewReport(MyPagingVO mypaging);
    public void delReviewReport(String r_report_id);

    //내가 좋아요한 축제 
    public int getTotalFestivalCount(String userId);
    public List<MyFestivalVO>listMyFestival(MyPagingVO myPagingVO);
    
   
    
}
