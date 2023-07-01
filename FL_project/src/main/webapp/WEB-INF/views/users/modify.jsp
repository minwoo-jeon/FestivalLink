<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<head>
    <style>
        .nickname_ok {
            color: ##2f1007;
            display: none;
        }

        .nickname_already {
            color: ##2f1007;
            display: none;
        }


        .correct {
            color: green;
        }

        .incorrect {
            color: red;
        }
    </style>
</head>


<script src="http://code.jquery.com/jquery-latest.js"></script>

<script>
    //닉네임 중복체크 확인
    function checkNickname() {
        var nickname = $('#nickname').val(); //id값이 "nickname"인 입력란의 값을 저장
        $.ajax({
            url: '/nicknameCheck', //Controller에서 요청 받을 주소
            type: 'post',
            data: {
                nickname: nickname
            },
            success: function(cnt) { //컨트롤러에서 넘어온 cnt값을 받는다
                if (cnt == 0) { //cnt가 1이 아니면(=0일 경우) -> 사용 가능한 닉네임
                    $('.nickname_ok').css("display", "inline-block");
                    $('.nickname_already').css("display", "none");
                } else { // cnt가 1일 경우 -> 이미 존재하는 닉네임
                    $('.nickname_already').css("display", "inline-block");
                    $('.nickname_ok').css("display", "none");
                    alert("닉네임을 다시 입력해주세요");
                    $('#nickname').val('');
                }
            },
            error: function() {
                alert("에러입니다");
            }
        });
    };

     function check() {
                   //닉네임
                         if (mf.nickname.value.length == 0) {
                          alert("사용할 닉네임을 입력해주세요.");
                          mf.nickname.focus();
                          return false;
                             }


                 /* 비밀번호 및 비밀번호 확인 유효성 검사 */
                 if (mf.password.value.length == 0) {
                     alert("현재 비밀번호를 입력해주세요.");
                     mf.password.focus(); // 포커스를 이동시켜 바로 비밀번호를 입력할 수 있게
                     return false;
                 }


                  if (mf.newPassword.value.length == 0) {
                                 alert("새 비밀번호를 입력해주세요.");
                                 mf.newPassword.focus(); // 포커스를 이동시켜 바로 비밀번호를 입력할 수 있게
                                 return false;
                             }


                 if (mf.rePassword.value.length == 0) {
                     alert("새 비밀번호 확인을 입력해주세요.");
                     mf.rePassword.focus();
                     return false;
                 }

                 if (mf.newPassword.value != mf.rePassword.value) {
                     alert("비밀번호가 서로 일치하지 않습니다.");
                     mf.rePassword.select(); //이걸로 하면 focus 이동하면서 입력한게 블록으로 선택됨
                     return false;
                 }


                 return true;


             }

</script>



<div class="container">
    <h1 class="text-center mb-3" div style="padding:30px">내 정보 수정</h1>
    <form name="mf" action="/modify" method="post">
        <table class='table'>

             <td width="20%" class="m1"><b>이메일</b></td>
                <td width="80%" class="m2">
                  <input type="text" name="email" id="email" class="user-control" value="${user.email}" readonly >
                    <br>
                     <br>
                        </td>
                        </tr>



            <tr>
                <td width="20%" class="m1"><b>사용할 닉네임</b></td>
                <td width="80%" class="m2">
                    <div class="row">
                        <div class="col-3">
                            <input type="text" name="nickname" id="nickname" oninput="checkNickname()" placeholder="닉네임">
                        </div>

                        <!-- nickname ajax 중복체크 -->
                        <span class="nickname_ok">사용 가능한 닉네임입니다.</span>
                        <span class="nickname_already">이미 사용중인 닉네임 입니다.</span>
                    </div>
                    <br>
                </td>
            </tr>
            <td width="20%" class="m1"><b>현재 비밀번호</b></td>
            <td width="80%" class="m2">
                <input type="password" name="password" id="password" class="user-control" placeholder="Password">
                <br>
                <span class="ck">*현재 사용하고 있는 비밀번호를 입력해주세요</span>
            </td>
            </tr>

            <tr>
                <td width="20%" class="m1"><b>새 비밀번호 </b></td>
                <td width="80%" class="m2">
                    <input type="password" name="newPassword" id="newPassword" class="user-control" placeholder="Password">
                    <br>
                    <span class="ck">*비밀번호는 문자,숫자,!,.포함해서 4~8자 이내</span>
                    <br>
                </td>
            </tr>

            <tr>
                <td width="20%" class="m1"><b>새 비밀번호 확인</b></td>
                <td width="80%" class="m2">
                    <input type="password" name="rePassword" id="rePassword" class="user-control" placeholder="Re Password">
                    <br>
                    <span class="ck">*비밀번호는 문자,숫자,!,.포함해서 4~8자 이내</span>
                    <br>
                </td>
            </tr>

             <tr>
                <td colspan="2" class="m2" style="text-align:left">
                <span><a href="/users/mypage/delete">회원탈퇴</span>
             </tr>
            <tr>
                <td colspan="2" class="m2" style="text-align:center">
                    <input type="submit" value="회원수정완료" class="btn btn-primary" onClick="return check()">
                    <button type="reset" class="btn btn-danger">다시쓰기</button>

                </td>
            </tr>
        </table>
    </form>
</div>
</div>