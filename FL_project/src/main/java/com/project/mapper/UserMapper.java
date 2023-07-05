package com.project.mapper;

import com.project.domain.UserVo;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.transaction.annotation.Transactional;


public interface  UserMapper {
    //회원가입
    int createUser(UserVo user);

    //이메일체크
    int emailCheck(String email);
    //닉네임체크
    int nickCheck(String nickname);

    //로그인 처리
    public UserVo userlogin(UserVo user);

    /// 비밀번호 변경
    public  void modify(UserVo user);

    /// 회원삭제
    public void userDelete(UserVo user);

    //비밀번호 업데이트
    public void update_password(@Param("email")String email,@Param("password")String password);

}