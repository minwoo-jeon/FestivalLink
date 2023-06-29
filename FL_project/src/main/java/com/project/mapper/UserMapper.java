package com.project.mapper;

import com.project.domain.UserVo;
import org.apache.ibatis.annotations.Mapper;



public interface  UserMapper {
    //회원가입
    int createUser(UserVo user);

    int emailCheck(String email);

    int nickCheck(String nickname);


    //로그인 처리
    public UserVo userlogin(UserVo user);




}