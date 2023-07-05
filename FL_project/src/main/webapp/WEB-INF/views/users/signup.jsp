<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<head>
    <style>
        .email_ok {
            color: ##2f1007;
            display: none;
        }

        .email_already {
            color: ##2f1007;
            display: none;
        }

        .nickname_ok {
            color: ##2f1007;
            display: none;
        }

        .nickname_already {
            color: ##2f1007;
            display: none;
        }
    </style>
</head>


<script src="http://code.jquery.com/jquery-latest.js"></script>
<script>
    /* 인증번호 이메일 전송 */
    $(document).ready(function() {
        $('#mail-Check-Btn').click(function() {
            alert('인증번호가 발송되었습니다');
            var email = $("#email").val();
            $.ajax({
                type: "GET",
                url: "/mailCheck?email=" + email,
                success: function(data) {
                    code = data;
                    console.log("code"+code);
                }
            });
        });
    }); ///인증번호 이메일 전송


    /* 인증번호 비교 */
    $(document).ready(function() {
        $("#mail-checkNum-Btn").click(function() {
            alert('a')

            var inputCode = $("#mail_check_input").val(); // 입력코드
            if (inputCode == code) { // 일치할 경우
                alert('인증번호가 일치합니다.');
            } else { // 일치하지 않을 경우
                alert('인증번호를 다시 확인해주세요.');
            }
        });
    }); //인증번호 비교

    function check() {
        //이메일
        if (mf.email.value.length == 0) { // mf.email.value == "" 이것도 가능
            alert("이메일을 입력해주세요.");
            mf.email.focus(); // 포커스를 이동시켜 바로 아이디를 입력할 수 있게
            return false;
        }

        if (mf.email.value.indexOf('@') == -1) {
            alert("이메일 형식이 아닙니다.");
            mf.email.focus();
            return false;
        }


        //인증번호
        if (mf.cf.value.length == 0) {
            alert("인증번호를 입력해주세요.");
            mf.cf.focus(); // 포커스를 이동시켜 바로 비밀번호를 입력할 수 있게
            return false;
        }

        /* 비밀번호 및 비밀번호 확인 유효성 검사 */
        if (mf.password.value.length == 0) {
            alert("비밀번호를 입력해주세요.");
            mf.password.focus(); // 포커스를 이동시켜 바로 비밀번호를 입력할 수 있게
            return false;
        }

        if (mf.repassword.value.length == 0) {
            alert("비밀번호 확인을 입력해주세요.");
            mf.repassword.focus();
            return false;
        }

        if (mf.password.value != mf.repassword.value) {
            alert("비밀번호가 일치하지 않습니다.");
            mf.repassword.select(); //이걸로 하면 focus 이동하면서 입력한게 블록으로 선택됨
            return false;
        }

        //닉네임
        if (mf.nickname.value.length == 0) {
            alert("닉네임을 입력해주세요.");
            mf.nick.focus();
            return false;
        }


    }

    //이메일 중복체크
    function checkEmail() {
        var email = $('#email').val(); //email값이 "email"인 입력란의 값을 저장
        console.log(email);
        $.ajax({
            url: '/emailCheck', //Controller에서 요청 받을 주소
            type: 'post',
            data: {
                email: email
            },
            success: function(cnt) { //컨트롤러에서 넘어온 cnt값을 받는다
                if (cnt == 0) { //cnt가 1이 아니면(=0일 경우) -> 사용 가능한 아이디
                    $('.email_ok').css("display", "inline-block");
                    $('.email_already').css("display", "none");
                } else { // cnt가 1일 경우 -> 이미 존재하는 아이디
                    $('.email_already').css("display", "inline-block");
                    $('.email_ok').css("display", "none");
                    alert("이메일을 다시 입력해주세요");
                    $('#email').val('');
                }
            },
            error: function() {
                alert("에러입니다");
            }
        });
    };


    //닉네임 중복체크

    function checkNick() {
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
    }; //닉네임 중복체크
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
                                    <input type="text" name="email" id="email" oninput="checkEmail()" placeholder="이메일을 입력해주세요">
                                    <br>
                                    <!-- id ajax 중복체크 -->
                                    <span class="email_ok">사용 가능한 이메일입니다.</span> <span class="email_already">이미 가입된 이메일입니다.</span>
                                </div>

                                <div class="col-3">
                                    <button type="button" id="mail-Check-Btn" class="btn btn-success">인증번호 발송</button>
                                </div>
                            </div>
                            <br>
                        </td>
                    </tr>
                    <tr>
                        <td width="20%" class="m1"><b>인증번호 확인</b></td>
                        <td width="80%" class="m2">
                            <input type="password" name="cf" id="cf" class="user-control" placeholder="인증번호를 입력해주세요">
                                 <br>
                              <div class="col-3">
                                 <button type="button" id="mail-checkNum-Btn" class="btn btn-success">인증번호 확인</button>
                                </div>

                    <tr>
                        <td width="20%" class="m1"><b>비밀번호</b></td>
                        <td width="80%" class="m2">
                            <input type="password" name="password" id="password" class="user-control" placeholder="Password">
                            <br>
                            <span class="ck">*비밀번호는 문자,숫자,!,.포함해서 4~8자 이내</span>
                        </td>
                    </tr>

                    <tr>
                        <td width="20%" class="m1"><b>비밀번호 확인</b></td>
                        <td width="80%" class="m2">
                            <input type="password" name="repassword" id="repassword" class="user-control" placeholder="Re Password">
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
                                    <input type="text" name="nickname" id="nickname" oninput="checkNick()" placeholder="닉네임을 입력하세요">
                                    <br>
                                    <!-- nickname ajax 중복체크 -->
                                    <span class="nickname_ok">사용 가능한 닉네임입니다.</span>
                                    <span class="nickname_already">이미 사용중인 닉네임 입니다.</span>
                                </div>
                            </div>
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
