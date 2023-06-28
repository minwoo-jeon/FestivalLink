package com.project.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.project.domain.PaginationVO;
import com.project.domain.ReviewVO;
import com.project.mapper.CommunityMapper;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.tags.Tag;

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
	public ModelAndView reviewPage(@RequestParam(value="pageId", defaultValue="1") String pageId) {
		ModelAndView mv = new ModelAndView();
		mv.addObject("pageId", pageId);
		mv.setViewName("community/reviews");

		return mv;
	}
	
	@PostMapping(value="getReviews", produces="application/json")
	public String getReviewList(HttpServletRequest req, @RequestParam("pageId") String pageId, @ModelAttribute PaginationVO pagination) {	
		HttpSession session = req.getSession();
		
		int cpage = Integer.parseInt(pageId);
		pagination.setPageId(cpage);
		int totalCount = cMapper.getTotalCount();
		pagination.setTotalCount(totalCount);
		pagination.init(session);
		int start = (cpage - 1) * pagination.getPageSize();
		int end = cpage * pagination.getPageSize() + 1;
		pagination.setStart(start);
		pagination.setEnd(end);
		
		List<ReviewVO> arr = cMapper.getReviewListPaging(pagination);
		
		String myctx = req.getContextPath();
		String loc = "/community";
		String pageNavi = pagination.getPageNavi(myctx, loc);
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("items", arr);
		jsonObj.put("totalCount", pagination.getTotalCount());		
		jsonObj.put("pageId", pageId);		
		jsonObj.put("pageCount", pagination.getPageCount());		
		jsonObj.put("pageNavi", pageNavi);
		
		return jsonObj.toString();
	}
	
	@GetMapping("write")
	public ModelAndView writeform() {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("community/writeform");
		
		return mv;
	}
	
	@PostMapping(value="write")
	public ModelAndView writeReview(@RequestParam("nickname") String nickname, @RequestParam("content") String content) {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("redirect:/community");
		
		UUID uuid = UUID.randomUUID();
		cMapper.insertReview(uuid.toString(), nickname, content);
		
		return mv;
	}
	
	@GetMapping(value="{review_id}")
	public ModelAndView viewReview(@PathVariable("review_id") String review_id) {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("community/viewReview");
		cMapper.updateReadnum(review_id);
		ReviewVO vo  = cMapper.getReview(review_id);
		mv.addObject("review", vo);

		return mv;
	}
	
	@GetMapping(value="{review_id}/edit")
	public ModelAndView editform(@PathVariable("review_id") String review_id) {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("community/editform");
		ReviewVO vo = cMapper.getReview(review_id);
		mv.addObject("review", vo);
		
		return mv;
	}
	
	@PostMapping(value="{review_id}/edit")
	public ModelAndView editReview(@PathVariable("review_id") String review_id, @RequestParam("content") String content) {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("redirect:/community");
		
		cMapper.updateReview(review_id, content);
		
		return mv;
	}
	
	@DeleteMapping(value="{review_id}/del", produces="application/json")
	public Map<String, String> delReview(@PathVariable("review_id") String review_id) {
		Map<String, String> map = new HashMap<>();
		
		int n = cMapper.deleteReview(review_id);
		String result = (n > 0)? "OK":"fail";
		map.put("result", result);
		
		return map;
	}

}
