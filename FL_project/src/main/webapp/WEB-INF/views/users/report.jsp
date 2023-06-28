<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <style>
        #reviewCard {
            margin: 8px;
            position: relative;
            min-height: 170px;
            max-height: 170px;
        }
        .reportBoard a{
            font-size: 30px;
	        color: #ffff;
        }
    </style>

<c:if test="${user eq null}">
    <section class="h-100 gradient-custom">
        <div class="container py-5 h-100">
            <div class="bg-white rounded shadow-sm p-4 mb-4 reviews">

                <!-- https://icons.getbootstrap.kr/ : thums-up fill 있음  -->

                <div class="pt-4 pb-4">

                    <p>
                    <h2>관리자아이디로 로그인하세요.</h2>
                    </p>
                </div>

            </div>
        </div>
    </section>
</c:if>
    <c:if test="${user.state ne 0 and user ne null}">
        <section class="h-100 gradient-custom">
            <div class="container py-5 h-100">
                <div class="bg-white rounded shadow-sm p-4 mb-4 reviews">

                    <!-- https://icons.getbootstrap.kr/ : thums-up fill 있음  -->

                    <div class="pt-4 pb-4">

                        <p>
                        <h2>관리자만 이용할 수 있습니다.</h2>
                        </p>
                    </div>

                </div>
            </div>
        </section>
    </c:if>
    <c:if test="${user.state eq 0}">
        <section class="h-100 gradient-custom">
            <div class="container py-5 h-100">
                <div class="reportBoard">
                    <a href="users/report">신고된 리뷰 |</a>
                    <a href="#"> 신고된 소행사</a>
                </div>
                
                <c:if test="${reportArr eq null or empty reportArr}">
                    <div class="bg-white rounded shadow-sm p-4 mb-4 reviews">

                        <!-- https://icons.getbootstrap.kr/ : thums-up fill 있음  -->

                        <div class="pt-4 pb-4">

                            <p>
                            <h2>신고된 리뷰가 없습니다.</h2>
                            </p>
                        </div>

                    </div>
                </c:if>
                <c:if test="${reportArr ne null and not empty reportArr}">
                    <div class="row">
                    <c:forEach var="vo" items="${reportArr}">
                        <div class="col-sm-6" id="reviewCard-${vo.r_report_id}">
                            <div class="card" id="reviewCard">
                                <div class="card-body">
                                    <h6 class="card-title">신고 유저 id=${vo.user_id_fk}</h6>
                                    <p class="card-text">${vo.r_report_content}</p>
                                    <a href="/community?reviewId=${vo.review_id_fk}" class="btn btn-primary">리뷰 보러가기</a>
                                    <button onclick="delReviewReport('${vo.r_report_id}')" class="btn btn-danger">신고 삭제</button>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
                    <nav aria-label="Page navigation example" class="mt-5">
                        <ul class="pagination">
                            <c:forEach var="i" begin="1" end="${pageCount }">
                                <li class="page-item"><a class="page-link" href="report?page=${i}">${i}</a></li>
                            </c:forEach>
                        </ul>
                    </nav>
                </c:if>
            </div>
        </section>
    </c:if>
<script>
    const delReviewReport = function(reportId){
        //alert(reportId);
        $.ajax({
                type:'delete',
                url:'/users/report?r_report_id='+reportId,
                dataType:'json',
                success:function(res){
                    alert(res);
                    $('#reviewCard-'+reportId).empty();
                },
                error:function(err){
                    alert(err.status);
                }
            })
    }
</script>