<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>

<style>
#reviewTop{
	margin: auto;
}

p.board {
	font-size: 1.5em;
}

#list {
	width: 100%;
	margin: auto;
}
#list ul {
	width: 85%;
	margin: auto;
}

#list ul.reviewList>li {
	list-style: none;
	float: left;
	height: 100px;
	margin-bottom: 10px;
	background-color: white;
	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: flex-start;
}
#list ul.reviewList>li a {
	height: 100%;
}
#list ul.reviewList>li a img {
	height: 100%;
}
#list ul.reviewList>li:nth-child(3n+1) {
	width: 20%;
}
#list ul.reviewList>li:nth-child(3n+2) {
	width: 70%;
	font-weight: bold;
	font-size: 1.2em;
}
#list ul.reviewList>li:nth-child(3n) {
	width: 10%;
}

span.nickname {
	font-size: 0.7em;
	color: gray;
}

span.readnum {
	font-size: 0.8em;
	color: gray;
}

#pagination ul{
	margin:auto;
}
</style>

<script>
	$(function(){
		let pageId = $("#pageId").val();
		getReviews(pageId);
	});
	
	const getReviews = function(pageId){
		$.ajax({
			type:"post",
			url:"/community/getReviews",
			data:pageId,
			contentType:"application/json; charset=UTF-8",
			dataType:"json",
			cache:false,
		}).done((res)=>{
			showList(res.items);
			showPage(res.pageNavi, res.totalCount, res.pageId, res.pageCount);
		}).fail((err)=>{
			alert("error: "+err.status);
		});
	};
	
	const showList = function(arr){
		let str = "<ul class='reviewList'>";
		$.each(arr, (i, review)=>{
			str += "<li>";
			str += "<a href='/community/"+review.review_id+"'>";
			str += "<img src='/community_upload/noimage.png'>";
			str += "</a>";
			str += "</li>";
			str += "<li>";
			str += "<a href='/community/"+review.review_id+"'>";
			str += review.review_content;
			str += "<span class='nickname'>";
			str += review.review_nickname;
			str += "</a>";
			str += "</span>";
			str += "</li>";
			str += "<li>";
			str += "<p>"+review.review_date1+"</p>";
			str += "<span class='readnum'>";
			str += "조회수: "+review.review_readnum;
			str += "</span>";
			str += "</li>";
		});
		str += "</ul>";
		$("#list").html(str);
	};
	
	const showPage = function(pageNavi, totalCount, pageId, pageCount){
		let str = pageNavi;
		/* str += "총 게시글수: <span class='text-primary'>";
		str += totalCount+"개";
		str += "</span><br>";
		str += "<span class='text-danger'>";
		str += pageId;
		str += "</span>/";
		str += pageCount+"pages"; */
		
		$("#pagination").html(str);
	};
</script>
<div class="row">
	<div class="col-12 text-center">
		<h2>리뷰 게시판</h2>
	</div>
	<div class="col-10" id="reviewTop">
		<p class="board">
			<a href="/community">리뷰 게시판</a> | <a href="/community/notice">공지사항</a>
		</p>
		<p class="sort">
			<a href="#" onclick="">인기순</a> | <a href="#" onclick="">최신순</a>
			<button class="btn btn-primary float-right" id="write" name="write"
				onclick="location.href='/community/write'">리뷰쓰기</button>
		</p>
	</div>
</div>
<div class="row mt-3 float-left" id="list"></div>
<div class="row text-center" id="pagination">
	<input type="hidden" id="pageId" name="pageId" value="${pageId}">
</div>
