<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<head>
<style>
.id_ok{
color:##2f1007;
display: none;
}

.id_already{
color:##2f1007;
display: none;
}


.nick_ok{
color:##2f1007;
display: none;
}

.nick_already{
color:##2f1007;
display: none;
}

</style>
</head>


  <script src="http://code.jquery.com/jquery-latest.js"></script>

<script>
/* 인증번호 이메일 전송 */
     $(function(){
               $("#checkEmail").click(function(){
                  //alert("버튼체크");
                  var email =$(#id).val();
               });
            });

         function check(){
                        //이메일
                    if(mf.id.value.length == 0){ // mf.id.value == "" 이것도 가능
                    				alert("이메일을 입력해주세요.");
                    				mf.id.focus(); // 포커스를 이동시켜 바로 아이디를 입력할 수 있게
                    				return false;
                    			}

                   if(mf.id.value.indexOf('@') == -1){
                   				alert("이메일 형식이 아닙니다.");
                   				mf.id.focus();
                   				return false;
                   			}


                       //인증번호
                    if(mf.cf.value.length == 0){
                                    alert("인증번호를 입력해주세요.");
                              	    mf.cf.focus(); // 포커스를 이동시켜 바로 비밀번호를 입력할 수 있게
                              	    return false;
                              		}

                  /* 비밀번호 및 비밀번호 확인 유효성 검사 */
                  			if(mf.password.value.length == 0){
                  				alert("비밀번호를 입력해주세요.");
                  				mf.password.focus(); // 포커스를 이동시켜 바로 비밀번호를 입력할 수 있게
                  				return false;
                  			}

                  			if(mf.repassword.value.length == 0){
                  				alert("비밀번호 확인을 입력해주세요.");
                  				mf.repassword.focus();
                  				return false;
                  			}

                  			if(mf.password.value != mf.repassword.value){
                  				alert("비밀번호가 일치하지 않습니다.");
                  				mf.repassword.select(); //이걸로 하면 focus 이동하면서 입력한게 블록으로 선택됨
                  				return false;
                  			}

                  			//닉네임
                  		    if(mf.nick.value.length == 0){
                                  alert("닉네임을 입력해주세요.");
                                  mf.nick.focus();
                                  return false;
                             }


        }

            //이메일 중복체크
            function checkId(){
            var id = $('#id').val(); //id값이 "id"인 입력란의 값을 저장
            console.log(id);
                $.ajax({
                url:'/idCheck', //Controller에서 요청 받을 주소
                type:'post',
                data:{id:id},
                success:function(cnt){ //컨트롤러에서 넘어온 cnt값을 받는다
                    if(cnt == 0){ //cnt가 1이 아니면(=0일 경우) -> 사용 가능한 아이디
                        $('.id_ok').css("display","inline-block");
                        $('.id_already').css("display", "none");
                    } else { // cnt가 1일 경우 -> 이미 존재하는 아이디
                        $('.id_already').css("display","inline-block");
                        $('.id_ok').css("display", "none");
                        alert("이메일을 다시 입력해주세요");
                        $('#id').val('');
                    }
                },
                error:function(){
                    alert("에러입니다");
                }
            });
            };


        //닉네임 중복체크

            function checkNick(){
                        var nick = $('#nick').val(); //id값이 "nick"인 입력란의 값을 저장
                            $.ajax({
                            url:'/nickCheck', //Controller에서 요청 받을 주소
                            type:'post',
                            data:{nick:nick},
                            success:function(cnt){ //컨트롤러에서 넘어온 cnt값을 받는다
                                if(cnt == 0){ //cnt가 1이 아니면(=0일 경우) -> 사용 가능한 닉네임
                                    $('.nick_ok').css("display","inline-block");
                                    $('.nick_already').css("display", "none");
                                } else { // cnt가 1일 경우 -> 이미 존재하는 닉네임
                                    $('.nick_already').css("display","inline-block");
                                    $('.nick_ok').css("display", "none");
                                    alert("닉네임을 다시 입력해주세요");
                                    $('#nick').val('');
                                }
                            },
                            error:function(){
                                alert("에러입니다");
                            }
                        });
                        };








        </script>








        <section class="vh-100 gradient-custom">
                <div class="container py-5 h-100">
        <div class="container">
            <h1 class="text-center mb-3">회원 가입</h1>
            <form name="mf" action="/users/signup" method="post">

            <table class='table'>
                <tr>
                    <td width="20%" class="m1"><b>이메일</b></td>
                    <td width="80%" class="m2">
                    <div class="row">
                        <div class="col-3">
                            <input type="text" name="id" id="id"   oninput ="checkId()" placeholder="이메일">
                         </div>

                    <!-- id ajax 중복체크 -->
                        <span class="id_ok">사용 가능한 이메일입니다.</span><br>
                        <span class="id_already">이미 가입된 이메일입니다.</span>

                          <div class="col-3">
                            <button type="button" id="checkEmail" class="btn btn-success">인증번호 발송</button>
                          </div>
                    </div>
                    <br>
                    </td>
                </tr>
                <tr>
                       <td width="20%" class="m1"><b>인증번호 확인</b></td>
                       <td width="80%" class="m2">
                       <input type="password" name="cf" id="cf"   class="user-control" placeholder="인증번호를 입력해주세요">
                       <br>

                <tr>
                    <td width="20%" class="m1"><b>비밀번호</b></td>
                    <td width="80%" class="m2">
                    <input type="password" name="password" id="password"   class="user-control" placeholder="Password">
                    <br>
                    <span class="ck">*비밀번호는 문자,숫자,!,.포함해서 4~8자 이내</span>
                    </td>
                </tr>

                <tr>
                    <td width="20%" class="m1"><b>비밀번호 확인</b></td>
                    <td width="80%" class="m2">
                    <input type="password" name="repassword" id="repassword"  class="user-control" placeholder="Re Password">
                      <br>
                      <span class="ck">*비밀번호는 문자,숫자,!,.포함해서 4~8자 이내</span>
                    <br>
                    </td>
                </tr>

                <tr>
                    <td width="20%" class="m1"><b>닉네임</b></td>
                    <td width="80%" class="m2">
                    <div class="row">
                        <div class="col-6">
                            <input type="text" name="nick" id="nick" oninput ="checkNick()"
                             placeholder="닉네임을 입력하세요">
                         </div>


                        <!-- nickname ajax 중복체크 -->
                                    <span class="nick_ok">사용 가능한 닉네임입니다.</span>
                                    <span class="nick_already">이미 사용중인 닉네임 입니다.</span>
                    </div>
                    <br>
                    </td>
                </tr>


                <tr>
                    <td colspan="2" class="m2" style="text-align:center">
                         <input type="submit" value="회원가입" class="btn btn-primary" onClick="return check()">
                        <button type="reset" class="btn btn-danger">다시쓰기</button>
                    </td>
                </tr>

            </table>

            </form>
        </div>
        </div>
        </section>