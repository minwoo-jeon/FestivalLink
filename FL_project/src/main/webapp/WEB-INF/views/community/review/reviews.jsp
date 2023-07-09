<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>

<style>
@font-face {
    font-family: 'NanumSquareNeo-Variable';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_11-01@1.0/NanumSquareNeo-Variable.woff2') format('woff2');
    font-weight: normal;
    font-style: normal;
}

#reviewTop h1{
	color: aliceblue;
    font-family: 'NanumSquareNeo-Variable';
}

p.board {
	font-size: 2rem;
}
p.sort{
	font-size: 2rem;
}
p.board, p.board a, p.sort, p.sort a{
    color: aliceblue;
    font-family: 'NanumSquareNeo-Variable';
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
	width:70%;
	padding-left:10px;
}
div.reviews div.etc{
	width:10%;
}
div.reviews div.etc *{
	display:inline-block;
}
div.reviews div.etc2{
	width:10%;
}
div.reviews div.etc2 *{
	display:inline-block;
}

span.nickname, span.readnum{
	color: gray;
}

p.click{
	color:gray;
	cursor:pointer;
}

p.sort a:active {
	text-decoration: dashed;
}
</style>

<c:if test="${user ne null}">
	<input type="hidden" id="userId" value="${userId}">
</c:if>
<c:if test="${user eq null}">
	<input type="hidden" id="userId" value="0">
</c:if>

<script>
	$(function(){	
		let userId = $("#userId").val();
		getReviews("${sort}", ${pageId}, userId);
	});
	
	const getReviews = function(sort, pageId, userId){
		$.ajax({
			type:"post",
			url:"/community/getReviews?sort="+sort+"&pageId="+pageId,
			dataType:"json",
			cache:false,
		}).done((res)=>{
			showList(res.items, userId);
			showPage(res.pageNavi, res.totalCount, res.pageId, res.pageCount);
		}).fail((err)=>{
			alert("error: "+err.status);
		});
	};
	
	const showList = function(arr, userId){
		//let str = "<ul class='reviewList'>";
		let str = "";
		if(arr.length == 0){
			str += "<div class='col-12 text-center'>";
			str += "<h2>리뷰가 없습니다</h2>";
			str += "</div>";
		}
		else{
			$.each(arr, (i, review)=>{
				str += "<div class='col-12 bg-white rounded shadow-sm p-3 mb-3 pb-3 reviews'>";
				//str += "<li>";
				str += "<div class='image'>";
				str += "<a href='/community/"+review.review_id+"'>";
				str += "<img src='"+review.review_image+"'>";
				str += "</a>";
				str += "</div>";
				//str += "</li>";
				//str += "<li>";
				str += "<div class='title'>";
				str += "<a href='/community/"+review.review_id+"'>";
				str += "<h4>";
				str += review.review_content;
				str += "</h4>";
				str += "<span class='nickname'>";
				str += review.review_nickname;
				str += "</span>";
				str += "</a>";
				str += "</div>";
				//str += "</li>";
				//str += "<li>";
				str += "<div class='etc'>";
				str += "<c:if test='${user ne null}'>";
				if(userId == review.user_id_fk){
					str += "<c:if test='${user.state ne 2}'>";
					str += "<p class='click' onclick='location.href=\"/community/"+review.review_id+"/edit\"'>수정";
					str += "</p> | ";
					str += "<p class='click' onclick='delReview(\""+review.review_id+"\")'>삭제";
					str += "</p><br>";
					str += "</c:if>";
				}
				else{
					str += "<c:if test='${user.state eq 3 and user.state ne 2}'>";
					str += "<p class='click' onclick='location.href=\"/community/"+review.review_id+"/edit\"'>수정";
					str += "</p> | ";
					str += "<p class='click' onclick='delReview(\""+review.review_id+"\")'>삭제";
					str += "</p><br>";
					str += "</c:if>";
				}
				str += "</c:if>";
				str += review.review_date1+"<br>";
				str += "<span class='readnum'>";
				str += "조회수: "+review.review_readnum;
				str += "</span>";
				str += "</div>";
				str += "<div class='etc2'>";
				str += "<c:if test='${user ne null and user.state ne 2}'>";
				str += "<button onclick='pushLikeRe(\""+review.review_id+"\", \""+review.user_id_fk+"\")' class='btn btn-outline-primary btn-sm mb-3' style='margin-top:10px;'>좋아요 ";
				str += "<b id='like_count-"+review.review_id+"'>"+review.likes+"</b>";
				str += "<i class='bi bi-hand-thumbs-up' id='thumbs-up-"+review.review_id+"'></i>";	
				str += "</button><br>";
				str += "<button class='btn btn-outline-warning btn-sm' onclick='location.href=\"/community/"+review.review_id+"/report\"'>신고하기";
				str += "<i class='bi bi-flag-fill'></i>";
				str += "</button>";
				str += "</c:if>";
				if(userId=='0'){
					str += `<button onclick='alert("로그인해주세요")' class='btn btn-outline-primary btn-sm mb-3' style='margin-top:10px;'>좋아요 `;
					str += "<b id='like_count-"+review.review_id+"'>"+review.likes+"</b>";
					str += "<i class='bi bi-hand-thumbs-up' id='thumbs-up-"+review.review_id+"'></i>";	
					str += "</button><br>";
					str += `<button class='btn btn-outline-warning btn-sm' onclick='alert("로그인해주세요")'>신고하기<i class='bi bi-flag-fill'></i></button>`;
				}
				str += "</div>";
				//str += "</li>";
				str += "</div>";
				
				if(userId != '0') {
					reviewLikeCheck(review.review_id);
				}
			});
		}
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
			url:"/community/"+id,
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
	
	
	
	const reviewLikeCheck = function(reviewId){
	    $.ajax({
	        type: 'get',
	        url: '/users/like/review?reviewId=' + reviewId,
	        dataType: 'json',
	        success: function (res) {
	            if (res == 1) {
	                $("#thumbs-up-" + reviewId).removeClass("bi-hand-thumbs-up");
	                $("#thumbs-up-" + reviewId).addClass("bi-hand-thumbs-up-fill");
	            }
	        },
	        error: function (err) {
	            console.log(err.status);
	        }
	    });
	};
	
	const pushLikeRe = function(reviewId, userId){
	    if (userId == '0') {
	        alert('로그인하세요');
	        return;
	    }
	    else {
	        if (!$("#thumbs-up-" + reviewId).hasClass("bi-hand-thumbs-up-fill")) {
	            $.ajax({
	                type: 'post',
	                url: '/users/like?reviewId=' + reviewId,
	                dataType: 'json',
	                success: function (res) {
	                    $("#thumbs-up-" + reviewId).removeClass("bi-hand-thumbs-up");
	                    $("#thumbs-up-" + reviewId).addClass("bi-hand-thumbs-up-fill");
	
	                    let likeCountStr = $(`#like_count-` + reviewId).text();
	                    let likeCount = Number(likeCountStr) + 1;
	                    $(`#like_count-` + reviewId).text(likeCount);
	                },
	                error: function (err) {
	                    console.log(err.status);
	                }
	            });
	        } else {
	            $.ajax({
	                type: 'delete',
	                url: '/users/like?reviewId=' + reviewId,
	                dataType: 'json',
	                success: function (res) {
	                    $("#thumbs-up-" + reviewId).removeClass("bi-hand-thumbs-up-fill");
	                    $("#thumbs-up-" + reviewId).addClass("bi-hand-thumbs-up");
	                    let likeCountStr = $(`#like_count-` + reviewId).text();
	                    let likeCount = Number(likeCountStr) - 1;
	                    $(`#like_count-` + reviewId).text(likeCount);
	                },
	                error: function (err) {
	                    console.log(err.status);
	                }
	            });
	        }
	    }
	};
	
	const changeSort = function(sort){
		if(sort == "latest"){
			$("#latest1").css("text-decoration", "underline");
			$("#sort1").val("latest");
			alert($("#sort1").val());
		}
		else if(sort == "popular"){
			$("#popular").css("text-decoration", "underline");
			$("#sort1").val("popular");
			alert($('#sort1').val());
		}
	};
</script>

<div class="container">
	<div class="row mt-3">
		<div id="reviewTop" class="col-12 text-center">
			<h1>리뷰</h1>
		</div>
		<div class="col-12" id="reviewMenu">
			<p class="board">
				<a href="/community">리뷰</a> | <a href="/community/notice">공지사항</a>
			</p>
		</div>
		<div class="col-12" id="reviewMenu1">
			<input id="sort1" type="hidden" value="">
			<p class="sort float-left">
				<a id="latest1" onclick="changeSort('latest')" href="/community?sort=latest">최신순</a> | <a id="popular" onclick="changeSort('popular')" href="/community?sort=popular">인기순</a>
			</p>
			<c:if test="${user ne null and user.state ne 2}">
				<button class="btn btn-primary float-right" id="write" name="write"
					onclick="location.href='/community/write'">리뷰쓰기</button>
			</c:if>
		</div>
	</div>
	<div class="row" id="list"></div>
	<div class="row">
		<div class="col-12 text-center" id="pagination"></div>
	</div>
</div>
