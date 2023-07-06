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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.project.domain.NoticeVO;
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
	public ModelAndView reviewPage(@RequestParam(value="sort", defaultValue="latest") String sort, @RequestParam(value="pageId", defaultValue="1") String pageId) {
		ModelAndView mv = new ModelAndView();
		mv.addObject("sort", sort);
		mv.addObject("pageId", pageId);
		mv.setViewName("community/review/reviews");

		return mv;
	}
	
	@PostMapping(value="getReviews", produces="application/json")
	public String getReviewList(HttpServletRequest req, @RequestParam("sort") String sort, @RequestParam("pageId") String pageId, @ModelAttribute PaginationVO pagination) {	
		HttpSession session = req.getSession();
		
		int cpage = Integer.parseInt(pageId);
		pagination.setPageId(cpage);
		int totalCount = cMapper.getTotalReviewCount();
		pagination.setTotalCount(totalCount);
		pagination.init(session);
		int start = (cpage - 1) * pagination.getPageSize();
		int end = cpage * pagination.getPageSize() + 1;
		pagination.setStart(start);
		pagination.setEnd(end);		
		
		String myctx = req.getContextPath();
		String loc = "/community";
		String pageNavi = pagination.getReviewPageNavi(myctx, loc);
		
		List<ReviewVO> arr = null;
		if(sort.equals("popular")) {
			arr = cMapper.getReviewListPopularPaging(pagination);
		}
		else {
			arr = cMapper.getReviewListLatestPaging(pagination);
		}
		
		for(ReviewVO vo:arr) {
			Object n = cMapper.isLiked("1", vo.getReview_id());
			int likeState = (n != null)? 1:0;
			vo.setLikeState(likeState);
		}
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("items", arr);	
		jsonObj.put("totalCount", pagination.getTotalCount());		
		jsonObj.put("pageId", pageId);		
		jsonObj.put("pageCount", pagination.getPageCount());		
		jsonObj.put("pageNavi", pageNavi);
		
		return jsonObj.toString();
	}
	
	@GetMapping("write")
	public ModelAndView reviewWriteform() {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("community/review/writeform");
		
		return mv;
	}
	
	@PostMapping("write")
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
		mv.setViewName("community/review/viewReview");
		cMapper.updateReviewReadnum(review_id);
		ReviewVO vo  = cMapper.getReview(review_id);
		mv.addObject("review", vo);

		return mv;
	}
	
	@GetMapping(value="{review_id}/edit")
	public ModelAndView reviewEditform(@PathVariable("review_id") String review_id) {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("community/review/editform");
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
		
		cMapper.deleteLikes(review_id);
		cMapper.deleteReports(review_id);
		int n = cMapper.deleteReview(review_id);
		
		String result = (n > 0)? "OK":"fail";
		map.put("result", result);
		
		return map;
	}
	
	@PostMapping(value="{review_id}/like")
	public void pushLike(@PathVariable("review_id") String review_id, @RequestParam("uid") String uid) {
		UUID uuid = UUID.randomUUID();
		cMapper.pushLike(uuid.toString(), uid, review_id);
	}
	
	@DeleteMapping(value="{review_id}/like")
	public void pushUnlike(@PathVariable("review_id") String review_id, @RequestParam("uid") String uid) {
		cMapper.pushUnlike(uid, review_id);
	}
	
	@GetMapping("{review_id}/report")
	public ModelAndView reviewReportform(@PathVariable("review_id") String review_id) {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("community/review/reportform");
		
		ReviewVO vo = cMapper.getReview(review_id);
		mv.addObject("title", vo.getReview_content());
		mv.addObject("nickname", vo.getReview_nickname());
		mv.addObject("user_id", vo.getUser_id_fk());
		
		return mv;
	}
	
	@PostMapping("{review_id}/report")
	public ModelAndView reportReview(@PathVariable("review_id") String review_id, @RequestParam("user_id") String user_id, @RequestParam("content") String content) {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("redirect:/community");
		
		UUID uuid = UUID.randomUUID();
		cMapper.reportReview(uuid.toString(), review_id, user_id, content);
		
		return mv;
	}
	
	
	
	
	
	@GetMapping("notice")
	public ModelAndView noticePage(@RequestParam(value="pageId", defaultValue="1") String pageId) {
		ModelAndView mv = new ModelAndView();
		mv.addObject("pageId", pageId);
		mv.setViewName("community/notice/notices");

		return mv;
	}
	
	@PostMapping(value="notice/getNotices", produces="application/json")
	public String getNoticeList(HttpServletRequest req, @RequestParam("pageId") String pageId, @ModelAttribute PaginationVO pagination) {	
		HttpSession session = req.getSession();
		
		int cpage = Integer.parseInt(pageId);
		pagination.setPageId(cpage);
		int totalCount = cMapper.getTotalNoticeCount();
		pagination.setTotalCount(totalCount);
		pagination.init(session);
		int start = (cpage - 1) * pagination.getPageSize();
		int end = cpage * pagination.getPageSize() + 1;
		pagination.setStart(start);
		pagination.setEnd(end);		
		
		String myctx = req.getContextPath();
		String loc = "/community/notice";
		String pageNavi = pagination.getNoticePageNavi(myctx, loc);
		
		List<NoticeVO> arr = cMapper.getNoticeListPaging(pagination);
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("items", arr);	
		jsonObj.put("totalCount", pagination.getTotalCount());		
		jsonObj.put("pageId", pageId);		
		jsonObj.put("pageCount", pagination.getPageCount());		
		jsonObj.put("pageNavi", pageNavi);
		
		return jsonObj.toString();
	}
	
	@GetMapping("notice/write")
	public ModelAndView noticeWriteform() {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("community/notice/writeform");
		
		return mv;
	}
	
	@PostMapping("notice/write")
	public ModelAndView writeNotice(@RequestParam("nickname") String nickname, @RequestParam("content") String content) {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("redirect:/community/notice");
		
		UUID uuid = UUID.randomUUID();
		cMapper.insertNotice(uuid.toString(), nickname, content);
		
		return mv;
	}
	
	@GetMapping(value="notice/{notice_id}")
	public ModelAndView viewNotice(@PathVariable("notice_id") String notice_id) {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("community/notice/viewNotice");
		cMapper.updateNoticeReadnum(notice_id);
		NoticeVO vo  = cMapper.getNotice(notice_id);
		mv.addObject("notice", vo);

		return mv;
	}
	
	@GetMapping(value="notice/{notice_id}/edit")
	public ModelAndView noticeEditform(@PathVariable("notice_id") String notice_id) {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("community/notice/editform");
		NoticeVO vo = cMapper.getNotice(notice_id);
		mv.addObject("notice", vo);
		
		return mv;
	}
	
	@PostMapping(value="notice/{notice_id}/edit")
	public ModelAndView editNotice(@PathVariable("notice_id") String notice_id, @RequestParam("content") String content) {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("redirect:/community/notice");
		
		cMapper.updateNotice(notice_id, content);
		
		return mv;
	}
	
	@DeleteMapping(value="notice/{notice_id}/del", produces="application/json")
	public Map<String, String> delNotice(@PathVariable("notice_id") String notice_id) {
		Map<String, String> map = new HashMap<>();
		
		int n = cMapper.deleteNotice(notice_id);
		
		String result = (n > 0)? "OK":"fail";
		map.put("result", result);
		
		return map;
	}

}
