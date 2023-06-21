package com.project.service;

import javax.servlet.http.HttpSession;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.project.domain.NaverOauthTokenVO;
import com.project.domain.NaverUserInfoVO;
import com.project.oauth.NaverOAuth;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;

@Log4j2
@RequiredArgsConstructor
@Component
public class NaverLoginService {
    private final NaverOAuth naverOAuth;
	
	private NaverUserInfoVO getNaverUserInfoVO(String code, HttpSession session) throws JsonProcessingException {
		log.trace("getNaverUserInfoDTO() invoked.");
		
		ResponseEntity<String> accessTokenResponse = naverOAuth.requestAccessToken(code, session);
		NaverOauthTokenVO oAuthToken = naverOAuth.getAccessToken(accessTokenResponse);
		ResponseEntity<String> userInfoResponse = naverOAuth.requestUserInfo(oAuthToken);
		NaverUserInfoVO naverUser = naverOAuth.getUserInfo(userInfoResponse);
		
		return naverUser;
	} // getNaverUserInfoDTO
	
	public NaverUserInfoVO naverLogin(String code, HttpSession session) throws JsonProcessingException {
		log.trace("naverLogin() invoked.");
		
		NaverUserInfoVO naverUser = getNaverUserInfoVO(code, session);
		log.info("naverUser: {}", naverUser);

		return naverUser;
	} // naverLogin
}
