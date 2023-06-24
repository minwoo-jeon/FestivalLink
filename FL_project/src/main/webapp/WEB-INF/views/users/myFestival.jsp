<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <style>
    #festimg {
      height: 21em;
    }

    @font-face {
      font-family: 'NanumSquareNeo-Variable';
      src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_11-01@1.0/NanumSquareNeo-Variable.woff2') format('woff2');
      font-weight: normal;
      font-style: normal;
    }
  </style>
  <section class="h-100 gradient-custom">
    <div class="container py-5 h-100">
      <h1 style="color: white; font-family: 'NanumSquareNeo-Variable';">내가 좋아요 한 축제 ${totalCount}</h1>
      <br>
      <c:if test="${myFestivalArr eq null or empty myFestivalArr}">
        <div class="bg-white rounded shadow-sm p-4 mb-4 reviews">

          <!-- https://icons.getbootstrap.kr/ : thums-up fill 있음  -->

          <div class="pt-4 pb-4">

            <p>
            <h2>아직 내가 좋아요 한 축제가 없습니다.</h2>
            </p>
          </div>

        </div>
      </c:if>
      <c:if test="${myFestivalArr ne null and not empty myFestivalArr}">
        <div class="row">
        <c:forEach var="vo" items="${myFestivalArr}">
          
            <div class="card m-2" style="width: 16em; height: 23em;">
              <img src="https://mdbcdn.b-cdn.net/img/new/standard/city/041.webp" class="card-img-top" id="festimg"
                alt="Hollywood Sign on The Hill" />
              <div class="card-body">
                <h5 class="card-title"><a href="#">${vo.festival_name}</a></h5>
                <span>${vo.festival_place}</span> | <span>${vo.festival_start} ~ ${vo.festival_end}</span>
              </div>
            </div>
          
        </c:forEach>
      </div>
      </c:if>
      <nav aria-label="Page navigation example">
        <ul class="pagination">
            <li class="page-item"><a class="page-link" href="#">Previous</a></li>
                <c:forEach var="i" begin="1" end="${pageCount }">
                    <li class="page-item"><a class="page-link" href="myFestival?page=${i}">${i}</a></li>
                </c:forEach>
            <li class="page-item"><a class="page-link" href="#">Next</a></li>
        </ul>
    </nav>
    </div>
  </section>