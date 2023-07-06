<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script src="https://cdn.ckeditor.com/4.17.2/standard/ckeditor.js"></script>

<script>
	$(function(){
		CKEDITOR.replace("content", {
			autoParagraph: false,
		});
		$("#rf").submit(function(){
			let str = CKEDITOR.instances.content.getData();
			if(!str){
				alert("글내용을 입력하세요");
				CKEDITOR.instances.content.focus();
				return false;
			}
									
			return true;
		});
	});
</script>

<div class="row">
	<div align="center" class="col-md-8 offset-md-2 my-4">
		<h2>리뷰 신고하기</h2>
		<!--파일 업로드시
 			method: POST
  			enctype: multipart/form-data 
   		-->
		<form name="rf" id="rf" action="report" method="post">
			<!-- 글쓰기: write, 답글쓰기: rewrite, 수정: edit -->
			<input type="hidden" name="mode" value="write">
			<input type="hidden" name="user_id" value="${review.user_id_fk}">
			<table class="table">
				<tr>
					<td style="width: 20%"><b>신고자</b></td>
					<td style="width: 80%; border:1">
						<input type="text" name="nickname" id="nickname" class="form-control" value="${review.review_nickname}" readonly>
					</td>
				</tr>
				<tr>
					<td width="20%"><b>축제 이름</b></td>
					<td style="width: 80%; border:1">
						<input type="text" name="festName" id="festName" class="form-control" value="${review.festival_name}" readonly>
					</td>
				</tr>
				<tr>
					<td style="width: 20%"><b>신고글</b></td>
					<td style="width: 80%; border:1">
						<input type="text" name="title" id="title" class="form-control" value="${review.review_content}" readonly>
					</td>
				</tr>
				<tr>
					<td style="width: 20%"><b>신고내용</b></td>
					<td style="width: 80%">
						<textarea name="content" id="content" rows="10" cols="50" class="form-control"></textarea>
					</td>
				</tr>
				<tr>
					<td colspan="2" class="text-center">
						<button type="submit" id="btnWrite" class="btn btn-warning">신고하기</button>
						<button type="button" class="btn btn-secondary" onclick="location.href='javascript:history.back()'">닫기</button>
					</td>
				</tr>
			</table>
		</form>
	</div>
	<!-- .col end-->
</div>
<!-- .row end-->