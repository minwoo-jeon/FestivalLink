package com.project.service;

import com.project.domain.UserVo;
import com.project.mapper.UserMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor

public class UserServiceImpl implements UserService {


    private final UserMapper userMapper;

    @Override
    public int createUser(UserVo user) {
        //System.out.println(">>>"+userMapper);
        //비밀번호 암호화 처리----------


         return userMapper.createUser(user);
    }



    //아이디 중복체크 mapper 접근
    @Override
    public int emailCheck(String email) {
        int cnt = userMapper.emailCheck(email);
        System.out.println("cnt: " + cnt);
        return cnt;
    }

    @Override
    public int nickCheck(String nickname) {
        int cnt = userMapper.nickCheck(nickname);
        System.out.println("cnt: " + cnt);
        return cnt;
    }

    @Override
    public UserVo userlogin(UserVo user) throws Exception{

        return  userMapper.userlogin(user);
    }
    //회원정보수정
    @Override
    public void modify(UserVo user) throws Exception{
        userMapper.modify(user);
    }

    @Override
    public void userDelete(UserVo user)throws Exception{
         userMapper.userDelete(user);
    }




}











