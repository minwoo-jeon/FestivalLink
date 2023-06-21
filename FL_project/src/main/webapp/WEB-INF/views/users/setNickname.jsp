<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  
    
    <section class="vh-100 gradient-custom">
      <div class="container py-5 h-100">

        <div class="row justify-content-center align-items-center h-100">
          <div class="col-12 col-lg-9 col-xl-7">
            <div class="card shadow-2-strong card-registration" style="border-radius: 15px;">
              <div class="card-body p-4 p-md-5">
                <h3 class="">닉네임을 설정해주세요</h3>
                <form action="/users/naverSignup" method="post" onsubmit="return nickname_check()">
                  <input type="hidden" id="email" name="email" value="${email}">
                  <input type="hidden" id="user_id" name="user_id" value="${id}">

                  <div class="row">
                    <div class="col-md-6 mb-4 pb-2">
                      <div class="form-outline">
                        <input id="nickname" class="form-control form-control-lg" name="nickname"/>
                        <label class="form-label" for="nickname">닉네임 입력 후 중복체크해주세요</label>
                      </div>
                    </div>
                    <div class="col-md-6 mb-4 pb-2">

                      <div class="form-outline">
                        <button id="nickCheckButton" class="btn btn-primary btn-lg" type="button" onclick="fn_nickCheck();"
                          >중복체크</button>
                          <input id="nickCheck" type="text" value="N"/>
                      </div>

                    </div>
                    <div class="mt-2 pt-2">
                      <input class="btn btn-primary btn-lg" type="submit" id="regiButton" value="회원가입" />
                    </div>
                  </div>
                </form>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
  <script>
    function fn_nickCheck() {
      $.ajax({
        url: "/users/naverNickCheck",
        type: "POST",
        dataType: "JSON",
        data: { "nickname": $("#nickname").val() },
        success: function (data) {
          if (data == 1) {
            $("#nickCheck").val("N");
            alert("중복된 닉네임입니다.");
            $("#nickname").val("");
            $("#nickname").focus();

          } else if (data == 0 && $("#nickname").val().length >0) {
            $("#nickCheck").val("Y");
            alert("사용 가능한 닉네임입니다.");
          } else if ($("#nickname").val().length == 0) {
            $("#nickCheck").val("N");
            alert("닉네임을 2자~10자이내로 적어주세요.");
            $("#nickname").focus();
          }
        },
        error: function (err) {
          alert('error: ' + err.status);
        }


      })
    }
   
    function nickname_check(){
      fn_nickCheck();
      if($("#nickCheck").val()=="Y") return true;
      else{
        alert("닉네임 중복체크를 해주세요");
        return false;
      }
    }

  </script>