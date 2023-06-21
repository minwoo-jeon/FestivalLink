package com.project.demo;

import org.springframework.context.annotation.Bean;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.web.SecurityFilterChain;

//import com.project.service.NaverLoginService;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@EnableWebSecurity
public class SecurityConfig{
	
	//private final NaverLoginService naverLoginService;
	
	@Bean
	public SecurityFilterChain  filterChain(HttpSecurity http) throws Exception {
		  http.csrf().disable();
        http.authorizeRequests(requests -> requests
                .anyRequest().permitAll());
                
		  
		  return http.build();
	}

}