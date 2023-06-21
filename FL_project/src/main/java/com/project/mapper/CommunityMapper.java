package com.project.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.mybatis.spring.annotation.MapperScan;

import com.project.domain.ReviewVO;

@Mapper
public interface CommunityMapper {
	List<ReviewVO> getReviewList();
}
