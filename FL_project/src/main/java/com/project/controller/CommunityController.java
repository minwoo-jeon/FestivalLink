 package com.project.controller;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.ServletContext;
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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.project.domain.NaverUserVO;
import com.project.domain.NoticeVO;
import com.project.domain.PaginationVO;
import com.project.domain.ReviewVO;
import com.project.domain.UserVo;
import com.project.domain.YFestivalVO;
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
	public ModelAndView reviewPage(@RequestParam(value="sort", defaultValue="none") String sort, @RequestParam(value="pageId", defaultValue="1") String pageId) {
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
		String pageNavi = pagination.getReviewPageNavi(myctx, loc, sort);
		
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
	public ModelAndView reviewWriteform(HttpSession session, @RequestParam(value="festName", defaultValue="") String festName) {
		ModelAndView mv = new ModelAndView();
		
		Object user = session.getAttribute("user");
		if(user != null) {
			String nickname = null;
			if(user instanceof UserVo && ((UserVo)user).getState() != 2) {
				nickname = ((UserVo)user).getNickname();
			}
			else if(user instanceof NaverUserVO && ((NaverUserVO)user).getState() != 2){
				nickname = ((NaverUserVO)user).getNickname();
			}
			
			mv.addObject("nickname", nickname);
			mv.addObject("festName", festName);
			mv.setViewName("community/review/writeform");
		}
		else {
			mv.setViewName("redirect:/community");
		}
		
		return mv;
	}
	
	@GetMapping("festivalSearch")
	public ModelAndView festivalSearchForm() {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("community/review/festivalSearch");
		
		return mv;
	}
	
	@PostMapping(value="/autoComp", produces="application/json")
	public List<String> getAutoComplete(@RequestParam(defaultValue="") String keyword){
		return cMapper.getAutoComplete(keyword);
	}
	
	@PostMapping("write")
	public ModelAndView writeReview(HttpSession session, @RequestParam("nickname") String nickname, @RequestParam("festName") String festName, @RequestParam("content") String content) {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("redirect:/community");
		
		Object user = session.getAttribute("user");
		if(user != null) {
			String uid = null;
			if(user instanceof UserVo && ((UserVo)user).getState() != 2) {
				uid = ((UserVo)user).getUser_id();
			}
			else if(user instanceof NaverUserVO && ((NaverUserVO)user).getState() != 2){
				uid = ((NaverUserVO)user).getUser_id();
			}
			
			YFestivalVO vo = cMapper.getFestivalByName(festName);
			UUID uuid = UUID.randomUUID();
			cMapper.insertReview(uuid.toString(), uid, vo.getFestival_id(), nickname, content, vo.getFestival_image());
		}
		else {
			mv.setViewName("redirect:/community");
		}
		
		return mv;
	}
	
	@GetMapping(value="{review_id}")
	public ModelAndView viewReview(@PathVariable("review_id") String review_id) {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("community/review/viewReview");
		cMapper.updateReviewReadnum(review_id);
		ReviewVO rvo  = cMapper.getReview(review_id);
		YFestivalVO fvo = cMapper.getFestivalById(rvo.getFestival_id_fk());
		rvo.setFestival_name(fvo.getFestival_name());
		mv.addObject("review", rvo);

		return mv;
	}
	
	@GetMapping(value="{review_id}/edit")
	public ModelAndView reviewEditform(@PathVariable("review_id") String review_id, HttpSession session) {
		ModelAndView mv = new ModelAndView();
		
		Object user = session.getAttribute("user");
		if(user != null) {
			if(user instanceof UserVo && ((UserVo)user).getState() == 2) {
				mv.setViewName("redirect:/community");
			}
			else if(user instanceof NaverUserVO && ((NaverUserVO)user).getState() == 2){
				mv.setViewName("redirect:/community");
			}
			else {
				mv.setViewName("community/review/editform");
				ReviewVO rvo  = cMapper.getReview(review_id);
				YFestivalVO fvo = cMapper.getFestivalById(rvo.getFestival_id_fk());
				rvo.setFestival_name(fvo.getFestival_name());
				mv.addObject("review", rvo);
			}
		}
		else {
			mv.setViewName("redirect:/community");
		}
		
		return mv;
	}
	
	@PostMapping(value="{review_id}/edit")
	public ModelAndView editReview(@PathVariable("review_id") String review_id, @RequestParam("content") String content) {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("redirect:/community");
		
		cMapper.updateReview(review_id, content);
		
		return mv;
	}
	
	@DeleteMapping(value="{review_id}", produces="application/json")
	public Map<String, String> delReview(@PathVariable("review_id") String review_id) {
		Map<String, String> map = new HashMap<>();
		
		cMapper.deleteLikes(review_id);
		cMapper.deleteReports(review_id);
		int n = cMapper.deleteReview(review_id);
		//System.out.println("n = "+n);
		String result = (n > 0)? "OK":"fail";
		map.put("result", result);
		//System.out.println(map);
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
	public ModelAndView reviewReportform(@PathVariable("review_id") String review_id, HttpSession session) {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("community/review/reportform");
		
		Object user = session.getAttribute("user");
		if(user != null) {
			if(user instanceof UserVo && ((UserVo)user).getState() == 2) {
				mv.setViewName("redirect:/community");
			}
			else if(user instanceof NaverUserVO && ((NaverUserVO)user).getState() == 2){
				mv.setViewName("redirect:/community");
			}
			else {
				ReviewVO rvo  = cMapper.getReview(review_id);
				YFestivalVO fvo = cMapper.getFestivalById(rvo.getFestival_id_fk());
				rvo.setFestival_name(fvo.getFestival_name());
				mv.addObject("review", rvo);
			}
		}
		else {
			mv.setViewName("redirect:/community");
		}
		
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
		for(NoticeVO vo:arr) {
			if(vo.getNotice_image() != null) {
				vo.setNotice_image("/resources/community_upload/notice/"+vo.getNotice_image());
			}
			else {
				vo.setNotice_image("/resources/community_upload/noimage.png");
			}
		}
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("items", arr);	
		jsonObj.put("totalCount", pagination.getTotalCount());		
		jsonObj.put("pageId", pageId);		
		jsonObj.put("pageCount", pagination.getPageCount());		
		jsonObj.put("pageNavi", pageNavi);
		
		return jsonObj.toString();
	}
	
	@GetMapping("notice/write")
	public ModelAndView noticeWriteform(HttpSession session) {
		ModelAndView mv = new ModelAndView();
		
		Object user = session.getAttribute("user");
		if(user != null) {
			String nickname = null;
			if(user instanceof UserVo && ((UserVo)user).getState() == 3) {
				nickname = ((UserVo)user).getNickname();
			}
			else if(user instanceof NaverUserVO && ((NaverUserVO)user).getState() == 3){
				nickname = ((NaverUserVO)user).getNickname();
			}
			
			mv.addObject("nickname", nickname);
			mv.setViewName("community/notice/writeform");
		}
		else {
			mv.setViewName("redirect:/community");
		}
	
		return mv;
	}
	
	@PostMapping("notice/write")
	public ModelAndView writeNotice(HttpSession session, @RequestParam("nickname") String nickname, @RequestParam("content") String content, @RequestParam("filename") MultipartFile filename) {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("redirect:/community/notice");
		
		ServletContext ctx = session.getServletContext();
		String upDir = ctx.getRealPath("/resources/community_upload/notice");
		File dir = new File(upDir);
		if(!dir.exists())
			dir.mkdirs();
		
		String fname = "";
		if(!filename.isEmpty()) {
			UUID uuid = UUID.randomUUID();
			String origin = filename.getOriginalFilename();
			fname = uuid.toString()+"_"+origin;
			
			try {
				filename.transferTo(new File(upDir, fname));
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		
		Object user = session.getAttribute("user");
		if(user != null) {
			String uid = null;
			if(user instanceof UserVo && ((UserVo)user).getState() != 2) {
				uid = ((UserVo)user).getUser_id();
			}
			else if(user instanceof NaverUserVO && ((NaverUserVO)user).getState() != 2){
				uid = ((NaverUserVO)user).getUser_id();
			}
			
			UUID uuid = UUID.randomUUID();
			cMapper.insertNotice(uuid.toString(), uid, nickname, content, fname);
		}
		else {
			mv.setViewName("redirect:/community");
		}
		
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
	public ModelAndView noticeEditform(@PathVariable("notice_id") String notice_id, HttpSession session) {
		ModelAndView mv = new ModelAndView();
		
		Object user = session.getAttribute("user");
		if(user != null) {
			if(user instanceof UserVo && ((UserVo)user).getState() != 3) {
				mv.setViewName("redirect:/community");
			}
			else if(user instanceof NaverUserVO && ((NaverUserVO)user).getState() != 3){
				mv.setViewName("redirect:/community");
			}
			else {
				mv.setViewName("community/notice/editform");
				NoticeVO vo = cMapper.getNotice(notice_id);
				mv.addObject("notice", vo);
			}
		}
		else {
			mv.setViewName("redirect:/community");
		}
		
		return mv;
	}
	
	@PostMapping(value="notice/{notice_id}/edit")
	public ModelAndView editNotice(@PathVariable("notice_id") String notice_id, HttpSession session, @RequestParam("content") String content, @RequestParam("filename") MultipartFile filename) {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("redirect:/community/notice");
		
		ServletContext ctx = session.getServletContext();
		String upDir = ctx.getRealPath("/resources/community_upload/notice");
		File dir = new File(upDir);
		if(!dir.exists())
			dir.mkdirs();
		
		String fname = "";
		if(!filename.isEmpty()) {
			UUID uuid = UUID.randomUUID();
			String origin = filename.getOriginalFilename();
			fname = uuid.toString()+"_"+origin;
			
			try {
				filename.transferTo(new File(upDir, fname));
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		
		cMapper.updateNotice(notice_id, content, fname);
		
		return mv;
	}
	
	@DeleteMapping(value="notice/{notice_id}", produces="application/json")
	public Map<String, String> delNotice(@PathVariable("notice_id") String notice_id, HttpSession session) {
		Map<String, String> map = new HashMap<>();
		
		ServletContext ctx = session.getServletContext();
		String upDir = ctx.getRealPath("/resources/community_upload/notice");
		NoticeVO vo = cMapper.getNotice(notice_id);
		File file = new File(upDir, vo.getNotice_image());
		if(file.exists()) {
			file.delete();
		}
		
		int n = cMapper.deleteNotice(notice_id);
		
		String result = (n > 0)? "OK":"fail";
		map.put("result", result);
		
		return map;
	}

}
