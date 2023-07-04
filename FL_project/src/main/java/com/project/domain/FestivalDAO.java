package com.project.domain;

import java.util.ArrayList;
import java.util.List;

public class FestivalDAO {
    public List<SearchVO> getSearchList() {
        List<SearchVO> searchList = new ArrayList<>();
        
        return searchList;
    }

    public List<SearchVO> getSearchListPaging(PaginationVO vo) {
        List<SearchVO> searchList = new ArrayList<>();

        return searchList;
    }

    public int insertSearch(String FESTIVAL_ID, String FESTIVAL_CONTENTS, String FESTIVAL_NAME, String FESTIVAL_START,
            String FESTIVAL_END, String FESTIVAL_HOST, String FESTIVAL_PLACE, String FESTIVAL_ADDR,
            String FESTIVAL_LATITUDE, String FESTIVAL_LONGITUDE, String FESTIVAL_HOMEPAGE, String FESTIVAL_IMAGE) {

        int rowCount = 0;

        return rowCount;
    }

    public int updateSearch(String FESTIVAL_ID, String FESTIVAL_CONTENTS, String FESTIVAL_NAME, String FESTIVAL_START,
            String FESTIVAL_END, String FESTIVAL_HOST, String FESTIVAL_PLACE, String FESTIVAL_ADDR,
            String FESTIVAL_LATITUDE, String FESTIVAL_LONGITUDE, String FESTIVAL_HOMEPAGE, String FESTIVAL_IMAGE) {

        int rowCount = 0;

        return rowCount;
    }

    public int deleteSearch(String FESTIVAL_ID, String FESTIVAL_CONTENTS, String FESTIVAL_NAME, String FESTIVAL_START,
            String FESTIVAL_END, String FESTIVAL_HOST, String FESTIVAL_PLACE, String FESTIVAL_ADDR,
            String FESTIVAL_LATITUDE, String FESTIVAL_LONGITUDE, String FESTIVAL_HOMEPAGE, String FESTIVAL_IMAGE) {

        int rowCount = 0;

        return rowCount;
    }

    public int getTotalCount() {

        int totalCount = 0;

        return totalCount;
    }

    public SearchVO getSearch(String FESTIVAL_ID) {

        SearchVO searchVO = null;

        return searchVO;
    }
}

