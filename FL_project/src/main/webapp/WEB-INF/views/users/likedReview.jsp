<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<style>
    @font-face {
        font-family: 'NanumSquareNeo-Variable';
        src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_11-01@1.0/NanumSquareNeo-Variable.woff2') format('woff2');
        font-weight: normal;
        font-style: normal;
    }
    </style>    
<section class="h-100 gradient-custom">
        <div class="container py-5 h-100">
            <h1 style="color: white; font-family: 'NanumSquareNeo-Variable';">내가 좋아요 한 리뷰</h1>
            <c:if test="${likedReviewArr eq null or empty likedReviewArr}">
                <div class="bg-white rounded shadow-sm p-4 mb-4 reviews">

                    <!-- https://icons.getbootstrap.kr/ : thums-up fill 있음  -->

                    <div class="pt-4 pb-4">

                        <p>
                        <h2>아직 내가 좋아요 한 리뷰가 없습니다.</h2>
                        </p>
                    </div>

                </div>
            </c:if>
            <c:if test="${likedReviewArr ne null and not empty likedReviewArr}">
                <c:forEach var="vo" items="${likedReviewArr}">
                    
                    <div class="bg-white rounded shadow-sm p-4 mb-5 pb-3 reviews">
                        <input type="hidden" value="L" class="state">
                        <a href="#">수정</a>|<a href="#">삭제</a>
                        <button onclick="pushLike('${vo.review_id}','${vo.likeState}')" class="btn btn-outline-primary btn-sm float-right">좋아요
                            <b id="like_count-${vo.review_id}">${vo.r_like}</b>
                            <c:choose>
								<c:when test="${vo.likeState eq 1}">
                                    <i class="bi bi-hand-thumbs-up-fill" id="thumbs-up-${vo.review_id}"></i>
								</c:when>
								<c:otherwise>
                                    <i class="bi bi-hand-thumbs-up" id="thumbs-up-${vo.review_id}"></i>
								</c:otherwise>
							
							</c:choose>
                        </button>
                        <!-- https://icons.getbootstrap.kr/ : thums-up fill 있음  -->
                        <h5 class="mb-1">${vo.festival_name}</h5>
                        <div class="pt-4 pb-4">
                            <div class="media">
                                <a href="#"><img alt="Generic placeholder image"
                                        src="http://bootdey.com/img/Content/avatar/avatar1.png"
                                        class="mr-2 rounded-pill"></a>
                                <div class="media-body">
                                    <div class="reviews-members-header">
                                        <h6 class="mb-1"><a class="text-black" href="#">${vo.review_nickname}</a></h6>
                                        <p class="text-gray">${vo.review_date}</p>
                                    </div>
                                    <div class="reviews-members-body">
                                        <p>${vo.review_content}</p>
                                    </div>

                                </div>
                            </div>
                        </div>

                    </div>
                </c:forEach>
                <nav aria-label="Page navigation example">
                    <ul class="pagination">
                        <c:forEach var="i" begin="1" end="${pageCount }">
                            <li class="page-item"><a class="page-link" href="${i}">${i}</a></li>
                        </c:forEach>
                    </ul>
                </nav>
            </c:if>
        </div>
    </section>
<script>
    
    
    const pushLike=function(reviewId, state){
        //alert("pushLike1");
        if(state==0 && !$("#thumbs-up-"+reviewId).hasClass("bi-hand-thumbs-up-fill")){
            //alert("pushLike2");
            $.ajax({
                type:'post',
                url:'/users/like?reviewId='+reviewId,
                dataType:'json',
                success:function(res){
                    //alert(res);
                    //alert(JSON.stringify(res))
                    $("#thumbs-up-"+reviewId).removeClass("bi-hand-thumbs-up");
                    $("#thumbs-up-"+reviewId).addClass("bi-hand-thumbs-up-fill");

                    let likeCountStr  = $(`#like_count-` + reviewId).text();
                    let likeCount = Number(likeCountStr) + 1;
                    $(`#like_count-` + reviewId).text(likeCount);
                   
                    
                },
                error:function(err){
                    console.log(err.status);
                }
		    })
            
        }else{
            //alert("pushLike3");
            $.ajax({
                type:'delete',
                url:'/users/like?reviewId='+reviewId,
                dataType:'json',
                success:function(res){
                    //alert(JSON.stringify(res))
                    $("#thumbs-up-"+reviewId).removeClass("bi-hand-thumbs-up-fill");
                    $("#thumbs-up-"+reviewId).addClass("bi-hand-thumbs-up");
                    let likeCountStr  =  $(`#like_count-` + reviewId).text();
                    let likeCount = Number(likeCountStr) - 1;
                    $(`#like_count-` + reviewId).text(likeCount);

                },
                error:function(err){
                    console.log(err.status);
                }
		    })
        }
    }
</script>