package com.project.controller;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

@Tag(name = "테스트용")
@RestController
public class TestController {

    @Operation(summary = "이름을 조회.") // 정의하려는 API 명시
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "이름 조회"),
            @ApiResponse(responseCode = "400", description = "존재하지 않는 이름 조회")
    })
    
    @GetMapping("/api/test/name")
    public ResponseEntity<String> name() {
        return ResponseEntity.ok()
                .body("김철수");
    }
    
    // @Operation(summary = "테스트 페이지") // 정의하려는 API 명시
    // @ApiResponses(value = {
    //         @ApiResponse(responseCode = "200", description = "테스트 페이지"),
    //         @ApiResponse(responseCode = "400", description = "테스트 페이지 실패")
    // })
    
    @GetMapping("/test")
    public ModelAndView testPage() {

        return new ModelAndView("test");
    }
    
}
