package com.project.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.mapper.YFestivalMapper;
import com.project.service.YFestivalService;
import com.project.domain.MyPagingVO;
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

    @GetMapping("/festivals/api-req")
    public void getFestivalInfoFromAPI() throws IOException {
        StringBuilder urlBuilder = new StringBuilder("http://api.data.go.kr/openapi/tn_pubr_public_cltur_fstvl_api");
        urlBuilder.append("?" + URLEncoder.encode("serviceKey", "UTF-8") + "=" + serviceKey);
        // 일단 축제 100개 -> 이미지때문에 30개 나옴
        urlBuilder.append("&" + URLEncoder.encode("numOfRows", "UTF-8") + "=" + URLEncoder.encode("100", "UTF-8"));
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
        //System.out.println(sb.toString());
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
        //log.info("festivalInfo = {}", festivalInfo);
        model.addAttribute("festivalInfo", festivalInfo);
        model.addAttribute("total", totalCountReview);
        return "festival_yj/festival_detail";
    }

    @ResponseBody
    @GetMapping(value = "/festivals/review/{festivalId}/{page}", produces = "application/json")
    public List<YReviewVO> geReviewByFid(Model m, @PathVariable String festivalId, @PathVariable int page) {
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
        List<YReviewVO> vo = yFestivalMapper.getReviewByFid(myP);
        log.info("festivalInfo = {}", vo);
        return vo;
    }

}
