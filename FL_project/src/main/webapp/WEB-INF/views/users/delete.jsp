<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
   <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">


<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script>

</script>
<style type="text/css">
.mybtn{
  width:150px;
  height:40px;
  padding:0;
  display:inline;
  border-radius: 4px;
  background: #212529;
  color: #fff;
  margin-top: 20px;
  border: solid 2px #212529;
  transition: all 0.5s ease-in-out 0s;
}
.mybtn:hover .mybtn:focus {
  background: white;
  color: #212529;
  text-decoration: none;
}
</style>
</head>
<script>

	$(document).ready(function(){
			$("#submit").on("click", function(){
				alert(" 회원 탈퇴를 하시겠습니까?");
				})




			});

	</script>
<body>

	<div class="w3-content w3-container w3-margin-top">
		<div class="w3-container w3-card-4 w3-auto" style="width: 382px;height: 456.3px;">
			<div class="w3-center w3-large w3-margin-top">
			<form action="/userDelete" method="post">
				<h3>회원 탈퇴</h3>
			</div>
			<div>
				<p>
				<label>이메일</label>
				<input class="w3-input" type="text" id="email" name="email" placeholder="회원가입한 이메일주소를 입력하세요" value="${user.email}" readonly="readonly">
				</p>
				<p>
                	<label>비밀번호</label>
                	<input class="w3-input" type="password" id="password" name="password" placeholder="비밀번호를 입력해주세요" required>
                	</p>
				<p class="w3-center">
					<button type="submit" id="submit" class="w3-button w3-hover-white w3-ripple w3-margin-top w3-round mybtn">회원 탈퇴</button>
				</p>
				<div>
                				<c:if test="${msg == false}">
                				비밀번호가 맞지 않습니다.
                				</c:if>
               </div>
               </form>
			</div>
		</div>
	</div>
</body>
</html>