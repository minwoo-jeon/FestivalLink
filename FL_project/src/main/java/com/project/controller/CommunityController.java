package com.project.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.project.domain.ReviewVO;
import com.project.mapper.CommunityMapper;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.tags.Tag;

@Tag(name = "커뮤니티 컨트롤러")
@RestController
public class CommunityController {
	
	@Autowired
	private CommunityMapper cMapper;

	@Operation(summary = "커뮤니티 페이지 이동") // 정의하려는 API 명시
	@ApiResponses(value = { 
			@ApiResponse(responseCode = "200", description = "이름 조회"),
			@ApiResponse(responseCode = "400", description = "존재하지 않는 이름 조회") })

	@GetMapping("/community")
	public ModelAndView testPage() {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("community/reviews");

		return mv;
	}
	
	@PostMapping(value="/community/getReviews", produces="applcation/json")
	public List<ReviewVO> getReviewList() {
		
		return cMapper.getReviewList();
	}
	
	@PostMapping(value="/community/write", produces="applcation/json")
	public ModelAndView writeform() {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("community/writeform");
		
		return mv;
	}

}
