package com.project.mapper;

import com.project.domain.UserVo;
import org.apache.ibatis.annotations.Mapper;


@Mapper
public interface  UserMapper {
    //회원가입
    int createUser(UserVo user);

    int idCheck(String id);

    int nickCheck(String nick);


    //로그인 처리
    public UserVo userlogin(UserVo user);




}