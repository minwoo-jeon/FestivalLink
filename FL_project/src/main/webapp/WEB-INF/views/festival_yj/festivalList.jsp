<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <style>
        @font-face {
            font-family: 'NanumSquareNeo-Variable';
            src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_11-01@1.0/NanumSquareNeo-Variable.woff2') format('woff2');
            font-weight: normal;
            font-style: normal;
        }

        #string a {
            color: aliceblue;
            font-family: 'NanumSquareNeo-Variable';
        }

        #string a:hover {
            color: #d7d1da;
            color: aliceblue;
            font-family: 'NanumSquareNeo-Variable';
        }

        #string a:active {
            text-decoration: dashed;
        }
    </style>
    <div class="container mt-4 pt-10">
        <div class="row">
            <div class="col-lg-12 card-margin">
                <div class="card search-form" style="background-color: transparent; border:0;">
                    <div class="card-body p-0">
                        <form id="searchForm" style="background-color: transparent">
                            <div class="row">
                                <div class="col-12">
                                    <div class="row no-gutters">
                                        <div class="col-lg-3 col-md-3 col-sm-12 p-0">
                                            <select class="form-control" id="locationSelect"
                                                onchange="changeLoc(this.value)" name="loc">
                                                <option value="">Location</option>
                                                <option value="서울">서울</option>
                                                <option value="인천">인천</option>
                                                <option value="대전">대전</option>
                                                <option value="대구">대구</option>
                                                <option value="광주">광주</option>
                                                <option value="부산">부산</option>
                                                <option value="울산">울산</option>
                                                <option value="세종시">세종시</option>
                                                <option value="경기도">경기도</option>
                                                <option value="강원도">강원도</option>
                                                <option value="충청북도">충청북도</option>
                                                <option value="충청남도">충청남도</option>
                                                <option value="경상북도">경상북도</option>
                                                <option value="경상남도">경상남도</option>
                                                <option value="전라북도">전라북도</option>
                                                <option value="전라남도">전라남도</option>
                                                <option value="제주도">제주도</option>
                                            </select>
                                        </div>
                                        <div class="col-lg-8 col-md-6 col-sm-12 p-0">
                                            <input type="text" placeholder="Search..." class="form-control" id="keyword"
                                                name="keyword">
                                        </div>
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
            <article style="text-align: left;">
                <h2><a href="#" id="likeSort" onclick="changeSort('1')">인기순|</a>
                    <a href="#" id="latestSort" onclick="changeSort('2')">최신순</a>
                </h2>
            </article>
        </div>
        <input id="sort" type="hidden" value="1"/>
        <div id="festivalList">

        </div>
        <div id="pagination">

        </div>

    </div>
    <input type="hidden" id="total" value="${total}">
    <script>
        $(() => {
            let loc = "";
            let key = "";
            $("#locationSelect").change(function(){
                // Value값 가져오기
                var val = $("#locationSelect :selected").val();
                if(val=="Location"){
                    val="";
                    loc="";
                }
                else{
                    loc=val;
                }
                showMain(loc,key,1);
            });
            $('#searchForm').submit(function (event) {
                event.preventDefault(); // 폼 전송 막기
                var val = $("#locationSelect :selected").val();
                loc=val;
                key = $('#keyword').val();
                // 키워드를 이용해 검색 기능 구현
                showMain(loc,key,1);
            });
            showMain(loc, key,1);
        })
        const showMain = function (loc, key,page) {
            //alert("showMain")
            let url = "/festivals/list?loc=" + loc + "&keyword=" + key+"&page="+page;
            //alert(url)
            $.ajax({
                type: 'get',
                url: url,
                dataType: 'json',
                cache: false
            }).done((res) => {
                showList(res, loc, key);


            }).fail((err) => {
                console.log(err.status);
            });
            //if(keyword)
        };
        const showList = function (res, loc, key) {
            //alert(res);
            let str = '';
            let total = $('#total').val();
            total = Number(total);
            //alert("total ="+total)
            let sort = $('#sort').val();
            if(sort=='2'){
                res.sort((a,b)=>{
                    if(new Date(a.festival_start)<new Date(b.festival_start)) return 1;
                    if(new Date(a.festival_start)>new Date(b.festival_start)) return -1;
                })
            }
            if (total == "0") {
                str += `<div class="pt-4 pb-4">
                <p>
                <h2>검색 결과가 없습니다.</h2>
                </p>
                </div>`;
            } else {
                str+=`<div class="row">`;
                $.each(res, function (i, festival) {
                    str+=`<div class="card m-2" style="width: 250px; height: 480px;">
                        <img src="`+festival.festival_image+`}" />
                        <div class="card-body">
                            <h5 class="card-title"><a href="/festivals/`+festival.festival_id+`">`+festival.festival_name+`</a>
                            </h5>
                            <span>`+festival.festival_place+`</span> | <span>`+festival.festival_start+` ~
                                `+festival.festival_end+`</span>
                        </div>
                    </div>`;
                })
            }
            $('#festivalList').html(str);
            //alert(total);
            let totalP = Number(Math.floor((total - 1) / 17) + 1);
            let str1 = '<nav aria-label="Page navigation example"><ul class="pagination">';
            for (var j = 0; j < totalP; j++) {
                    str1 += '<li class="page-item">';
                    if(loc==""&&key==""){
                        str1 += `<a class="page-link" href="javascript:showMain( '' ,'',` + (j + 1) + `)">`;
                    }else if(loc==""&&key!=""){
                        str1 += `<a class="page-link" href="javascript:showMain('',` + key + `,` + (j + 1) + `)">`;
                    }else if(loc!=""&&key==""){
                        str1 += `<a class="page-link" href="javascript:showMain(` + loc + `,'',` + (j + 1) + `)">`;
                    }else{
                        str1 += '<a class="page-link" href="javascript:showMain(' + loc + ',' + key + ',' + (j + 1) + ')">';
                    }
                    str1 += j + 1;
                    str1 += '</a>';
                    str1 += '</li>';
            }
                str1 += '</ul></nav>';
            $('#pagination').html(str1);

        }
        const changeSort = function (sortType) {
            if (sortType == '1') {
                $('#likeSort').css('text-decoration', 'underline');
                $('#latestSort').css('text-decoration', 'none');
                $('#sort').val("1");
            } else if (sortType == '2') {
                $('#latestSort').css('text-decoration', 'underline');
                $('#likeSort').css('text-decoration', 'none');
                $('#sort').val("2");
            }

        }
    </script>