
package com.project.controller;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.project.domain.PaginationVO;
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
    @RequestMapping("/search")
    public ModelAndView festivalssearch(@ModelAttribute PaginationVO pvo,HttpServletRequest req) {
    	HttpSession ses=req.getSession();
    	int cnt=Fservice.getTotalCount(pvo);
    	
    	pvo.setTotalCount(cnt);
    	pvo.setPageSize(12);
    	pvo.setPagingBlock(10);
    	pvo.init(ses);
    	System.out.println(pvo);
    	
    	String myctx=req.getContextPath();
    	
    	String pageStr=pvo.getPageNavi(myctx,"search");
    	
    	List<SearchVO> SearchList = Fservice.getSearchListPaging(pvo); 
    	System.out.println(SearchList.size()+"<<<<");
    	ModelAndView mv=new ModelAndView("festivals/search");
    	mv.addObject("searchList", SearchList);
    	mv.addObject("totalcount",cnt);
    	mv.addObject("pageStr", pageStr);
        return mv;
    }   
}
