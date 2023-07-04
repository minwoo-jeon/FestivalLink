package com.project.mapper;
import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import com.project.mapper.SearchMapper;
import com.project.domain.PaginationVO;
import com.project.domain.SearchVO;

@Mapper
public interface SearchMapper {
	List<SearchVO> getSearchList(String keyword);
	List<SearchVO> getSearchListPaging(PaginationVO vo);
	int inserSearch(String FESTIVAL_ID,String FESTIVAL_CONTENTS,String FESTIVAL_NAME,String FESTIVAL_START,String FESTIVAL_END,
			String FESTIVAL_HOST,String FESTIVAL_PLACE,String FESTIVAL_ADDR,String FESTIVAL_LATITUDE,
			String FESTIVAL_LONGITUDE,String FESTIVAL_HOMEPAGE,String FESTIVAL_IMAGE);
	int updatSearch(String FESTIVAL_ID,String FESTIVAL_CONTENTS,String FESTIVAL_NAME,String FESTIVAL_START,String FESTIVAL_END,
			String FESTIVAL_HOST,String FESTIVAL_PLACE,String FESTIVAL_ADDR,String FESTIVAL_LATITUDE,
			String FESTIVAL_LONGITUDE,String FESTIVAL_HOMEPAGE,String FESTIVAL_IMAGE);
	int deleteSearch(String FESTIVAL_ID,String FESTIVAL_CONTENTS,String FESTIVAL_NAME,String FESTIVAL_START,String FESTIVAL_END,
			String FESTIVAL_HOST,String FESTIVAL_PLACE,String FESTIVAL_ADDR,String FESTIVAL_LATITUDE,
			String FESTIVAL_LONGITUDE,String FESTIVAL_HOMEPAGE,String FESTIVAL_IMAGE);
	int getTotalCount(PaginationVO v);
	SearchVO getSearch(String FESTIVAL_NAME);
	}
