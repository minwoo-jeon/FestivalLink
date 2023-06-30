<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Festival Link</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- Favicon -->
    <!-- <link href="img/favicon.ico" rel="shortcut icon" /> -->

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
            text-decoration: none;
        }

        .nav-logo a:link {
            color: #9F3DD7;
        }

        .nav-logo a:visited {
            color: #9F3DD7;
        }

        .nav-logo a:hover {
            color: #9F3DD7;
            text-decoration: none;
        }
        .card {
    	background-color: transparent !important;
    	border: none !important;
  		}
    </style>
    <!-- Stylesheets -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/css/bootstrap.min.css"
          integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/js/bootstrap.min.js"
            integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy"
            crossorigin="anonymous"></script>
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
<!-- 지역 선택 창 -->
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
                    <!-- 필요한 지역 옵션 추가 -->
                </div>
            </div>
        </div>

        <!-- 검색 창 -->
        <div class="col-md-4 mt-5" style="margin-left: -100px">
            <form>
                <div class="input-group">
                    <input type="text" class="form-control" id="searchInput" placeholder="검색어를 입력하세요">
                    <div class="input-group-append">
                        <button class="btn btn-primary" type="button" onclick="search('')">검색</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>

<div class="row">
    <div class="col-md-12 text-center mt-3" style="margin-left: -800px;">
        <h3>축제</h3>
    </div>
</div>


<div class="row">
    <div class="col-md-12 mt-3" style="margin-left: 1905px ">
        <button class="btn btn-primary" onclick="sortByPopularity()">인기순</button>
        <button class="btn btn-primary" onclick="sortByLatest()">최신순</button>
    </div>
</div>

<!-- 카드 섹션 -->
<div class="row justify-content-center mt-2">
  <div class="col-md-2">
    <!-- 카드 1 -->
    <div class="card">
        <a href="../../../festivalsview">
      <div class="card-body">
        <!-- 여기에 카드 내용을 추가하세요 -->
        <img src="../images/1.jpg" alt="이미지_설명">
      </div>
    </div>
  </div>
  <div class="col-md-2">
    <!-- 카드 2 -->
    <div class="card">
        <a href="../../../festivalsview">
      <div class="card-body">
        <!-- 여기에 카드 내용을 추가하세요 -->
        <img src="../images/1.jpg" alt="이미지_설명">
      </div>
    </div>
  </div>
  <div class="col-md-2">
    <!-- 카드 3 -->
    <div class="card">
        <a href="../../../festivalsview">
      <div class="card-body">
        <!-- 여기에 카드 내용을 추가하세요 -->
        <img src="../images/1.jpg" alt="이미지_설명">
      </div>
    </div>
  </div>
  <div class="col-md-2">
    <!-- 카드 4 -->
    <div class="card">
        <a href="../../../festivalsview">
      <div class="card-body">
        <!-- 여기에 카드 내용을 추가하세요 -->
        <img src="../images/1.jpg" alt="이미지_설명">
      </div>
    </div>
  </div>
</div>

<!-- 선택할 수 있는 숫자 칸 -->

<!-- 선택할 수 있는 숫자 칸 -->
<div class="row justify-content-center mt-2">
    <div class="col-md-12 text-center">
        <ul class="pagination justify-content-center"> <!-- 가운데 정렬을 위해 justify-content-center 추가 -->
            
            <li class="page-item"><a class="page-link" href="#"><</a></li>
            <li class="page-item"><a class="page-link" href="#">1</a></li>
            <li class="page-item"><a class="page-link" href="#">2</a></li>
            <li class="page-item"><a class="page-link" href="#">3</a></li>
            <li class="page-item"><a class="page-link" href="#">4</a></li>
            <li class="page-item"><a class="page-link" href="#">5</a></li>
            <li class="page-item"><a class="page-link" href="#">6</a></li>
            <li class="page-item"><a class="page-link" href="#">7</a></li>
            <li class="page-item"><a class="page-link" href="#">8</a></li>
            <li class="page-item"><a class="page-link" href="#">9</a></li>
            <li class="page-item"><a class="page-link" href="#">10</a></li>
            <li class="page-item"><a class="page-link" href="#">></a></li>
            
        </ul>
    </div>
</div>


<!-- 선택된 지역을 표시하는 스크립트 -->
<script>
	const search=function(keyword){
		keyword=$('#searchInput').val()
		
		
	}
    function selectRegion(region) {
        document.getElementById('regionDropdown').innerHTML = region;
    }

    // 선택된 장르를 표시하는 스크립트
    function selectGenre(genre) {
        document.getElementById('genreDropdown').innerHTML = genre;
    }

    // 인기순으로 정렬하는 함수
    function sortByPopularity() {
        // 여기에 인기순 정렬하는 로직을 추가하세z요
    }

    // 최신순으로 정렬하는 함수
    function sortByLatest() {
        // 여기에 최신순 정렬하는 로직을 추가하세요
    }
    
    
</script>
</body>
</html>
