<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="${pageContext.request.contextPath }/assets/css/jblog.css">
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
					<li><a href="${pageContext.request.contextPath }">내블로그</a></li>
				</c:otherwise>
			</c:choose>
		</ul>

		<form class="login-form" method="post" action="${pageContext.request.contextPath }/user/login">
			<label>아이디</label> <input type="text" name="id" id="id"> <label>패스워드</label> <input type="text" name="password" id="password">

			<c:if test="${param.result eq 'fail' }">
				<p class="form-error">
					로그인 실패<br> 아이디/패스워드를 확인해 주세요
				</p>
			</c:if>

			<input type="submit" value="로그인">
		</form>

	</div>
	<div id="dialog-message" title="" style="display: none">
		<p></p>
	</div>
</body>

</html>