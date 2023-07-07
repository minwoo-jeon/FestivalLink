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
			
			let file = $("#filename").val();
			if(!isImage(file)){
				alert("이미지를 첨부하세요");
				return false;
			}
				
			return true;
		});
	});
	
	function isImage(file) {
		if(file == "" || /\.(jpg|jpeg|png|webp|avif|gif|svg)$/.test(file))
			return true;
		else
			return false;
	}
</script>

<div class="container">
	<div class="row">
		<div align="center" class="col-md-12 my-4">
			<h2 class="text-light">공지 쓰기</h2>
			<!--파일 업로드시
	 			method: POST
	  			enctype: multipart/form-data 
	   		-->
			<form name="nf" id="nf" action="write" method="post" enctype="multipart/form-data">
				<table class="table bg-light rounded">
					<tr>
						<td style="width: 10%"><b>글쓴이</b></td>
						<td style="width: 90%; border:1">
							<input type="text" name="nickname" id="nickname" class="form-control" value="${nickname}" readonly>
						</td>
					</tr>
					<tr>
						<td style="width: 10%"><b>글내용</b></td>
						<td style="width: 90%; border:1">
							<textarea name="content" id="content" rows="10" cols="50" class="form-control"></textarea>
						</td>
					</tr>
					<tr>
						<td style="width: 10%"><b>이미지 파일</b></td>
						<td style="width: 90%; border:1">
							<input type="file" accept="image/*" name="filename" id="filename" class="form-control">
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
</div>