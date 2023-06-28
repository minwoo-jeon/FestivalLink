
package com.project.controller;


import com.project.domain.UserVo;
import com.project.email.dto.EmailResponseDto;
import com.project.email.entity.EmailMessage;
import com.project.email.service.EmailService;
import com.project.service.UserService;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.Random;
import java.util.UUID;

@Controller
@RequiredArgsConstructor
@Log4j2
public class UserController {



    private final UserService userService;

    private final EmailService emailService;


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


    //이메일 인증

    /* 이메일 인증 */
    //이메일 인증
    /* 이메일 인증 */
    @RequestMapping(value="/mailCheck", method=RequestMethod.GET)
    @ResponseBody
    public void mailCheckGET(String email) throws Exception{

        /* 뷰(View)로부터 넘어온 데이터 확인 */
        log.info("이메일 데이터 전송 확인");
        log.info("인증번호 : " + email);

        /* 인증번호(난수) 생성 */
        Random random = new Random();
        int checkNum = random.nextInt(888888) + 111111;  //111111 ~ 999999 범위의 숫자를 얻기 위해서 nextInt(888888) + 111111를 사용
        log.info("인증번호"+checkNum); //인증번호가 정상적으로 생성되었는지

        String setFrom = "jeonminwoo2000@gmail.com"; //내이메일 쓰는곳
        String toMail = "minwoo867412@naver.com";      //받는사람
        String title = "회원가입 인증 이메일 입니다.";
        String content =                                           //보내는 내용 작성해주기
                "홈페이지를 방문해주셔서 감사합니다." +
                        "<br><br>" +
                        "인증 번호는 " + checkNum + "입니다." +
                        "<br>" +
                        "해당 인증번호를 인증번호 확인란에 기입하여 주세요.";

    }


}

