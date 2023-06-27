<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<h2 class="text-center my-3">리뷰 내용 보기</h2>

<table class="table mt-4">
	<tr>
		<td width="20%">작성일</td>
		<td width="30%"><c:out value="${review.review_date1}" /></td>
	</tr>
	<tr>
		<td width="20%">글쓴이</td>
		<td width="30%"><c:out value="${review.review_nickname}" /></td>
		<td width="20%">조회수</td>
		<td width="30%"><c:out value="${review.review_readnum}" /></td>
	</tr>
	<tr height="60">
		<td width="20%">글내용</td>
		<td colspan="3" align="left">${review.review_content}</td>
	</tr>
</table>
