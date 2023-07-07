package com.project.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.mapper.YFestivalMapper;
import com.project.service.YFestivalService;
import com.project.domain.FestivalPagingVO;
import com.project.domain.MyPagingVO;
import com.project.domain.ReviewVO;
import com.project.domain.YFestivalVO;
import com.project.domain.YReviewVO;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@PropertySource("ApiKey.properties")
@Tag(name = "/festivals")
@Slf4j
@RequiredArgsConstructor
@Controller
public class YFestivalController {

    private final YFestivalService yfestivalService;

    @Autowired
    private YFestivalMapper yFestivalMapper;

    @Value("${openapi.serviceKey}")
    private String serviceKey;

    public void makePaging(int totalCount, FestivalPagingVO vo, int page) {
        int pageSize = 16;
        int pageCount = (totalCount - 1) / pageSize + 1;
        if (page < 0) {
            page = 1;
        }
        if (page > pageCount) {
            page = pageCount;
        }
        int end = page * pageSize;
        int start = end - pageSize;
        vo.setEnd(end);
        vo.setStart(start);
    }

    @Operation(summary = "축제 정보 업데이트") // 정의하려는 API 명시
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "축제 객체들 DB에 반환")
    })
    @GetMapping("/festivals/api-req")
    public void getFestivalInfoFromAPI() throws IOException {
        StringBuilder urlBuilder = new StringBuilder("http://api.data.go.kr/openapi/tn_pubr_public_cltur_fstvl_api");
        urlBuilder.append("?" + URLEncoder.encode("serviceKey", "UTF-8") + "=" + serviceKey);
        // 일단 축제 100개 -> 이미지때문에 30개 나옴
        urlBuilder.append("&" + URLEncoder.encode("numOfRows", "UTF-8") + "=" + URLEncoder.encode("300", "UTF-8"));
        urlBuilder.append("&" + URLEncoder.encode("type", "UTF-8") + "=" + URLEncoder.encode("json", "UTF-8")); /*
                                                                                                                   */
        URL url = new URL(urlBuilder.toString());
        // url만들기 끝//
        // 연결 시작
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        conn.setRequestProperty("Content-type", "application/json");

        System.out.println("Response code: " + conn.getResponseCode());
        BufferedReader rd;

        if (conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
            rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
        } else {
            rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
        }
        StringBuilder sb = new StringBuilder();
        String line;
        while ((line = rd.readLine()) != null) {
            sb.append(line);
        }
        rd.close();
        conn.disconnect();
        // System.out.println(sb.toString());
        yfestivalService.festivalDataParse(sb);
        System.out.println("controller 끝!");

    }

    @Operation(summary = "축제 상세 페이지") // 정의하려는 API 명시
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "축제 객체 모델에 반환 ")
    })
    @GetMapping("/festivals/{festivalId}")
    public String likeReview(Model model, @PathVariable String festivalId) {
        int totalCountReview = this.yFestivalMapper.totalReviewCountByFest(festivalId);
        YFestivalVO festivalInfo = yFestivalMapper.getFestivalInfoById(festivalId);
        // log.info("festivalInfo = {}", festivalInfo);
        model.addAttribute("festivalInfo", festivalInfo);
        model.addAttribute("total", totalCountReview);
        return "festival_yj/festivalDetail";
    }

    @Operation(summary = "축제 상세 페이지-리뷰불러오기") // 정의하려는 API 명시
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "축제와 관련된 리뷰 불러오기")
    })
    @ResponseBody
    @GetMapping(value = "/festivals/review/{festivalId}/{page}", produces = "application/json")
    public List<ReviewVO> geReviewByFid(Model m, @PathVariable String festivalId, @PathVariable int page) {
        int totalCount = this.yFestivalMapper.totalReviewCountByFest(festivalId);
        log.info("total ={}", totalCount);
        int pageSize = 3;
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
        // myP의 userId에 festivalId넣음
        myP.setUserId(festivalId);
        List<ReviewVO> vo = yFestivalMapper.getReviewByFid(myP);
        log.info("festivalInfo = {}", vo);
        return vo;
    }

    @Operation(summary = "홈페이지 메인 화면") // 정의하려는 API 명시
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "festivals/list?loc=&keyword=&page=1로 이동 ")
    })
    @GetMapping("/festivals")
    public String FestivalPage(Model m) {
        int totalCount = yFestivalMapper.getTotalFestivalCount();
        m.addAttribute("total", totalCount);
        return "festival_yj/festivalList";
    }

    @Operation(summary = "축제 메인 검색 페이지") // 정의하려는 API 명시
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "지역 별, 키워드 별 인기순으로 반환")
    })
    @ResponseBody
    @GetMapping(value = "/festivals/list", produces = "application/json")
    public List<YFestivalVO> festivalMain(Model model,
            @RequestParam String loc, @RequestParam String keyword, @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "1") int sort) {
                
        List<YFestivalVO> fList = new ArrayList<>();
        FestivalPagingVO vo = new FestivalPagingVO();
        int totalCount;
        if (sort == 1) {
            if (loc == "" && keyword == "") {
                totalCount = yFestivalMapper.getTotalFestivalCount();
                makePaging(totalCount, vo, page);
                fList = yFestivalMapper.getFestivalList(vo);
                model.addAttribute("total", totalCount);

            } else if (loc == "" && keyword != "") {
                totalCount = yFestivalMapper.getTotalFestivalCountWithKeyword(keyword);
                makePaging(totalCount, vo, page);
                vo.setKeyword(keyword);
                
                fList = yFestivalMapper.getFestivalListWithKeyword(vo);
            } else if (loc != "" && keyword == "") {
                totalCount = yFestivalMapper.getTotalFestivalCountWithLoc(loc);
                makePaging(totalCount, vo, page);
                vo.setLoc(loc);
                
                fList = yFestivalMapper.getFestivalListWithLoc(vo);
            } else {
                totalCount = yFestivalMapper.getTotalFestivalCountWithKeywordNLoc(keyword, loc);
                makePaging(totalCount, vo, page);
                vo.setKeyword(keyword);
                vo.setLoc(loc);
                
                fList = yFestivalMapper.getFestivalListWithKeywordNLoc(vo);
            }
        }else if(sort==2){
            if (loc == "" && keyword == "") {
                totalCount = yFestivalMapper.getTotalFestivalCount();
                makePaging(totalCount, vo, page);
                fList = yFestivalMapper.getFestivalListLatest(vo);
                
                model.addAttribute("total", totalCount);
            } else if (loc == "" && keyword != "") {
                totalCount = yFestivalMapper.getTotalFestivalCountWithKeyword(keyword);
                makePaging(totalCount, vo, page);
                vo.setKeyword(keyword);
                
                fList = yFestivalMapper.getFestivalListWithKeywordLatest(vo);
            } else if (loc != "" && keyword == "") {
                totalCount = yFestivalMapper.getTotalFestivalCountWithLoc(loc);
                makePaging(totalCount, vo, page);
                vo.setLoc(loc);
                
                fList = yFestivalMapper.getFestivalListWithLocLatest(vo);
            } else {
                totalCount = yFestivalMapper.getTotalFestivalCountWithKeywordNLoc(keyword, loc);
                makePaging(totalCount, vo, page);
                vo.setKeyword(keyword);
                vo.setLoc(loc);
                
                fList = yFestivalMapper.getFestivalListWithKeywordNLocLatest(vo);
            }
        }

        return fList;
    }
}
