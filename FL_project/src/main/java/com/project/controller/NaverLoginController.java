package com.project.controller;

import java.io.IOException;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.project.domain.NaverUserInfoVO;
import com.project.domain.NaverUserVO;
import com.project.oauth.NaverOAuth;
import com.project.service.NaverLoginService;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.enums.ParameterIn;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;

import com.project.mapper.NaverUserMapper;

@Tag(name = "네이버 로그인")
@Log4j2
@RequiredArgsConstructor
@Controller
public class NaverLoginController {
    private final NaverOAuth naverOAuth;
    private final NaverLoginService naverLoginService;

    @Autowired
	private NaverUserMapper naverUserMapper;

    @Operation(summary = "로그인 페이지로 이동") // 정의하려는 API 명시
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "로그인 페이지 접속")
    })
    @GetMapping("/login")
    public String login() {

        return "users/login";
    }

    @Operation(summary = "네이버 로그인 후 콜백") // 정의하려는 API 명시
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "로그인 콜백 페이지 접속")
    })
    @GetMapping("/users/naver")
    public void getNaverOAuthUrl(
            @Parameter(name = "response", description = "헤더 응답", in = ParameterIn.PATH) HttpServletResponse response,
            HttpSession session) throws IOException {
        log.trace("getNaverOAuthUrl() invoked.");

        response.sendRedirect(naverOAuth.responseUrl(session));
    } // getNaverOAuthUrl

    @Operation(summary = "네이버 로그인 후 메인") // 정의하려는 API 명시
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "로그인 완료 후  메인")
    })
    @GetMapping("/users/naver/callback")
    public String naverLogin(String code, HttpSession session, Model model) throws IOException {
        log.trace("naverLogin() invoked.");
        NaverUserInfoVO vo = naverLoginService.naverLogin(code, session);
        //로그인 사용자 정보를 읽어온다
		log.info("{}",vo);
		if(!naverUserMapper.isUserEmail(vo.getResponse().getEmail())) { //일치하는 이메일 없으면 가입
			
			model.addAttribute("email",vo.getResponse().getEmail());
            model.addAttribute("id",vo.getResponse().getId());
			return "users/setNickname";
        }
        NaverUserVO nUser = naverUserMapper.getNaverUserInfo(vo.getResponse().getId());
        session.setAttribute("user", nUser);
        session.setAttribute("userId", nUser.getUser_id());

        return "redirect:/festivals";
    } // naverLogin
}