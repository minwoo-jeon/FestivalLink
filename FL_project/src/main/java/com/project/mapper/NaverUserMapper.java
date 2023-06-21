package com.project.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.project.domain.NaverUserVO;

@Mapper
public interface NaverUserMapper {
    NaverUserVO getNaverUserIn = null;
    public boolean isUserEmail(String email);

    public int naverNickCheck(String nickname);
    public void naverSignup(NaverUserVO vo);
    public NaverUserVO getNaverUserInfo(String id);
}
