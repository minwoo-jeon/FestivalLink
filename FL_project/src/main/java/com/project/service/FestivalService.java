package com.project.service;

import java.util.List;

import com.project.domain.PaginationVO;
import com.project.domain.SearchVO;

public interface FestivalService {
	public List<SearchVO> getSearchList(String keyword);
    public List<SearchVO> getSearchListPaging(PaginationVO vo) ;
   

    public int getTotalCount(PaginationVO v) ;

    public SearchVO getSearch(String FESTIVAL_NAME) ;
}
