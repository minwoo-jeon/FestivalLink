
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
    //생성자 주입
    private final UserService userService;
    private final EmailService emailService;

    //회원가입 사이트 요청 get
    @RequestMapping(value="/users/signup",method=RequestMethod.GET)
    public String usersForm() {

        return "/users/signup";
    }

    //폼에서 받은 데이터 받기 post
    @RequestMapping(value="/users/signup",method=RequestMethod.POST)
    public String signupProcess(Model m,@ModelAttribute UserVo user) {
            log.info("user=="+user); 
            user.setUser_id(UUID.randomUUID().toString());  //user_id 값이 계속 부적합한열 유형 null값이떠서 userid값생성
        if(user.getEmail()==null||user.getPassword()==null||user.getEmail().trim().isEmpty()|| user.getPassword().trim().isEmpty()) {
            return "redirect:/users/signup";
        }
           int n=userService.createUser(user);
        String str=(n>0)?"회원가입 완료-로그인 하세요":"가입 실패";
        String loc=(n>0)?"login":"javascript:history.back()";
        m.addAttribute("msg",str);
        m.addAttribute("loc",loc);
        return "users/message";
    }//------------------------------

    //이메일 중복체크
    @PostMapping("/emailCheck")
    @ResponseBody
    public int emailCheck(@RequestParam("email") String email) {

        int cnt = userService.emailCheck(email);       
        return cnt;

    }

    //닉네임 중복체크
    @PostMapping("/nicknameCheck")
    @ResponseBody
    public int nickCheck(@RequestParam("nickname") String nickname) {

        int cnt = userService.nickCheck(nickname);
        return cnt;

    }



    //이메일 인증
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
        String toMail = "jeonminsoo2013@@mail.com";      //받는사람
        String title = "회원가입 인증 이메일 입니다.";
        String content =                                           //보내는 내용 작성해주기
                "홈페이지를 방문해주셔서 감사합니다." +
                        "<br><br>" +
                        "인증 번호는 " + checkNum + "입니다." +
                        "<br>" +
                        "해당 인증번호를 인증번호 확인란에 기입하여 주세요.";
        EmailMessage emailMessage = EmailMessage.builder()
                .to(email)
                .subject("[SAVIEW] 이메일 인증을 위한 인증 코드 발송")
                .build();

        String code = emailService.sendMail(emailMessage, "email");

        EmailResponseDto emailResponseDto = new EmailResponseDto();
        emailResponseDto.setCode(code);

    }



}

