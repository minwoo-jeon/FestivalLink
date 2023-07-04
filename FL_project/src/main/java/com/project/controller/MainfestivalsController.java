
package com.project.controller;
import javax.inject.Inject;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.project.domain.SearchVO;
import com.project.service.FestivalServiceImpl;

import io.swagger.v3.oas.annotations.tags.Tag;

@Tag(name = "메인")
@RestController
public class MainfestivalsController {

	@Inject
	FestivalServiceImpl Fservice;
	
    // @Operation(summary = "테스트 페이지") // 정의하려는 API 명시
    // @ApiResponses(value = {
    //         @ApiResponse(responseCode = "200", description = "테스트 페이지"),
    //         @ApiResponse(responseCode = "400", description = "테스트 페이지 실패")
    // })
    
    @GetMapping("/festivalsmain")
    public ModelAndView festivalsmain() {

        return new ModelAndView("festivals/festivalsmain");
    }
    @GetMapping("/festivalsview")
    public ModelAndView festivalsview() {

        return new ModelAndView("festivals/festivalsview");
    }
    @GetMapping("/Review")
    public ModelAndView festivalsReview() {
    	
        return new ModelAndView("festivals/Review");
    }   
    @PostMapping("/search")
    public ModelAndView festivalssearch(@RequestParam String keyword) {
    	SearchVO vo=Fservice.getSearch(keyword); 
    	ModelAndView mv=new ModelAndView("festivals/search");
    	mv.addObject("vo", vo);
        return mv;
    }   
}
