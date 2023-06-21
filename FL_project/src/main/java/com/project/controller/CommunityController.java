package com.project.controller;

import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.project.domain.ReviewVO;
import com.project.mapper.CommunityMapper;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.extern.log4j.Log4j;

@Tag(name = "커뮤니티 컨트롤러")
@RequestMapping("/community")
@RestController
public class CommunityController {
	
	@Autowired
	private CommunityMapper cMapper;

	@Operation(summary = "커뮤니티 페이지 이동") // 정의하려는 API 명시
	@ApiResponses(value = { 
			@ApiResponse(responseCode = "200", description = "이름 조회"),
			@ApiResponse(responseCode = "400", description = "존재하지 않는 이름 조회") })

	@GetMapping("")
	public ModelAndView reviewPage() {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("community/reviews");

		return mv;
	}
	
	@PostMapping(value="getReviews", produces="application/json")
	public List<ReviewVO> getReviewList() {
		List<ReviewVO> arr = cMapper.getReviewList();
		//System.out.println(arr);
		
		return arr;
	}
	
	@GetMapping("write")
	public ModelAndView Writeform() {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("community/writeform");
		
		return mv;
	}
	
	@PostMapping(value="write", produces="application/json")
	public ModelAndView writeReview(@RequestParam("nickname") String nickname, @RequestParam("content") String content) {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("redirect:/community");
		
		UUID uuid = UUID.randomUUID();
		cMapper.insertReview(uuid.toString(), nickname, content);
		
		return mv;
	}

}
