package com.project.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.project.domain.NaverUserVO;
import com.project.mapper.NaverUserMapper;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequiredArgsConstructor
@Controller
public class NaverRegisterController {
    @Autowired
	private NaverUserMapper naverUserMapper;

    @Operation(summary = "네이버 로그인 후 닉네임 정하기") // 정의하려는 API 명시
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "닉네임 정하는 페이지로 이동")
    })
    @GetMapping("/users/setNickname")
    public ModelAndView setNicknamePage() {

        return new ModelAndView("users/setNickname");
    }

    @Operation(summary = "네이버유저 닉네임 중복체크") // 정의하려는 API 명시
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "네이버 유저 닉네임 중복체크 1~10자리")
    })
    @ResponseBody
    @PostMapping(value = "/users/naverNickCheck")
    public int naverNickCheck(String nickname) throws Exception {
        int result = naverUserMapper.naverNickCheck(nickname);
        return result;
    }
    
    @Operation(summary = "네이버유저 회원가입") // 정의하려는 API 명시
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "네이버 유저 닉네임 정한 후 회원가입 다시 로그인 페이지로 이동")
    })
    @PostMapping("/users/naverSignup")
    public String naverSignup(NaverUserVO nUserVO){
        log.info("nUserVO = {}",nUserVO);
        naverUserMapper.naverSignup(nUserVO);

        return "redirect:/login";
    }
}
