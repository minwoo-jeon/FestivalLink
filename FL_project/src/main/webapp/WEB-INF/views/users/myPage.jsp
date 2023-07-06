<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<style>
  table {
    width: 100%;
    border: 1px solid #444444;
    height:100;
    border-collapse: collapse;
  }
  th, td {
    border: 1px solid #444444;
    height:100px;
    padding: 10px;
  }
</style>

      <div class="container">
    	<h1 class="text-center mb-3"  div style="padding:30px">${user.nickname} 님의 페이지</h1>
    	<table border="0" class="table table-striped mt-3">
    		<tr>
    			<td onclick="location.href='/users/modify'"><font size="10"><p style="color:white">내 정보 수정 ></td>
    		</tr>
    		<tr>
    			<td><font size="10"><p style="color:white">내가 좋아요한 축제 ></td>
    			<br>

    		</tr>
    		<tr>
    			<td><font size="10"><p style="color:white">내가 쓴 글 ></td>
    		</tr>
    		<tr>
    			<td><font size="10"><p style="color:white">좋아요한 리뷰글 ></td>
    		</tr>
    		<tr>
    		</tr>
    	</table>

    </div>
