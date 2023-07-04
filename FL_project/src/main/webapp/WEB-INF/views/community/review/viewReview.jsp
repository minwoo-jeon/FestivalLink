<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<style>
	table.table{
		width:90%;
		margin:auto;
	}
</style>

<h2 class="text-center my-3">리뷰 내용</h2>

<table class="rounded shadow-sm table border='1'">
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
	<tr>
		<td width="20%">축제</td>
		<td width="30%"><c:out value="${review.festival_name}" /></td>
		<td width="30%"><img src="${review.review_image}"></td>
	</tr>
	<tr height="60">
		<td width="20%">글내용</td>
		<td class="bg-white" colspan="3" align="left">${review.review_content}</td>
	</tr>
</table>
