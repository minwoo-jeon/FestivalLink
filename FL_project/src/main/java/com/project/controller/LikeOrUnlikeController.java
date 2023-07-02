package com.project.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.project.domain.F_likesVO;
import com.project.domain.R_likesVO;
import com.project.mapper.LikeOrUnlikeMapper;

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


    @Operation(summary = "리뷰에 좋아요") // 정의하려는 API 명시
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "리뷰에 좋아요 누르면 R_likesVO만들어서 DB에 insert ")
    })
    @PostMapping("/users/like")
    public int likeReview(HttpServletRequest req, @RequestParam(name="reviewId", required = true) String reviewId) {
        HttpSession session = req.getSession();
        // 세션에서 유저아이디 가져오기
        String userId = (String) session.getAttribute("userId");
        String r_likes_id = UUID.randomUUID().toString();
        R_likesVO vo  = new R_likesVO(r_likes_id, userId, reviewId);
        log.info("r_like_id = {}",r_likes_id);
        likeOrUnlikeMapper.likeReview(vo);
        return 1;
    }
    @Operation(summary = "리뷰에 좋아요 취소") // 정의하려는 API 명시
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "리뷰에 좋아요 다시 누르면 reviewId userId같은 좋아요 찾아 삭제")
    })
    @DeleteMapping("/users/like")
    public int unlikeReview(HttpServletRequest req, @RequestParam(name="reviewId", required = true) String reviewId){
        HttpSession session = req.getSession();
        // 세션에서 유저아이디 가져오기
        String userId = (String) session.getAttribute("userId");
        likeOrUnlikeMapper.unlikeReview(userId, reviewId);
        return 1;
    }

    @Operation(summary = "축제에 좋아요 했는지 확인 ") // 정의하려는 API 명시
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "축제상세 로딩 시 로그인 중이면 내가 좋아요 했는지 아닌지 확인 ")
    })
    @GetMapping("/users/like/festival/{festivalId}")
    public int didLikeFestival(HttpServletRequest req, @PathVariable String festivalId){
        HttpSession session = req.getSession();
        // 세션에서 유저아이디 가져오기
        String userId = (String) session.getAttribute("userId");
        int res = likeOrUnlikeMapper.didLikeFestival(userId, festivalId);
        if(res>=1) res = 1;
        
        return res;
    }
    @Operation(summary = "축제에 좋아요") // 정의하려는 API 명시
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "축제에 좋아요 누르면 F_likesVO만들어서 DB에 insert ")
    })
    @PostMapping("/users/like/festival/{festivalId}")
    public int LikeFestival(HttpServletRequest req, @PathVariable String festivalId){
        HttpSession session = req.getSession();
        String userId = (String) session.getAttribute("userId");
        String f_like_id = UUID.randomUUID().toString();
        F_likesVO vo = new F_likesVO(f_like_id, userId, festivalId);
        likeOrUnlikeMapper.likeFestival(vo);
        return 1;
    }

    @Operation(summary = "축제에 좋아요 취소") // 정의하려는 API 명시
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "축제에 좋아요 다시 누르면 festivalId userId같은 좋아요 찾아 삭제")
    })
    @DeleteMapping("/users/like/festival/{festivalId}")
    public int unlikeFestival(HttpServletRequest req, @PathVariable String festivalId){
        HttpSession session = req.getSession();
        // 세션에서 유저아이디 가져오기
        String userId = (String) session.getAttribute("userId");
        likeOrUnlikeMapper.delLikeFestival(userId, festivalId);
        return 1;
    }

    @Operation(summary = "축제페이지에서 리뷰에 좋아요 했는지 확인 ") // 정의하려는 API 명시
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "축제상세 로딩 시 로그인 중이면 내가 좋아요 했는지 아닌지 확인 ")
    })
    @GetMapping("/users/like/review")
    public int didLikeReview(HttpServletRequest req, @RequestParam(name="reviewId", required = true) String reviewId){
        HttpSession session = req.getSession();
        // 세션에서 유저아이디 가져오기
        String userId = (String) session.getAttribute("userId");
        int res = likeOrUnlikeMapper.didLikeReview(userId, reviewId);
        if(res>=1) res = 1;
        
        return res;
    }
    
}   
