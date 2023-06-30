<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>

<style>
#noticeTop{
	margin: auto;
}
#noticeTop a{
	color:black;
}

p.board {
	font-size: 1.5em;
}

div.notices{
	width:90%;
	margin:auto;
}
div.notices div{
	float:left;
}
div.notices div.image{
	width:10%;
}
div.notices div.image img{
	width:100%;
}
div.notices div.title{
	width:80%;
	padding-left:10px;
}
div.notices div.title a p{
	font-size:1.5em;
}
div.notices div.etc{
	width:10%;
}
div.notices div.etc *{
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
		getNotices(${pageId});
	});
	
	const getNotices = function(pageId){
		$.ajax({
			type:"post",
			url:"/community/notice/getNotices?pageId="+pageId,
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
		let str = "";
		$.each(arr, (i, notice)=>{
			str += "<div class='bg-white rounded shadow-sm p-4 mb-5 pb-3 notices'>";
			str += "<div class='image'>";
			str += "<a href='/community/notice/"+notice.notice_id+"'>";
			str += "<img src='/community_upload/noimage.png'>";
			str += "</a>";
			str += "</div>";
			str += "<div class='title'>";
			str += "<a href='/community/notice/"+notice.notice_id+"'>";
			str += "[공지] ";
			str += notice.notice_content;
			str += "<span class='nickname'>";
			str += notice.notice_nickname;
			str += "</span>";
			str += "</a>";
			str += "</div>";
			str += "<div class='etc'>";
			str += "<p class='click' onclick='location.href=\"/community/notice/"+notice.notice_id+"/edit\"'>수정";
			str += "</p> | ";
			str += "<p class='click' onclick='delNotice(\""+notice.notice_id+"\")'>삭제";
			str += "</p><br>";
			str += notice.notice_date1+"<br>";
			str += "<span class='readnum'>";
			str += "조회수: "+notice.notice_readnum;
			str += "</span>";
			str += "</div>";
			str += "</div>";
		});
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
	
	const delNotice = function(id){
		$.ajax({
			type:"delete",
			url:"/community/notice/"+id+"/del",
			dataType:"json",
			cache:false,
		}).done((res)=>{
			if(res.result == "fail"){
				alert("공지 삭제 실패");
			}
			
			getNotices(${pageId});
		}).fail((err)=>{
			alert("error: "+err.status);
		});
	};
</script>
<div class="row mt-3">
	<div class="col-12 text-center">
		<h2>공지사항</h2>
	</div>
	<div class="col-11" id="noticeTop">
		<p class="board float-left">
			<a href="/community">리뷰 게시판</a> | <a href="/community/notice">공지사항</a>
		</p>
		<button class="btn btn-primary float-right" id="write" name="write"
				onclick="location.href='/community/notice/write'">공지쓰기</button>
	</div>
</div>
<div class="row mt-3" id="list"></div>
<div class="row text-center" id="pagination"></div>
