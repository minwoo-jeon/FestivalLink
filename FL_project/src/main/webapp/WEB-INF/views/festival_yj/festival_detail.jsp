<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<section class="h-100 gradient-custom">
    <div class="container py-5 h-100">
        <div class="bg-light row">
            <div class="col-lg-12 mb-4 mb-sm-5">
                <div class="card card-style1 border-0">
                    <div class="card-body p-1-9 p-sm-2-3 p-md-6 p-lg-7">
                        <div class="row align-items-center">
                            <div class="col-lg-6 mb-4 mb-lg-0">
                                <!-- 축제이미지 -->
                                <img class="img-fluid" src="https://mdbootstrap.com/img/Photos/Horizontal/Food/full page/2.jpg"
                                alt="Card image cap" />
                            </div>
                            <div class="col-lg-6 px-xl-10">
                                <div class="bg-secondary d-lg-inline-block py-1-9 px-1-9 px-sm-6 mb-1-9 rounded">
                                    <h3 class="h2 text-white mb-0">축제이름</h3>
                                    <span class="text-light">축제 시작 ~ 축제 끝</span>
                                </div>
                                <ul class="list-unstyled mb-1-9">
                                    <li class="mb-2 mb-xl-3 display-28"><span class="display-26 text-secondary me-2 font-weight-600">축제 지역 :</span> 어디시 어디구 어디동</li>
                                    <li class="mb-2 mb-xl-3 display-28"><span class="display-26 text-secondary me-2 font-weight-600">주관 기관 : </span> 어디어디기관</li>
                                    <li class="mb-2 mb-xl-3 display-28"><span class="display-26 text-secondary me-2 font-weight-600">주최 기관 : </span> edith@mail.com</li>
                                    <li class="mb-2 mb-xl-3 display-28"><span class="display-26 text-secondary me-2 font-weight-600">홈페이지 :</span> www.example.com</li>
                                    <li class="display-28"><span class="display-26 text-secondary me-2 font-weight-600">축제 번호 :</span> 507 - 541 - 4567</li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-12 mb-4 mb-sm-5">
                <div>
                    <span class="section-title text-primary mb-3 mb-sm-4"><h3>축제 내용</h3></span>
                    <p>축제 내용 상세 어쩌구 저쩌구 </p>
                </div>
            </div>
            <div class="col-lg-12">
                <div class="row">
                    <div class="col-lg-12 mb-4 mb-sm-5">
                        <div class="container">
                            <span class="section-title text-primary mb-3"><h3>지도</h3></span>
                            <!-- 지도 -->
                            <div class="container">
                                <section class="mx-auto" style="max-width: 23rem;">
                                    
                                    <div id="map-container-google-1" class="z-depth-1-half map-container" style="height: 500px">
                                        <iframe src="https://maps.google.com/maps?q=manhatan&t=&z=13&ie=UTF8&iwloc=&output=embed" frameborder="0"
                                          style="border:0" allowfullscreen></iframe>
                                      </div>
                                </section>
                              </div>
                              <!-- 지도 끝 -->
                        <div>
                            <span class="section-title text-primary mb-3 mb-sm-4"><h3>리뷰</h3></span>
                            <br><br>
                            <div class="bg-white rounded shadow-sm p-4 mb-5 pb-3 reviews">
                                <input type="hidden" value="L" class="state">
                                <a href="#">수정</a>|<a href="#">삭제</a>
                                <button onclick="" class="btn btn-outline-primary btn-sm float-right">좋아요
                                    <b id="like_count-${vo.review_id}">좋아요 수</b>
                                    <i class="bi bi-hand-thumbs-up" id="thumbs-up"></i>
                                    
                                </button>
                                <!-- https://icons.getbootstrap.kr/ : thums-up fill 있음  -->
                                <h5 class="mb-1">축제이름</h5>
                                <div class="pt-4 pb-4">
                                    <div class="media">
                                        <a href="#"><img alt="Generic placeholder image"
                                                src="http://bootdey.com/img/Content/avatar/avatar1.png"
                                                class="mr-2 rounded-pill"></a>
                                        <div class="media-body">
                                            <div class="reviews-members-header">
                                                <h6 class="mb-1"><a class="text-black" href="#">닉네임</a></h6>
                                                <p class="text-gray">리뷰데이트 </p>
                                            </div>
                                            <div class="reviews-members-body">
                                                <p>리뷰내용 </p>
                                            </div>
        
                                        </div>
                                    </div>
                                </div>
        
                            </div>
              
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
