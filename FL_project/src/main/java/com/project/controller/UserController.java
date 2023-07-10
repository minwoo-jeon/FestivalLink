
package com.project.controller;


import com.project.domain.UserVo;
import com.project.email.dto.EmailResponseDto;
import com.project.email.entity.EmailMessage;
import com.project.email.service.EmailService;
import com.project.mapper.UserMapper;
import com.project.service.UserService;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.apache.catalina.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.Random;
import java.util.UUID;

@Controller
@RequiredArgsConstructor
@Log4j2
public class UserController {
    //생성자 주입
    private final UserService userService;
    private final EmailService emailService;
    private final UserMapper userMapper;

    //회원가입 사이트 요청 get
    @RequestMapping(value = "/users/signup", method = RequestMethod.GET)
    public String usersForm() {

        return "/users/signup";
    }

    //폼에서 받은 데이터 받기 post
    @RequestMapping(value = "/users/signup", method = RequestMethod.POST)
    public String signupProcess(Model m, @ModelAttribute UserVo user) {
        //log.info("user==" + user);
        user.setUser_id(UUID.randomUUID().toString());  //user_id 값이 계속 부적합한열 유형 null값이떠서 userid값생성
        if (user.getEmail() == null || user.getPassword() == null || user.getEmail().trim().isEmpty() || user.getPassword().trim().isEmpty()) {
            return "redirect:/users/signup";
        }
        int n = userService.createUser(user);
        String str = (n > 0) ? "회원가입 완료-로그인 하세요" : "가입 실패";
        String loc = (n > 0) ? "login" : "javascript:history.back()";
        m.addAttribute("msg", str);
        m.addAttribute("loc", loc);
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
    @RequestMapping(value = "/mailCheck", method = RequestMethod.GET)
    @ResponseBody
    public String mailCheckGET(String email) throws Exception {

        /* 뷰(View)로부터 넘어온 데이터 확인 */
        //log.info("이메일 데이터 전송 확인");
        //log.info("인증번호 : " + email);

        /* 인증번호(난수) 생성 */
        Random random = new Random();
        int checkNum = random.nextInt(888888) + 111111;  //111111 ~ 999999 범위의 숫자를 얻기 위해서 nextInt(888888) + 111111를 사용
        //log.info("인증번호" + checkNum); //인증번호가 정상적으로 생성되었는지


        EmailMessage emailMessage = EmailMessage.builder()
                .to(email)
                .subject("[SAVIEW]  festival link 이메일 인증을 위한 인증 코드 발송")
                .build();

        String code = emailService.sendMail(emailMessage, "email");
        log.info(code);
        EmailResponseDto emailResponseDto = new EmailResponseDto();
        emailResponseDto.setCode(code);
        return code;
    }


    //비밀번호 찾기jsp 가져오기 get
    @GetMapping("/users/password")
    public String findPwForm() {

        return "/users/findPw";
    }

    //비밀번호 찾기
    @RequestMapping(value = "/users/findpw", method = RequestMethod.POST)
    @ResponseBody
    public void findPw(String email) throws Exception {

        /* 뷰(View)로부터 넘어온 데이터 확인 */
       // log.info("이메일 데이터 전송 확인1");
        //log.info("인증번호 : " + email);

        /* 인증번호(난수) 생성 */
        Random random = new Random();
        int checkNum = random.nextInt(888888) + 111111;  //111111 ~ 999999 범위의 숫자를 얻기 위해서 nextInt(888888) + 111111를 사용
        //log.info("인증번호1" + checkNum); //인증번호가 정상적으로 생성되었는지


        EmailMessage emailMessage = EmailMessage.builder()
                .to(email)
                .subject("[SAVIEW] festival link 임시 비밀번호 발송")
                .build();


        String code = emailService.sendMail(emailMessage, "email");
        userMapper.update_password(email,code);

        EmailResponseDto emailResponseDto = new EmailResponseDto();
        emailResponseDto.setCode(code);
    }

    //마이페이지 뷰페이지 반환
    @GetMapping("/users")
    public String mypageForm() {
        return "/users/myPage";
    }

    //내정보 수정 뷰페이지 반환
    @GetMapping("/users/modify")
    public String modifyForm() {
        return "/users/modify";
    }

    // 회원정보 수정 post
    @RequestMapping(value = "/modify", method = RequestMethod.POST)
    public String postModify(HttpSession session, UserVo user) throws Exception {
        //log.info("post modify:" + user);

        userService.modify(user);


        session.invalidate();

        return "redirect:/festivals";
    }

    //회원 탈퇴 뷰 페이지
    @GetMapping("/users/mypage/delete")
    public String deleteUser() {
        return "/users/delete";
    }


    // 회원 탈퇴 post
    @RequestMapping(value = "/userDelete", method = RequestMethod.POST)
    public String userDelete(UserVo user, HttpSession session, RedirectAttributes rttr) throws Exception {

        //세션에 있는 user를 가져와 user변수에 넣어줌
        UserVo users = (UserVo)session.getAttribute("user");
        log.info("users:"+users);
        //세션에 있는 비밀번호
        String sessionPass = users.getPassword();
        log.info("sessionPass:"+sessionPass);
        //vo로 들어가는 비밀번호
        String voPass = user.getPassword();
        log.info("voPass:"+voPass);
        if(!(sessionPass.equals(voPass))){
            rttr.addFlashAttribute("msg",false);
            return "redirect:/users/mypage/delete";
        }
        userService.userDelete(user);
        session.invalidate();
        rttr.addFlashAttribute("msg","정상적으로 회원탈퇴 되었습니다");
        return "redirect:/festivals";

    }


}


