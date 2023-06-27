package com.project.service;

import com.project.domain.UserVo;

public interface UserService {


    public int createUser(UserVo user);

    //아이디 중복체크
    public int idCheck(String id);

    //닉네임 중복체크
    public int nickCheck(String nick);


    //로그인 처리
    public UserVo userlogin( UserVo user) throws Exception;

}