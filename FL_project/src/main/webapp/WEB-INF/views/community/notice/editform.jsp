<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<script src="https://cdn.ckeditor.com/4.17.2/standard/ckeditor.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>

<script>
	$(function(){
		CKEDITOR.replace("content", {
			autoParagraph: false,
		});
		$("#ef").submit(function(){
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
		<h2>공지사항 수정</h2>
		<!--파일 업로드시
 			method: POST
  			enctype: multipart/form-data 
   		-->
		<form name="ef" id="ef" action="edit" method="post" enctype="multipart/form-data">
			<!-- 글쓰기: write, 답글쓰기: rewrite, 수정: edit -->
			<input type="hidden" name="mode" value="write">
			<input type="hidden" name="notice_id" id="notice_id" value="${notice.notice_id}">
			<table class="table">
				<tr>
					<td style="width: 20%"><b>글쓴이</b></td>
					<td style="width: 80%; border:1">
						<input type="text" name="nickname" id="nickname" class="form-control" value="${notice.notice_nickname}" readonly>
					</td>
				</tr>
				<tr>
					<td style="width: 20%"><b>글내용</b></td>
					<td style="width: 80%">
						<textarea name="content" id="content" rows="10" cols="50" class="form-control">${notice.notice_content}</textarea>
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
						<button type="submit" id="btnEdit" class="btn btn-success">수정하기</button>
						<button type="reset" id="btnReset" class="btn btn-warning">다시쓰기</button>
					</td>
				</tr>
			</table>
		</form>
	</div>
	<!-- .col end-->
</div>
<!-- .row end-->