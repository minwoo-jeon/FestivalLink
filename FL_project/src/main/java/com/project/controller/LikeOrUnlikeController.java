package com.project.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.project.domain.R_likesVO;
import com.project.mapper.LikeOrUnlikeMapper;
import com.project.mapper.MyPageMapper;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import lombok.extern.slf4j.Slf4j;
import java.util.UUID;
@Slf4j
@RestController
public class LikeOrUnlikeController {
   @Autowired
    private LikeOrUnlikeMapper likeOrUnlikeMapper;


    @Operation(summary = "내가 쓴 리뷰") // 정의하려는 API 명시
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "내가 쓴 리뷰 리스트 찾아서 모델에 반환 ")
    })
    @PostMapping("/users/like")
    public int likeReview(HttpServletRequest req, @RequestParam String reviewId) {
        HttpSession session = req.getSession();
        // 세션에서 유저아이디 가져오기
        String userId = (String) session.getAttribute("userId");
        String r_likes_id = UUID.randomUUID().toString();
        R_likesVO vo  = new R_likesVO(r_likes_id, userId, reviewId);
        log.info("r_like_id = {}",r_likes_id);
        likeOrUnlikeMapper.likeReview(vo);
        return 1;
    }
    @DeleteMapping("/users/like")
    public int unlikeReview(HttpServletRequest req, @RequestParam String reviewId){
        HttpSession session = req.getSession();
        // 세션에서 유저아이디 가져오기
        String userId = (String) session.getAttribute("userId");
        likeOrUnlikeMapper.unlikeReview(userId, reviewId);
        return 1;
    }

}
