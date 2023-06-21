<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>

<script>
	$(function(){
		getReview();
	});
	
	const getReviews = function(){
		$.ajax({
			type:"post",
			url:"community/getReviews",
			dataType:"json",
			cache:false,
		}).done((res)=>{
			showList(res);
		}).fail((err)=>{
			alert(err.status);
		});
	};
	
	const showList = function((res)=>{
		let str = "<ul>";
		$.each(res, (i, review)=>{
			str += "<li>";
			str += review.title;
			str += "</li>";
			str += "<li>";
			str += review.nickname;
			str += "</li>";
			str += "<li>";
			str += review.readnum;
			str += "</li>";
		});
		str += "</ul>";
		$("#list").html(str);
	});
	
	const writeform = function((res)=>{
		$.ajax({
			type:"post",
			url:"community/write",
			dataType:"json",
			cache:false,
		}).done((res)=>{
			alert(res);
		}).fail((err)=>{
			alert(err.status);
		});
	});
</script>

<div class="container">
	<div class="row my-3">
		<div class="col-12 text-center">
			<h2>리뷰 게시판</h2>
		</div>
		<div class="col-12">
			<p>
				<a href="community">리뷰 게시판</a> | <a href="community/notice">공지사항</a>
			</p>
			<p>
				<a href="#" onclick="">인기순</a> | <a href="#" onclick="">최신순</a>
			</p>
			<button class="btn btn-secondary" id="write" name="write" onclick="writeform()">리뷰쓰기</button>
		</div>
	</div>
	<div class="row" id="list">
		
	</div>
</div>