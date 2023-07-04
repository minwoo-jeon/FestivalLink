<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Festival Link</title>
<meta charset="UTF-8">
<meta name="description" content="">
<meta name="keywords" content="">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<!-- Favicon -->
<!-- <link href="img/favicon.ico" rel="shortcut icon" /> -->

<!-- Google Fonts -->
<link
	href="https://fonts.googleapis.com/css?family=Roboto:400,400i,500,500i,700,700i"
	rel="stylesheet">
<!-- jQuery library -->
<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.4/dist/jquery.min.js"></script>
<!-- Popper JS -->
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<style>
body{
    background: #4568DC;  /* fallback for old browsers */
	background: -webkit-linear-gradient(to top, #B06AB3, #4568DC);  /* Chrome 10-25, Safari 5.1-6 */
	background: linear-gradient(to top, #B06AB3, #4568DC); /* W3C, IE 10+/ Edge, Firefox 16+, Chrome 26+, Opera 12+, Safari 7+ */

    }
.main-menu {
	float: right;
	margin-right: 170px;
}

.main-menu ul {
	list-style: none;
}

.main-menu ul li {
	display: inline;
}

.main-menu ul li a {
	display: inline-block;
	font-size: 16px;
	color: #fff;
	margin-left: 35px;
	font-weight: 500;
	padding: 10px 5px;
}

.main-menu ul li a:hover {
	color: #9F3DD7;
}
.header-section {
	background: #131313;
	clear: both;
	overflow: hidden;
	padding: 10px 0;
	border-bottom: 1px solid #9F3DD7;
}

.site-logo {
	display: inline-block;
	float: left;
	padding-top: 6px;
}

.user-panel {
	float: right;
	font-weight: 500;
	background: #9F3DD7;
	padding: 8px 28px;
	border-radius: 30px;
}

.user-panel a {
	font-size: 14px;
	color: #131313;
}
.user-panel a:hover{
	color:#ffffff;
}
.nav-logo a {
  text-decoration-line: none;
}
.nav-logo a:link {
  color : #9F3DD7;
}
.nav-logo a:visited { 
 color : #9F3DD7; 
 }
.nav-logo a:hover { 
	color:#9F3DD7; 
	text-decoration-line: none;
}

</style>
<!-- Stylesheets -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
<!--[if lt IE 9]>
	  <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
	  <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
	<![endif]-->
</head>

<body>
	<!-- Page Preloder -->
	<div id="preloder">
		<div class="loader"></div>
	</div>
</header>
<!-- Festival Name and Button -->
<div style="text-align: center; padding: 10px;">
   <div class="container">
       <div style="display: flex; justify-content: center; align-items: center;">
           <h2 style="color:  #FFFFFF; margin-bottom: -300px;">리뷰 쓰기</h2>
       </div>    
   </div>
 
   <div style="text-align: center; padding: 10px;">
       <div class="container">
           <div style="display: flex; justify-content: center; align-items: center; margin-left: -700px; margin-top: 200px">
               <h2 style="color:  #FFFFFF; margin-bottom: -300px;">축제명</h2>
           </div>    
       </div>
       <div style="display: flex; justify-content: center; align-items: center; margin-top: 135px; margin-left: -265px">
           <input type="text" id="festivalName" placeholder="" style="padding: 5px; margin-right: 10px;">
           <button onclick="searchFestival()" style="padding: 5px 15px; background-color: #9F3DD7; color: #FFFFFF; border: none; border-radius: 5px; cursor: pointer;">검색</button>
       </div>
   </div>
 
   <div style="text-align: center; padding: 10px;">
       <div class="container">
           <div style="display: flex; justify-content: center; align-items: center; margin-left: -700px; margin-top: -100px">
               <h2 style="color:  #FFFFFF; margin-bottom: -300px;">글내용</h2>
           </div>   
           <textarea id="content" rows="8" cols="50" placeholder="내용을 입력해주세요." style="padding: 5px; margin-left:-130px; margin-top: 130px"></textarea> 
       </div>
       <div style="display: flex; justify-content: center; align-items: center; margin-left: -700px; margin-top: -100px">
           <h2 style="color:  #FFFFFF; margin-bottom: -300px;">이미지<br>업로드</h2>
       </div>
       <div style="display: flex; justify-content: center; align-items: center; margin-top: 135px; margin-left: -265px">
              <form action="/upload" method="post" enctype="multipart/form-data">
    <input type="file" name="file">
       </div>  
       <button onclick="submitReview()" style="padding: 5px 15px; background-color: #9F3DD7; color: #FFFFFF; border: none; border-radius: 5px; cursor: pointer; margin-left: -110px; margin-top: 100px">작성</button>
       <button onclick="cancelReview()" style="padding: 5px 15px; background-color: #9F3DD7; color: #FFFFFF; border: none; border-radius: 5px; cursor: pointer; margin-left: 10px; margin-top: 100px">취소</button>
   </div>  
</div>



