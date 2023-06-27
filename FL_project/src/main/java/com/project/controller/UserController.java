
package com.project.controller;


import com.project.domain.UserVo;
import com.project.service.UserService;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Random;
import java.util.UUID;

@Controller
@RequiredArgsConstructor
@Log4j2
public class UserController {

    private final UserService userService;


    @RequestMapping(value="/users/signup",method=RequestMethod.GET)
    public String usersForm() {

        return "/users/signup";
    }


    @RequestMapping(value="/users/signup",method=RequestMethod.POST)
    public String signupProcess(Model m, @ModelAttribute UserVo user) {

        if (user.getEmail() == null || user.getPassword() == null || user.getNickname() == null ||
                user.getEmail().trim().isEmpty() ||
                user.getPassword().trim().isEmpty() ||
                user.getNickname().trim().isEmpty()) {
            return "redirect:/users/signup";
        }
        String uid=UUID.randomUUID().toString();
        user.setUser_id(uid);
        System.out.println(user);
        int n=userService.createUser(user);
        String str=(n>0)?"회원가입 완료-로그인 하세요":"가입 실패";
        String loc=(n>0)?"login":"javascript:history.back()";

        m.addAttribute("msg",str);
        m.addAttribute("loc",loc);
        return "message";
    }//------------------------------

    //이메일 중복체크
    @PostMapping("/idCheck")
    @ResponseBody
    public int idCheck(@RequestParam("id") String id) {

        int cnt = userService.idCheck(id);
        return cnt;

    }

    //닉네임 중복체크
    @PostMapping("/nickCheck")
    @ResponseBody
    public int nickCheck(@RequestParam("nick") String nick) {

        int cnt = userService.nickCheck(nick);
        return cnt;

    }


    @GetMapping("/mailCheck")
    @ResponseBody
    public void mailChekGet(String email) throws Exception{

        //뷰로 부터 넘어온 데이터 확인
        log.info("이메일 데이터 전송확인");
        log.info("인증번호:"+email);

    }




}
