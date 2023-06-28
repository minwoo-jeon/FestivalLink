package com.project.controller;


import com.project.domain.UserVo;
import com.project.service.UserService;

import lombok.extern.log4j.Log4j2;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;


@Controller
@Log4j2

public class LoginController {

    @Autowired
    private UserService service;

    //로그인폼
    @GetMapping("/users/login")
    public String loginForm() throws Exception{
        log.info("login 폼으로 이동");
        return "users/login";
    }


    //로그인 처리
    @PostMapping("/users/login")
    public String loginPOST(HttpServletRequest request,  UserVo user, RedirectAttributes rttr) throws Exception{

        System.out.println("login 메서드 진입");
        System.out.println("전달된 데이터 : " + user);

        HttpSession session = request.getSession();
        UserVo lvo = service.userlogin(user);


        if(lvo == null) {                                // 일치하지 않는 아이디, 비밀번호 입력 경우

            int result = 0;
            rttr.addFlashAttribute("result", result);
            return "redirect:/users/login";

        }

        session.setAttribute("user", lvo);             // 일치하는 아이디, 비밀번호 경우 (로그인 성공)
        session.setAttribute("userId", lvo.getUser_id());
        return "redirect:/test";

    }
    @GetMapping("/logout")
    public String logout(HttpServletRequest request)throws  Exception{
        HttpSession session = request.getSession();

        session.invalidate(); //세션제거

        return "redirect:/test";
    }

}