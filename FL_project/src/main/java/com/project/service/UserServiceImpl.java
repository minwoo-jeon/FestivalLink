package com.project.service;

import com.project.domain.UserVo;
import com.project.mapper.UserMapper;
import lombok.RequiredArgsConstructor;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;

@Service
@RequiredArgsConstructor

public class UserServiceImpl implements UserService {
    
    private final BCryptPasswordEncoder bCryptPasswordEncoder;


    private final UserMapper userMapper;

    @Override
    public int createUser(UserVo user) {
        //System.out.println(">>>"+userMapper);
        //비밀번호 암호화 처리----------

        user.setPassword(bCryptPasswordEncoder.encode(user.getPassword()));
         return userMapper.createUser(user);
    }



    //아이디 중복체크 mapper 접근
    @Override
    public int emailCheck(String email) {
        int cnt = userMapper.emailCheck(email);
        System.out.println("cnt: " + cnt);
        return cnt;
    }
    //닉네임체크
    @Override
    public int nickCheck(String nickname) {
        int cnt = userMapper.nickCheck(nickname);
        System.out.println("cnt: " + cnt);
        return cnt;
    }

    //로그인
    @Override
    public UserVo userlogin(UserVo user) throws Exception{

        return  userMapper.userlogin(user);
    }


    //회원정보 삭제
    @Override
    public void userDelete(UserVo user) throws Exception{
        userMapper.userDelete(user);
    }

    @Override
    //회원정보 수정
    public void modify(UserVo user) throws Exception{
        userMapper.modify(user);
    }

    // 비밀번호 찾기

}











