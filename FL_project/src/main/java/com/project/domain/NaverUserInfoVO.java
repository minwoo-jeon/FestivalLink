package com.project.domain;

import javax.validation.constraints.Email;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@Data
public class NaverUserInfoVO {
	private String resultcode; // API 호출 결과 코드
	private String message; // 호출 결과 메시지
	private Response response; // 프로필 정보

	@Schema(description = "네이버 사용자")
	@Data
	public class Response {
		private String id; // 동일인 식별 정보(네이버 아이디마다 고유하게 발급되는 값)
		@Email
		@Schema(description = "이메일", nullable = false, example = "abc@festivalLink.me")
		private String email; // 사용자 메일 주소

	} // end class
}
