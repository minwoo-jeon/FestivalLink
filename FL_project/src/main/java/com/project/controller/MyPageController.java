package com.project.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.project.domain.MyPagingVO;
import com.project.domain.MyReviewVO;
import com.project.domain.R_reportVO;
import com.project.mapper.MyPageMapper;
import com.project.domain.MyFestivalVO;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController

public class MyPageController {
    @Autowired
    private MyPageMapper myPageMapper;

    @Operation(summary = "내가 쓴 리뷰") // 정의하려는 API 명시
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "내가 쓴 리뷰 리스트 찾아서 모델에 반환 ")
    })
    @GetMapping("/users/myReview")
    public ModelAndView getReviewListByUser(Model model, HttpServletRequest req,
            @RequestParam(defaultValue = "1") int page) {

        HttpSession session = req.getSession();
        // 세션에서 유저아이디 가져오기
        String userId = (String) session.getAttribute("userId");
        log.info("userid={}", userId);
        int totalCount = this.myPageMapper.getTotalMyReviewCount(userId);
        log.info("total ={}", totalCount);
        int pageSize = 5;
        int pageCount = (totalCount - 1) / pageSize + 1;
        if (page < 0) {
            page = 1;
        }
        if (page > pageCount) {
            page = pageCount;
        }
        int end = page * pageSize;
        int start = end - pageSize;
        MyPagingVO myP = new MyPagingVO();
        myP.setEnd(end);
        myP.setStart(start);
        myP.setUserId(userId);
        List<MyReviewVO> myReviewArr = myPageMapper.listMyReview(myP);

        model.addAttribute("totalCount", totalCount);
        model.addAttribute("myReviewArr", myReviewArr);
        model.addAttribute("pageCount", pageCount);
        model.addAttribute("pageSize", pageSize);
        model.addAttribute("page", page);

        return new ModelAndView("users/myReview");
    }

    @Operation(summary = "내가 좋아요한 축제") // 정의하려는 API 명시
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "내가 좋아요한 축제 찾아서 모델에 반환")
    })
    @GetMapping("/users/myFestival")
    public ModelAndView getFestivalListByUser(Model model, HttpServletRequest req,
            @RequestParam(defaultValue = "1") int page) {
        HttpSession session = req.getSession();
        // 세션에서 유저아이디 가져오기
        String userId = (String) session.getAttribute("userId");
        log.info("userid={}", userId);
        int totalCount = this.myPageMapper.getTotalFestivalCount(userId);
        log.info("total={}", totalCount);
        if (totalCount == 0) {
            model.addAttribute("totalCount", totalCount);
            return new ModelAndView("users/myFestival");
        } else {
            // 한페이지에 축제 20개보여주기(4*5)
            int pageSize = 20;
            int pageCount = (totalCount - 1) / pageSize + 1;
            if (page < 0) {
                page = 1;
            }
            if (page > pageCount) {
                page = pageCount;
            }
            int end = page * pageSize;
            int start = end - pageSize;
            MyPagingVO myP = new MyPagingVO();
            myP.setEnd(end);
            myP.setStart(start);
            myP.setUserId(userId);

            List<MyFestivalVO> myFestivalArr = myPageMapper.listMyFestival(myP);

            model.addAttribute("totalCount", totalCount);
            model.addAttribute("myFestivalArr", myFestivalArr);
            model.addAttribute("pageCount", pageCount);
            model.addAttribute("pageSize", pageSize);
            model.addAttribute("page", page);
            return new ModelAndView("users/myFestival");
        }
    }

    @Operation(summary = "내가 좋아요 한 리뷰") // 정의하려는 API 명시
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "내가 좋아요 한 리뷰 리스트 찾아서 모델에 반환 ")
    })
    @GetMapping("/users/likedReview")
    public ModelAndView getlikedReviewListByUser(Model model, HttpServletRequest req,
            @RequestParam(defaultValue = "1") int page) {

        HttpSession session = req.getSession();
        // 세션에서 유저아이디 가져오기
        String userId = (String) session.getAttribute("userId");
        log.info("userid={}", userId);
        int totalCount = this.myPageMapper.getTotalLikedReviewCount(userId);
        log.info("total ={}", totalCount);
        int pageSize = 5;
        int pageCount = (totalCount - 1) / pageSize + 1;
        if (page < 0) {
            page = 1;
        }
        if (page > pageCount) {
            page = pageCount;
        }
        int end = page * pageSize;
        int start = end - pageSize;
        MyPagingVO myP = new MyPagingVO();
        myP.setEnd(end);
        myP.setStart(start);
        myP.setUserId(userId);
        List<MyReviewVO> likedReviewArr = myPageMapper.listLikedReview(myP);
        log.info(myP.toString());
        model.addAttribute("totalCount", totalCount);
        model.addAttribute("likedReviewArr", likedReviewArr);
        model.addAttribute("pageCount", pageCount);
        model.addAttribute("pageSize", pageSize);
        model.addAttribute("page", page);

        return new ModelAndView("users/likedReview");
    }

    @Operation(summary = "리뷰 신고 목록") // 정의하려는 API 명시
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "리뷰 신고 리스트 찾아서 모델에 반환 ")
    })
    @GetMapping("/users/report")
    public ModelAndView getReportList(Model model, HttpServletRequest req,
            @RequestParam(defaultValue = "1") int page) {
        int totalCount = this.myPageMapper.getTotalReviewReportCount();
        log.info("total ={}", totalCount);
        int pageSize = 4;
        int pageCount = (totalCount - 1) / pageSize + 1;
        if (page < 0) {
            page = 1;
        }
        if (page > pageCount) {
            page = pageCount;
        }
        int end = page * pageSize;
        int start = end - pageSize;
        MyPagingVO myP = new MyPagingVO();
        myP.setEnd(end);
        myP.setStart(start);
        List<R_reportVO> reportArr = myPageMapper.listReviewReport(myP);
        log.info(myP.toString());
        model.addAttribute("totalCount", totalCount);
        model.addAttribute("reportArr", reportArr);
        model.addAttribute("pageCount", pageCount);
        model.addAttribute("pageSize", pageSize);
        model.addAttribute("page", page); 
        
        return new ModelAndView("users/report");
    }
    @Operation(summary = "리뷰 신고 삭제") // 정의하려는 API 명시
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "리뷰 신고 처리 후 삭제 ")
    })
    @DeleteMapping("/users/report")
    public int delReviewReport(@RequestParam String r_report_id) {
        myPageMapper.delReviewReport(r_report_id);
        return 1;
    }

}
