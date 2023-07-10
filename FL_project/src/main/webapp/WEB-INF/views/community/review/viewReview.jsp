<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<style>
	@font-face {
	    font-family: 'NanumSquareNeo-Variable';
	    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_11-01@1.0/NanumSquareNeo-Variable.woff2') format('woff2');
	    font-weight: normal;
	    font-style: normal;
		}
	
	h1.title{
		color: aliceblue;
	    font-family: 'NanumSquareNeo-Variable';
	}
</style>

<div class="container">
	<div class="row mt-3">
		<div class="col-12 my-5">
			<h1 class="title text-center text-light">리뷰 내용</h1>
		</div>
		<div class="col-12">
			<table class="rounded bg-light shadow-sm table border='1'">
				<tr>
					<td width="5%"><b>글쓴이</b></td>
					<td width="45%" colspan="3"><c:out value="${review.review_nickname}" /></td>
					
				</tr>
				<tr>
					<td width="5%"><b>작성일</b></td>
					<td width="20%">
						<c:out value="${review.review_date1} " />
						<c:out value="${review.review_time}" />
					</td>
					<td width="5%"><b>조회수</b></td>
					<td width="20%"><c:out value="${review.review_readnum}" /></td>
				</tr>
				<tr>
					<td width="5%"><b>축제</b></td>
					<td width="45%" colspan="3">
						<a href="/festivals/${review.festival_id_fk}"><c:out value="${review.festival_name}" /></a>
					</td>
				</tr>
				<tr height="60">
					<td width="5%"><b>글내용</b></td>
					<td class="bg-white" align="left" colspan="3">
						<textarea name="content" id="content" rows="10" cols="50" class="form-control" readonly><c:out value="${review.review_content}"/></textarea>
					</td>
				</tr>
				<tr>
					<td class="text-center" colspan="4">
						<button class="btn btn-secondary" onclick="location.href='javascript:history.back()'">닫기</button>
					</td>
					<c:if test="${user.state eq 3 or userId eq review.user_id_fk}">
						<button class="btn btn-danger" onclick='delReview("${review.review_id}")'>삭제</button>
					</c:if>
				</tr>
			</table>
			<div class="mb-5">
			
			</div>
		</div>
	</div>
</div>
<script>
	const delReview = function(id){
		$.ajax({
			type:"delete",
			url:"/community/"+id,
			dataType:"json",
			cache:false,
		}).done((res)=>{
			if(res.result == "fail"){
				alert("리뷰 삭제 실패");
			}
			
			window.location.href = '/community?sort=&pageId=1';
		}).fail((err)=>{
			alert("error: "+err.status);
		});
	};
</script>