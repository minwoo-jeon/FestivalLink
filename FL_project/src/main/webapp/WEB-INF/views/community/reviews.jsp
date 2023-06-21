<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>

<style>
	p.board{
		font-size:1.5em;
	}
	
	button.btn{
		float:right;
	}
	
	#list{
		width:100%;
		margin-top:0;
		margin:auto;
		float:left;
	}
	#list ul{
		width:100%;
	}
	#list ul.reviewList > li{
		list-style:none;
		float:left;
		height:100px;
		margin-bottom:10px;
		background-color: white;
		display:flex;
	    flex-direction:column;
	    justify-content:center;
	    align-items:flex-start;
	}
	#list ul.reviewList > li img{
		height:100%;
	}
	#list ul.reviewList > li:nth-child(3n+1){
		width:20%;
	}
	#list ul.reviewList > li:nth-child(3n+2){
		width:70%;
		font-weight:bold;
		font-size:1.2em;
	}
	#list ul.reviewList > li:nth-child(3n){
		width:10%;
	}
		
	span.nickname{
		font-size:0.7em;
		color:gray;
	}
	span.readnum{
		font-size:0.8em;
		color:gray;
	}
</style>

<script>
	$(function(){
		getReviews();
	});
	
	const getReviews = function(){
		$.ajax({
			type:"post",
			url:"/community/getReviews",
			dataType:"json",
			cache:false,
		}).done((res)=>{
			showList(res);
		}).fail((err)=>{
			alert("error: "+err.status);
		});
	};
	
	const showList = function(res){
		let str = "<ul class='reviewList'>";
		$.each(res, (i, review)=>{
			str += "<li>";
			str += "<img src='/community_upload/noimage.png'>";
			str += "</li>";
			str += "<li>";
			str += review.review_content;
			str += "<span class='nickname'>";
			str += review.review_nickname;
			str += "</span>";
			str += "</li>";
			str += "<li>";
			str += "<p>"+review.review_date+"</p>";
			str += "<span class='readnum'>";
			str += "조회수: "+review.review_readnum;
			str += "</span>";
			str += "</li>";
		});
		str += "</ul>";
		$("#list").html(str);
	};
</script>

<div class="container">
	<div class="row my-3">
		<div class="col-12 text-center">
			<h2>리뷰 게시판</h2>
		</div>
		<div class="col-12">
			<p class="board">
				<a href="/community">리뷰 게시판</a> | <a href="/community/notice">공지사항</a>
			</p>
			<p class="sort">
				<a href="#" onclick="">인기순</a> | <a href="#" onclick="">최신순</a>
				<button class="btn btn-primary" id="write" name="write" onclick="location.href='/community/write'">리뷰쓰기</button>
			</p>
		</div>
	</div>
	<div class="row" id="list">
	</div>
</div>