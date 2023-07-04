<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.List" %>
<%@ page import="com.project.domain.SearchVO" %>
<%@ page import="com.project.mapper.SearchMapper"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Festival Link</title>
    <meta charset="UTF-8">
    <meta name="description" content="">
    <meta name="keywords" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	  <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css?family=Roboto:400,400i,500,500i,700,700i" rel="stylesheet">
    <!-- jQuery library -->
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.4/dist/jquery.min.js"></script>
    <!-- Popper JS -->
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <style>
        body {
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

        .user-panel a:hover {
            color: #ffffff;
        }

        .nav-logo a {
            text-decoration-line: none;
        }

        .nav-logo a:link {
            color: #9F3DD7;
        }

        .nav-logo a:visited {
            color: #9F3DD7;
        }

        .nav-logo a:hover {
            color: #9F3DD7;
            text-decoration-line: none;
        }

        .search-results {
            margin-top: 50px;
            text-align: center;
            color: #000000;
            font-size: 24px;
        }
        .table {
        text-align: center;
   		 }
    	.table th, .table td {
        text-align: center;
   		 }
    	</style>
    <script>
        function search() {
            var searchInput = document.getElementById("searchInput");
            var keyword = searchInput.value.trim(); // Get the entered keyword
            if (keyword !== "") {
                window.location.href = "search.jsp?keyword=" + encodeURIComponent(keyword);
            }
        }
    </script>
    <!-- Stylesheets -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/css/bootstrap.min.css"
          integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO"
          crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/js/bootstrap.min.js"
            integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy"
            crossorigin="anonymous"></script>
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>

<body>
<!-- Region Selection -->
<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-4 mt-5" style="text-align: center;">
            <div class="dropdown">
                <button class="dropdown-toggle btn btn-primary" type="button" id="regionDropdown"
                        data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    지역선택
                </button>
                <div class="dropdown-menu" aria-labelledby="regionDropdown">
                    <a class="dropdown-item" href="#" onclick="selectRegion('지역1')">지역1</a>
                    <a class="dropdown-item" href="#" onclick="selectRegion('지역2')">지역2</a>
                    <a class="dropdown-item" href="#" onclick="selectRegion('지역3')">지역3</a>
                    <!-- Add necessary region options -->
                </div>
            </div>
        </div>

         <div class="col-md-4 mt-5" style="margin-left: -100px">
    <form action="search" method="POST">
        <div class="input-group">
            <input type="text" class="form-control" name="keyword" id="searchInput" placeholder="검색어를 입력하세요">
            <div class="input-group-append">
                <button class="btn btn-primary" type="submit">검색</button>
            </div>
        </div>
    </form>
</div>
    </div>
</div>

<!-- Search Results Table -->
<div style="margin-top: 100px;">
  <table class="table">
    <thead>
      <tr>
      	<th>사진</th>
        <th>축제명</th>
        <th>글내용</th>
        <th>시작일</th>
        <th>종료일</th>
        <th>주소</th>
        <th>홈페이지</th>
        <th>USER_ID</th>
        <th>NO</th>
      </tr>
  <tr>
    </thead>
    <tbody>
  
<c:forEach var="vo" items="${ searchList}">
    <tr>
      <td></td>
      <td>${ vo.getFESTIVAL_NAME()  }</td>
      <td>${ vo.getFESTIVAL_CONTENTS() }</td>
      <td>${ vo.getFESTIVAL_START() }</td>
      <td>${ vo.getFESTIVAL_END() }</td>
      <td>${ vo.getFESTIVAL_ADDR() }</td>
      <td>${ vo.getFESTIVAL_HOMEPAGE() }</td>
      <td></td>
      <td></td>
    </tr>
</c:forEach>
</tbody>
    </table>
</div>
</body>
</html>
