<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<script src="https://cdn.ckeditor.com/4.17.2/standard/ckeditor.js"></script>

<script>
	$(function(){
		CKEDITOR.replace("content", {
			autoParagraph: false,
		});
		$("#nf").submit(function(){
			if(!CKEDITOR.instances.content.getData()){
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
		<h2>공지 쓰기</h2>
		<!--파일 업로드시
 			method: POST
  			enctype: multipart/form-data 
   		-->
		<form name="nf" id="nf" action="write" method="post" enctype="multipart/form-data">
			<!-- 글쓰기: write, 답글쓰기: rewrite, 수정: edit -->
			<input type="hidden" name="mode" value="write">
			<table class="table">
				<tr>
					<td style="width: 20%"><b>글쓴이</b></td>
					<td style="width: 80%; border:1">
						<input type="text" name="nickname" id="nickname" class="form-control" value="${nickname}" readonly>
					</td>
				</tr>
				<tr>
					<td style="width: 20%"><b>글내용</b></td>
					<td style="width: 80%">
						<textarea name="content" id="content" rows="10" cols="50" class="form-control"></textarea>
					</td>
				</tr>
				<tr>
					<td style="width: 20%"><b>첨부파일</b></td>
					<td style="width: 80%">
						<input type="file" name="filename" id="filename" class="form-control">
					</td>
				</tr>
				<tr>
					<td colspan="2" class="text-center">
						<button type="submit" id="btnWrite" class="btn btn-success">글쓰기</button>
						<button type="button" class="btn btn-secondary" onclick="location.href='javascript:history.back()'">닫기</button>
					</td>
				</tr>
			</table>
		</form>
	</div>
	<!-- .col end-->
</div>
<!-- .row end-->