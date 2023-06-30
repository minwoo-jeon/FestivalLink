<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>

<style>
#reviewTop{
	margin: auto;
}
#reviewTop a{
	color:black;
}

p.board {
	font-size: 1.5em;
}

/* #list div {
	width: 100%;
	margin: auto;
}
#list div ul {
	width: 85%;
	margin: auto;
}

#list div ul.reviewList>li {
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
#list div ul.reviewList>li a {
	height: 100%;
}
#list div ul.reviewList>li a img {
	height: 100%;
}
#list div ul.reviewList>li:nth-child(3n+1) {
	width: 20%;
}
#list div ul.reviewList>li:nth-child(3n+2) {
	width: 70%;
	font-weight: bold;
	font-size: 1.2em;
}
#list div ul.reviewList>li:nth-child(3n) {
	width: 10%;
} */

div.reviews{
	width:90%;
	margin:auto;
}
div.reviews div{
	float:left;
}
div.reviews div.image{
	width:10%;
}
div.reviews div.image img{
	width:100%;
}
div.reviews div.title{
	width:80%;
	padding-left:10px;
}
div.reviews div.title a p{
	font-size:1.5em;
}
div.reviews div.etc{
	width:10%;
}
div.reviews div.etc *{
	display:inline-block;
}

span.nickname, span.readnum{
	color: gray;
}

p.click{
	color:gray;
	cursor:pointer;
}

#pagination ul{
	margin:auto;
}
</style>

<script>
	$(function(){
		getReviews("${sort}", ${pageId});
	});
	
	const getReviews = function(sort, pageId){
		$.ajax({
			type:"post",
			url:"/community/getReviews?sort="+sort+"&pageId="+pageId,
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
		//let str = "<ul class='reviewList'>";
		let str = "";
		$.each(arr, (i, review)=>{
			str += "<div class='bg-white rounded shadow-sm p-4 mb-5 pb-3 reviews'>";
			//str += "<li>";
			str += "<div class='image'>";
			str += "<a href='/community/"+review.review_id+"'>";
			str += "<img src='/community_upload/noimage.png'>";
			str += "</a>";
			str += "</div>";
			//str += "</li>";
			//str += "<li>";
			str += "<div class='title'>";
			str += "<a href='/community/"+review.review_id+"'>";
			str += review.review_content;
			str += "<span class='nickname'>";
			str += review.review_nickname;
			str += "</span>";
			str += "</a>";
			str += "</div>";
			//str += "</li>";
			//str += "<li>";
			str += "<div class='etc'>";
			str += "<p class='click' onclick='location.href=\"/community/"+review.review_id+"/edit\"'>수정";
			str += "</p> | ";
			str += "<p class='click' onclick='delReview(\""+review.review_id+"\")'>삭제";
			str += "</p><br>";
			str += review.review_date1+"<br>";
			str += "<span class='readnum'>";
			str += "조회수: "+review.review_readnum;
			str += "</span><br>";
			str += "<button onclick='pushLike(\""+review.review_id+"\", \""+1+"\", \""+1+"\")' class='btn btn-outline-primary btn-sm' style='margin-top:10px;'>좋아요: ";
			str += "<b id='like_count-"+review.review_id+"'>"+review.likes+"</b>";
			if(review.likeState == 0){
				str += "<i class='bi bi-hand-thumbs-up' id='thumbs-up-"+review.review_id+"'></i>";
			}
			else{
				str += "<i class='bi bi-hand-thumbs-up-fill' id='thumbs-up-"+review.review_id+"'></i>";
			}		
			str += "</button>";
			str += "</div>";
			//str += "</li>";
			str += "</div>";
		});
		//str += "</ul>";
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
	
	const delReview = function(id){
		$.ajax({
			type:"delete",
			url:"/community/"+id+"/del",
			dataType:"json",
			cache:false,
		}).done((res)=>{
			if(res.result == "fail"){
				alert("리뷰 삭제 실패");
			}
			
			getReviews("${sort}", ${pageId});
		}).fail((err)=>{
			alert("error: "+err.status);
		});
	};
	
	const pushLike = function(rid, uid){
		if($("#thumbs-up-"+rid).hasClass("bi-hand-thumbs-up")){
			$.ajax({
				type:"post",
				url:"/community/"+rid+"/like?uid="+uid,
				cache:false,
			}).done((res)=>{
				$("#thumbs-up-"+rid).removeClass("bi-hand-thumbs-up");
				$("#thumbs-up-"+rid).addClass("bi-hand-thumbs-up-fill");			
			}).fail((err)=>{
				alert("error: "+err.status);
			});
		}
		else if($("#thumbs-up-"+rid).hasClass("bi-hand-thumbs-up-fill")){
			$.ajax({
				type:"delete",
				url:"/community/"+rid+"/like?uid="+uid,
				cache:false,
			}).done((res)=>{
				$("#thumbs-up-"+rid).addClass("bi-hand-thumbs-up");
                $("#thumbs-up-"+rid).removeClass("bi-hand-thumbs-up-fill");
			}).fail((err)=>{
				alert("error: "+err.status);
			});
		}
		
		getReviews("${sort}", ${pageId});
	};
</script>
<div class="row mt-3">
	<div class="col-12 text-center">
		<h2>리뷰 게시판</h2>
	</div>
	<div class="col-11" id="reviewTop">
		<p class="board">
			<a href="/community">리뷰 게시판</a> | <a href="/community/notice">공지사항</a>
		</p>
		<p class="sort">
			<a href="/community?sort=latest">최신순</a> | <a href="/community?sort=popular">인기순</a>
			<button class="btn btn-primary float-right" id="write" name="write"
				onclick="location.href='/community/write'">리뷰쓰기</button>
		</p>
	</div>
</div>
<div class="row mt-3" id="list"></div>
<div class="row text-center" id="pagination"></div>
