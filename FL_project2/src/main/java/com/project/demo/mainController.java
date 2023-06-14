//package com.project.demo;
//
//import org.springframework.http.HttpStatus;
//import org.springframework.http.ResponseEntity;
//import org.springframework.web.bind.annotation.GetMapping;
//import org.springframework.web.bind.annotation.RequestMapping;
//import org.springframework.web.bind.annotation.RestController;
//
//import com.project.domain.Member;
//
//import io.swagger.annotations.ApiOperation;
//
//@RestController
//@RequestMapping("/api")
//public class mainController {
//	
//	ResponseEntity<?> entity = null;
//
//	@ApiOperation(value="사용자 등록", notes="사용자 등록")
//	@GetMapping(value="/home")
//	public ResponseEntity<?> registerMember(String id,String name,String email) {
//		Member member = new Member();
//		member.setId(id);
//		member.setName(name);
//		member.setEmail(email);
//		entity = new ResponseEntity<Member>(member, HttpStatus.OK);
//		return entity;
//	}
//	
//}