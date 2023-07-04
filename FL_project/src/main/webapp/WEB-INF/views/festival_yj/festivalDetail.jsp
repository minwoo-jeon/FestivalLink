<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@include file="festivalDetailKakaoMap.jsp" %>
        <section class="h-100 gradient-custom">
            <div class="container py-5 h-100">
                <div class="bg-light row">
                    <div class="col-lg-12 mb-4 mb-sm-5">
                        <div class="card card-style1 border-0">
                            <div class="card-body p-1-9 p-sm-2-3 p-md-6 p-lg-7">
                                <div class="row align-items-center">
                                    <div class="col-lg-3 mb-4 mb-lg-0">
                                        <!-- -----축제이미지 나중에 링크 잘넣어서 수정  -->
                                        <img class="img-fluid"
                                            src="${festivalInfo.festival_image}"
                                            alt="Card image cap" />
                                    </div>
                                    <div class="col-lg-9 px-xl-10">
                                        <div
                                            class="bg-secondary d-lg-inline-block py-1-9 px-1-9 px-sm-6 mb-1-9 rounded">
                                            <h3 class="h2 text-white mb-0">${festivalInfo.festival_name}</h3>
                                            <span class="text-light">${festivalInfo.festival_start} ~
                                                ${festivalInfo.festival_end}</span>
                                        </div>
                                        <c:if test="${user eq null}">
                                            <button onclick="alert('로그인 하세요')"
                                                class="btn btn-outline-primary btn-lg float-right">좋아요
                                                ${festivalInfo.f_like}
                                                <i class="bi bi-hand-thumbs-up" id="thumbs-up-f"></i>
                                            </button>
                                        </c:if>
                                        <c:if test="${user ne null}">
                                            <button onclick="pushFLike('${festivalInfo.festival_id}')"
                                                class="btn btn-outline-primary btn-lg float-right">좋아요
                                                <b id="like_count-f">${festivalInfo.f_like}</b>
                                                <i class="bi bi-hand-thumbs-up" id="thumbs-up-f"></i>
                                            </button>
                                        </c:if>

                                        <ul class="list-unstyled mb-1-9">
                                            <li class="mb-2 mb-xl-3 display-28"><span
                                                    class="display-26 text-secondary me-2 font-weight-600">축제 지역
                                                    :</span>
                                                ${festivalInfo.festival_place}</li>
                                            <li class="mb-2 mb-xl-3 display-28"><span
                                                    class="display-26 text-secondary me-2 font-weight-600">주관 기관 :
                                                </span>
                                                ${festivalInfo.festival_host}</li>
                                            <li class="mb-2 mb-xl-3 display-28"><span
                                                    class="display-26 text-secondary me-2 font-weight-600">축제 주소 :
                                                </span>
                                                ${festivalInfo.festival_addr}</li>
                                            <li class="mb-2 mb-xl-3 display-28"><span
                                                    class="display-26 text-secondary me-2 font-weight-600">홈페이지
                                                    :</span><a
                                                    href="${festivalInfo.festival_homepage}">${festivalInfo.festival_homepage}</a>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-12 mb-4 mb-sm-5">
                        <div>
                            <span class="section-title text-primary mb-3 mb-sm-4">
                                <h3>축제 내용</h3>
                            </span>
                            <p>${festivalInfo.festival_contents}</p>
                        </div>
                    </div>
                    <div class="col-lg-12">
                        <div class="row">
                            <div class="col-lg-12 mb-4 mb-sm-5">
                                <div class="container">
                                    <span class="section-title text-primary mb-3">
                                        <h3>지도</h3>
                                    </span>
                                    <!-- 지도 -->
                                    <div class="container">
                                        <section class="mx-auto" style="max-width: 20rem;">

                                            <div id="map" style="width:500px;height:400px;"></div>
                                        </section>
                                    </div>
                                    <!-- 지도 끝 -->
                                    <!-- 리뷰 -->
                                    <div class="container">
                                        <span class="section-title text-primary mb-3 mb-sm-4">
                                            <h3>리뷰</h3>
                                        </span>
                                        <br><br>
                                        <div id="Review">

                                        </div>

                                        <div id="pagination">

                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <input type="hidden" id="total" value="${total}">
        <input type="hidden" id="lat" value="${festivalInfo.festival_latitude}">
        <input type="hidden" id="lng" value="${festivalInfo.festival_longitude}">
        <input type="hidden" name="festivalId" id="festivalId" value="${festivalInfo.festival_id}">
        <c:if test="${user ne null}">
            <input type="hidden" id="userId" value="${userId}">
        </c:if>
        <c:if test="${user eq null}">
            <input type="hidden" id="userId" value="0">
        </c:if>
        <script>
            $(() => {

                let userId = $("#userId").val();
                var lat = $("#lat").val();
                var lng = $("#lng").val();
                var festivalId = $('#festivalId').val();
                var container = document.getElementById('map'); //지도 표시 div
                var options = {
                    center: new kakao.maps.LatLng(lat, lng), //지도의 중심좌표
                    level: 3 //지도의 확대 레벨
                };

                var map = new kakao.maps.Map(container, options);

                // 마커가 표시될 위치
                var markerPosition = new kakao.maps.LatLng(lat, lng);

                // 마커 생성
                var marker = new kakao.maps.Marker({
                    position: markerPosition
                });

                // 마커가 지도 위에 표시되도록 설정
                marker.setMap(map);
                likeFestival(festivalId);

                getReviewByFId(festivalId, 1, userId);
            });

            function likeFestival(festivalId) {


                $.ajax({
                    type: 'get',
                    url: '/users/like/festival/' + festivalId,
                    dataType: 'json',
                    success: function (res) {
                        //alert(res);
                        //alert(JSON.stringify(res))
                        if (res == 1) {
                            $("#thumbs-up-f").removeClass("bi-hand-thumbs-up");
                            $("#thumbs-up-f").addClass("bi-hand-thumbs-up-fill");
                        }

                    },
                    error: function (err) {
                        console.log(err.status);
                    }
                })
            };
            const pushFLike = function (festivalId) {
                if (!$("#thumbs-up-f").hasClass("bi-hand-thumbs-up-fill")) {
                    //alert("pushLike2");
                    $.ajax({
                        type: 'post',
                        url: '/users/like/festival/' + festivalId,
                        dataType: 'json',
                        success: function (res) {
                            //alert(res);
                            //alert(JSON.stringify(res))
                            $("#thumbs-up-f").removeClass("bi-hand-thumbs-up");
                            $("#thumbs-up-f").addClass("bi-hand-thumbs-up-fill");

                            let likeCountStr = $("#like_count-f").text();
                            let likeCount = Number(likeCountStr) + 1;
                            $("#like_count-f").text(likeCount);
                            //alert(likeCount);

                        },
                        error: function (err) {
                            console.log(err.status);
                        }
                    })

                } else {
                    //alert("pushLike3");
                    $.ajax({
                        type: 'delete',
                        url: '/users/like/festival/' + festivalId,
                        dataType: 'json',
                        success: function (res) {
                            //alert(JSON.stringify(res))
                            $("#thumbs-up-f").removeClass("bi-hand-thumbs-up-fill");
                            $("#thumbs-up-f").addClass("bi-hand-thumbs-up");
                            let likeCountStr = $(`#like_count-f`).text();
                            let likeCount = Number(likeCountStr) - 1;
                            $(`#like_count-f`).text(likeCount);

                        },
                        error: function (err) {
                            console.log(err.status);
                        }
                    })
                }
            };
            function getReviewByFId(festivalId, page, userId) {
                //alert('getReviewByFId');
                let url = '/festivals/review/' + festivalId + "/" + page;
                $.ajax({
                    type: 'get',
                    url: url,
                    dataType: 'json',
                    cache: false
                }).done((res) => {
                    //alert(JSON.stringify(res))
                    showList(res, userId, festivalId);


                }).fail((err) => {
                    console.log(err.status);
                });
            };

            function showList(items, userId, festivalId) {

                let str = '';
                $.each(items, function (i, review) {

                    str += `<div class="bg-white rounded shadow-sm p-4 mb-5 pb-3 reviews">`;

                    if (userId != '0' && userId == review.user_id_fk) {
                        str += `<a href="#">수정</a>|<a href="#">삭제</a>`;
                    }
                    str += `<button onclick="pushLikeRe('` + review.review_id + `','` + userId + `');" class="btn btn-outline-primary btn-sm float-right">좋아요`;
                    str += `<b id="like_count-` + review.review_id + `">` + review.r_like + `</b>`;
                    str += `<i class="bi bi-hand-thumbs-up" id="thumbs-up-r-` + review.review_id + `"></i>`;
                    str += `</button>`;
                    str += `<h5 class="mb-1">` + review.festival_name + `</h5>`;
                    str += `<div class="pt-4 pb-4">`;
                    str += `<div class="media">`;
                    str += `<a href="#"><img alt="Generic placeholder image"`;
                    str += `src="http://bootdey.com/img/Content/avatar/avatar1.png"';'`;
                    str += `class="mr-2 rounded-pill"></a>`;
                    str += `<div class="media-body">`;
                    str += `<div class="reviews-members-header">`;
                    str += `<h6 class="mb-1"><a class="text-black" href="#">` + review.review_nickname + `</a></h6>`;
                    str += `<p class="text-gray">` + review.review_date + ` </p>`;
                    str += `</div>`;
                    str += `<div class="reviews-members-body">`;
                    str += `<p>` + review.review_content + `</p>`;
                    str += `</div>`;
                    str += `</div>`;
                    str += `</div>`;
                    str += `</div>`;
                    str += `</div>`;

                });
                $('#Review').html(str);
                if (userId != '0') {
                    $.each(items, function (i, review) {
                        reviewLikeCheck(review.review_id, userId);
                    });
                }

                var total = $('#total').val();
                total = Number(total);
                let totalP = Number(Math.floor((total - 1) / 3) + 1);
                let str1 = '<nav aria-label="Page navigation example"><ul class="pagination">';


                for (var j = 0; j < totalP; j++) {
                    str1 += '<li class="page-item">';
                    str1 += '<a class="page-link" href="javascript:getReviewByFId(' + festivalId + ',' + (j + 1) + ',' + userId + ')">';
                    str1 += j + 1;
                    str1 += '</a>';
                    str1 += '</li>';
                }
                str1 += '</ul></nav>';
                $('#pagination').html(str1);
            };
            const reviewLikeCheck = function (reviewId, userId) {
                //alert('reviewLikeCheckAlert');
                $.ajax({
                    type: 'get',
                    url: '/users/like/review?reviewId=' + reviewId,
                    dataType: 'json',
                    success: function (res) {
                        //alert('reviewLikeCheckAlert2');
                        //alert(res);
                        //alert(JSON.stringify(res))
                        if (res == 1) {
                            $("#thumbs-up-r-" + reviewId).removeClass("bi-hand-thumbs-up");
                            $("#thumbs-up-r-" + reviewId).addClass("bi-hand-thumbs-up-fill");
                        }

                    },
                    error: function (err) {
                        console.log(err.status);
                    }
                })
            }
            const pushLikeRe = function (reviewId, userId) {
                //alert(reviewId+"|"+userId);
                if (userId == '0') {
                    alert('로그인하세요');
                    return;
                }
                else {
                    if (!$("#thumbs-up-r-" + reviewId).hasClass("bi-hand-thumbs-up-fill")) {
                        //alert("pushLike2");
                        $.ajax({
                            type: 'post',
                            url: '/users/like?reviewId=' + reviewId,
                            dataType: 'json',
                            success: function (res) {
                                //alert(res);
                                //alert(JSON.stringify(res))
                                $("#thumbs-up-r-" + reviewId).removeClass("bi-hand-thumbs-up");
                                $("#thumbs-up-r-" + reviewId).addClass("bi-hand-thumbs-up-fill");

                                let likeCountStr = $(`#like_count-` + reviewId).text();
                                let likeCount = Number(likeCountStr) + 1;
                                $(`#like_count-` + reviewId).text(likeCount);


                            },
                            error: function (err) {
                                console.log(err.status);
                            }
                        })

                    } else {
                        //alert("pushLike3");
                        $.ajax({
                            type: 'delete',
                            url: '/users/like?reviewId=' + reviewId,
                            dataType: 'json',
                            success: function (res) {
                                //alert(JSON.stringify(res))
                                $("#thumbs-up-r-" + reviewId).removeClass("bi-hand-thumbs-up-fill");
                                $("#thumbs-up-r-" + reviewId).addClass("bi-hand-thumbs-up");
                                let likeCountStr = $(`#like_count-` + reviewId).text();
                                let likeCount = Number(likeCountStr) - 1;
                                $(`#like_count-` + reviewId).text(likeCount);

                            },
                            error: function (err) {
                                console.log(err.status);
                            }
                        })
                    }
                }

            }
        </script>