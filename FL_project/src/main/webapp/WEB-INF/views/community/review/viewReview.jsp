<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<style>

</style>

<<<<<<< HEAD
<div class="container">
	<div class="col-12">
		<h2 class="text-center my-3 text-light">리뷰 내용</h2>
	</div>
	<div class="col-12">
		<table class="rounded bg-light shadow-sm table border='1'">
			<tr>
				<td width="5%"><b>글쓴이</b></td>
				<td width="45%" colspan="3"><c:out value="${review.review_nickname}" /></td>
			</tr>
			<tr>
				<td width="5%"><b>작성일</b></td>
				<td width="20%"><c:out value="${review.review_date1}" /></td>
				<td width="5%"><b>조회수</b></td>
				<td width="20%"><c:out value="${review.review_readnum}" /></td>
			</tr>
			<tr>
				<td width="5%"><b>축제</b></td>
				<td width="45%" colspan="3"><c:out value="${review.festival_name}" /></td>
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
			</tr>
		</table>
		<div class="mb-5">
		
		</div>
	</div>
</div>
=======
<h2 class="text-center my-3 text-light">리뷰 내용</h2>

<table class="rounded bg-light shadow-sm table border='1'">
	<tr>
		<td width="5%"><b>글쓴이</b></td>
		<td width="45%" colspan="3"><c:out value="${review.review_nickname}" /></td>
	</tr>
	<tr>
		<td width="5%"><b>작성일</b></td>
		<td width="20%"><c:out value="${review.review_date1}" /></td>
		<td width="5%"><b>조회수</b></td>
		<td width="20%"><c:out value="${review.review_readnum}" /></td>
	</tr>
	<tr>
		<td width="5%"><b>축제</b></td>
		<td width="45%" colspan="3"><c:out value="${review.festival_name}" /></td>
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
	</tr>
</table>
<div class="mb-5">

</div>
>>>>>>> e48fb36257431de31b02828d2c9c392251934aee
