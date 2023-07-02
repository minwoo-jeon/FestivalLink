package com.project.service;

import com.project.domain.UserVo;

public interface UserService {


    public int createUser(UserVo user);

    //아이디 중복체크
    public int emailCheck(String email);

    //닉네임 중복체크
    public int nickCheck(String nickname);


    //로그인 처리
    public UserVo userlogin( UserVo user) throws Exception;

    //회원정보 수정
    public void modify(UserVo user) throws Exception;


    //회원정보 삭제
    public void userDelete(UserVo user) throws Exception;
}