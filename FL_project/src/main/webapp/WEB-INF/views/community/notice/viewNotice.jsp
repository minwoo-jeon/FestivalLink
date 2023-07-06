<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<style>
	table.table{
		width:90%;
		margin:auto;
	}
</style>

<h2 class="text-center my-3">공지사항 내용</h2>

<table class="rounded shadow-sm table border='1'">
	<tr>
		<td width="20%">작성일</td>
		<td width="30%"><c:out value="${notice.notice_date1}" /></td>
	</tr>
	<tr>
		<td width="20%">글쓴이</td>
		<td width="30%"><c:out value="${notice.notice_nickname}" /></td>
		<td width="20%">조회수</td>
		<td width="30%"><c:out value="${notice.notice_readnum}" /></td>
	</tr>
	<tr height="60">
		<td width="20%">글내용</td>
		<td class="bg-white" colspan="3" align="left">
			<textarea name="content" id="content" rows="10" cols="50" class="form-control" readonly><c:out value="${notice.notice_content}"/></textarea>
		</td>
	</tr>
	<tr>
		<td class="text-center" colspan="4">
			<button type="button" class="btn btn-secondary" onclick="location.href='javascript:history.back()'">닫기</button>
		</td>
	</tr>
</table>
