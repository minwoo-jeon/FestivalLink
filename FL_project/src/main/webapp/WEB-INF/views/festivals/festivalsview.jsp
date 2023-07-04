<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
<!-- Festival Name and Button -->
<div style="text-align: center; padding: 10px;">
   <div class="container">
       <div style="display: flex; justify-content: space-between; align-items: center;">
           <h2 style="color: #9F3DD7; margin-left: -55px; margin-bottom: -100px">축제명</h2>
           <p style="color: #ffffff; margin-left: -450px; margin-bottom: -250px">축제 기간:</p>
           <div>
               <button class="p-1 rounded-md hover:bg-gray-100 hover:text-gray-700 dark:text-gray-400 dark:hover:bg-gray-700 dark:hover:text-gray-200" style="margin-top: 150px;">
                   <svg stroke="currentColor" fill="none" stroke-width="2" viewBox="0 0 24 24" stroke-linecap="round" stroke-linejoin="round" class="h-4 w-4" height="1em" width="1em" xmlns="http://www.w3.org/2000/svg">
                       <path d="M14 9V5a3 3 0 0 0-3-3l-4 9v11h11.28a2 2 0 0 0 2-1.7l1.38-9a2 2 0 0 0-2-2.3zM7 22H4a2 2 0 0 1-2-2v-7a2 2 0 0 1 2-2h3"></path>
                   </svg>
               </button>
           </div>
       </div>

       <!-- Image Box -->
       <div style="margin-top: 20px; margin-left: -900px">
           <img src="../images/1.jpg" alt="Festival Image" style="max-width: 100%; height: auto;">
       </div>
         <p style="color: #ffffff; margin-left: -435px;margin-top:-475px; margin-bottom:-250px">축제 내용:</p>
         <div style="margin-left: -435px; margin-top: 270px;">
           <p style="color: #ffffff;">주관 기관:</p>
           <!-- Add the necessary HTML code for the organizer section here -->
       </div>
       <div style="margin-left: -435px; margin-top: 20px;">
           <p style="color: #ffffff;">주최 기관:</p>
           <div style="display: inline-block; background-color: #ffffff; padding: 10px 20px; border-radius: 5px;">
               <a href="https://www.example.com" target="_blank" style="color: #000000; text-decoration: none;">홈페이지</a>
           </div>
       </div>
       
       <!-- Map API Box -->
<div style="margin-top: 300px; margin-left: -900px;">
   <div id="map" style="width: 100%; height: 400px;">지도 API삽입 예정</div>
</div>

<div style="margin-left:-1170px; margin-top: -180px;">
    <p style="color: #ffffff;">리뷰 (개수)</p>
</div>
<!-- Write Review Button -->
<div style="margin-right: -1000px; margin-top: -55px;">
    <a href="../../../Review" class="btn btn-primary">리뷰 작성하기</a>
</div>

</html>
</body>
     