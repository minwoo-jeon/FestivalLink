<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<style>
    @font-face {
        font-family: 'NanumSquareNeo-Variable';
        src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_11-01@1.0/NanumSquareNeo-Variable.woff2') format('woff2');
        font-weight: normal;
        font-style: normal;
    }
    #string a{
        color:aliceblue; 
        font-family:'NanumSquareNeo-Variable';
    }
    #string a:hover{
        color: #d7d1da;
        color:aliceblue; 
        font-family:'NanumSquareNeo-Variable';
    }
    #string a:active{
        text-decoration: dashed;
    }
</style>    
<div class="container mt-4 pt-10">
        <div class="row">
            <div class="col-lg-12 card-margin">
                <div class="card search-form"style="background-color: transparent; border:0;">
                    <div class="card-body p-0">
                        <form id="search-form" style="background-color: transparent">
                            <div class="row">
                                <div class="col-12">
                                    <div class="row no-gutters" >
                                        <div class="col-lg-3 col-md-3 col-sm-12 p-0">
                                            <select class="form-control" id="locationSelect" onchange="changeLoc(this.value)" name="loc">
                                                <option value="">Location</option>
                                                <option value="1">서울</option>
                                                <option value="2">인천</option>
                                                <option value="3">대전</option>
                                                <option value="4">대구</option>
                                                <option value="5">광주</option>
                                                <option value="6">부산</option>
                                                <option value="7">울산</option>
                                                <option value="8">세종시</option>
                                                <option value="9">경기도</option>
                                                <option value="10">강원도</option>
                                                <option value="11">충청북도</option>
                                                <option value="12">충청남도</option>
                                                <option value="13">경상북도</option>
                                                <option value="14">경상남도</option>
                                                <option value="15">전라북도</option>
                                                <option value="16">전라남도</option>
                                                <option value="17">제주도</option>
                                            </select>
                                        </div>
                                        <div class="col-lg-8 col-md-6 col-sm-12 p-0">
                                            <input type="text" placeholder="Search..." class="form-control" id="keyword"
                                                name="keyword">
                                        </div>
                                        <input type="text" class="form-control" id="sort" name="sort" value="1"/>
                                        <div class="col-lg-1 col-md-3 col-sm-12 p-0">
                                            <button type="submit" class="btn btn-base" onclick="putKeyword()">
                                                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
                                                    viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                                    stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
                                                    class="feather feather-search">
                                                    <circle cx="11" cy="11" r="8"></circle>
                                                    <line x1="21" y1="21" x2="16.65" y2="16.65"></line>
                                                </svg>
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <h1 style="color:aliceblue; font-family:'NanumSquareNeo-Variable';">축제</h1>
        <div id="string" style="text-align: left;">
            <article style="text-align: left;" ><h2 ><a href="#" onclick="changeSort('1')">인기순|</a>
                <a href="#" onclick="changeSort('2')">최신순</a></h2></article>
        </div>
        <div class="row">
            <div class="col-12">
                
            </div>

        </div>
    </div>
    
    <script>
        $(()=>{
            //showList();
        })
        const showList=function(keyword, loc){
            let url = "/festivals/list"
            //if(keyword)
        };
        const changeSort=function(sortType){
            $('#sort').val(sortType);
            $('#locationSelect').val(this.val())
            $('#search-form').submit();
        }
    </script>