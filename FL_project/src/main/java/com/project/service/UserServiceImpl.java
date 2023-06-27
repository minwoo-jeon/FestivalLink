package com.project.service;

import com.project.domain.UserVo;
import com.project.mapper.UserMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

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
    public int idCheck(String id) {
        int cnt = userMapper.idCheck(id);
        System.out.println("cnt: " + cnt);
        return cnt;
    }

    @Override
    public int nickCheck(String nick) {
        int cnt = userMapper.nickCheck(nick);
        System.out.println("cnt: " + cnt);
        return cnt;
    }

    @Override
    public UserVo userlogin(UserVo user) throws Exception{
        return  userMapper.userlogin(user);
    }

}











