<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

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
		<h2 class="text-light">리뷰 수정</h2>
		<!--파일 업로드시
 			method: POST
  			enctype: multipart/form-data 
   		-->
		<form name="ef" id="ef" action="edit" method="post" enctype="multipart/form-data">
			<input type="hidden" name="review_id" id="review_id" value="${review.review_id}">
			<table class="table bg-light rounded">
				<tr>
					<td style="width: 10%"><b>글쓴이</b></td>
					<td style="width: 90%; border:1">
						<input type="text" name="nickname" id="nickname" class="form-control" value="${review.review_nickname}" readonly>
					</td>
				</tr>
				<tr>
					<td width="10%"><b>축제</b></td>
					<td style="width: 90%; border:1">
						<input type="text" name="nickname" id="nickname" class="form-control" value="${review.festival_name}" readonly>
					</td>
				</tr>
				<tr>
					<td style="width: 10%"><b>글내용</b></td>
					<td style="width: 90%; border:1">
						<textarea name="content" id="content" rows="10" cols="50" class="form-control"><c:out value="${review.review_content}"/></textarea>
					</td>
				</tr>
				<tr>
					<td colspan="2" class="text-center">
						<button type="submit" id="btnEdit" class="btn btn-success">수정하기</button>
						<button type="button" class="btn btn-secondary" onclick="location.href='javascript:history.back()'">닫기</button>
					</td>
				</tr>
			</table>
		</form>
	</div>
	<!-- .col end-->
</div>
<!-- .row end-->