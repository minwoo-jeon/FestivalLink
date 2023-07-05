<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <style>
    	.myPageTable{
    		width: 70%;
    		margin: 1em auto;
    	}
    	td{
    		padding:7px;
    	}
    	td:last-child{
    		text-align:left;

    	}
    </style>

      <div class="container">
    	<h1 class="text-center mb-3"  div style="padding:30px">${user.nickname} 님의 페이지</h1>
    	<table border="0" class="table table-striped mt-3">
    		<tr>
    			<td><a href=/users/modify/1>내 정보 수정</td>
    		</tr>
    		<tr>
    			<td><a href=/users/myFestival/1>내가 좋아요한 축제</td>
    		</tr>
    		<tr>
    			<td><a href=/users/myReview/1>내가 쓴 글</a></td>
    		</tr>
    		<tr>
    			<td><a href=/users/likedReview/1>좋아요한 리뷰글</a></td>
    		</tr>
    		<tr>
    		</tr>
    	</table>

    </div>
