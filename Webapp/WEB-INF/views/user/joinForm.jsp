<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="${pageContext.request.contextPath }/assets/css/jblog.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/assets/js/jquery/jquery-1.12.4.js"></script>
<title>JBlog</title>
</head>
<body>
	<div class="center-content">

		<a href="${pageContext.request.contextPath }/user/main"> <img class="logo" src="${pageContext.request.contextPath }/assets/images/logo.jpg">
		</a>
		<ul class="menu">
			<c:choose>
				<c:when test="${empty authUser }">
					<!-- 로그인 전 메뉴 -->
					<li><a href="${pageContext.request.contextPath }/user/loginform">로그인</a></li>
					<li><a href="${pageContext.request.contextPath }/user/joinform">회원가입</a></li>
				</c:when>
				<c:otherwise>
					<!-- 로그인 후 메뉴 -->
					<li><a href="${pageContext.request.contextPath }/user/logout">로그아웃</a></li>
					<li><a href="">내블로그</a></li>
				</c:otherwise>
			</c:choose>
		</ul>

		<form class="join-form" id="join-form" method="post" action="${pageContext.request.contextPath}/user/join">
			<label class="block-label" for="name">이름</label> <input type="text" name="userName" value="" /> <label class="block-label" for="id">아이디</label> <input type="text" id="id" name="id" value="" /> <input
				id="btn-checkid" type="button" value="id 중복체크">
			<p id="checkid-msg" class="form-error">
			<p id="eamilResult">
			<p>&nbsp;</p>

			<label class="block-label" for="password">패스워드</label> <input type="password" name="password" value="" />

			<fieldset>
				<legend>약관동의</legend>
				<input id="agree-prov" type="checkbox" name="agreeProv" value="y"> <label class="l-float">서비스 약관에 동의합니다.</label>
			</fieldset>

			<input type="submit" value="가입하기">

		</form>
	</div>

</body>
<script type="text/javascript">
	$("#btn-checkid").on("click", function() {
		console.log("버튼클릭");
		var id = $("#id").val();
		console.log(id);

		$.ajax({
			url : "${pageContext.request.contextPath }/user/emailcheck", //컨트롤주소
			type : "post",
			//contentType : "application/json", //보낼데이터의 형태
			data : {
				id : id
			}, //뒤에 데이터 붙어가는 뒤에가var email

			//여기부턴 받을때
			dataType : "json",
			success : function(result) {
				/*성공시 처리해야될 코드 작성*/
				console.log(result);
				if (result == true) {
					$("#eamilResult").text("사용할 수 있는 메일입니다");
					$("#eamilResult").css("color", "blue");
				} else {
					$("#eamilResult").text("사용중인 메일입니다");
					$("#eamilResult").css("color", "red");
				}
			},
			error : function(XHR, status, error) {
				console.error(status + " : " + error);
			}
		})
	});
</script>

</html>