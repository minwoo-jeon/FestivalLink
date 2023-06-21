package com.project.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.domain.NaverUserVO;
import com.project.mapper.NaverUserMapper;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequiredArgsConstructor
@Controller
public class NaverRegisterController {
    @Autowired
	private NaverUserMapper naverUserMapper;

    @ResponseBody
    @PostMapping(value = "/users/naverNickCheck")
    public int naverNickCheck(String nickname) throws Exception {
        int result = naverUserMapper.naverNickCheck(nickname);
        return result;
    }
    @PostMapping("/users/naverSignup")
    public String naverSignup(NaverUserVO nUserVO){
        log.info("nUserVO = {}",nUserVO);
        naverUserMapper.naverSignup(nUserVO);

        return "redirect:/login";
    }
}
