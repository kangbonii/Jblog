<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/jblog.css">
<title>JBlog</title>
</head>
<body>

	<div id="container">

		<div id="header">
			<h1>
				<a href="${pageContext.request.contextPath }/${authUser.id}">${title}</a>
			</h1>
			<ul>
				<c:choose>
					<c:when test="${empty authUser}">
						<!-- 로그인 전 메뉴 -->
						<li><a href="${pageContext.request.contextPath }/user/loginform">로그인</a></li>
					</c:when>
					<c:otherwise>
						<!-- 로그인 후 메뉴 -->
						<li><a href="${pageContext.request.contextPath }/user/logout">로그아웃</a></li>
						<c:if test="${sessionScope.authUser.id == userVo.id }">
							<li><a href="${pageContext.request.contextPath }/${authUser.id}/admin/basic">내블로그 관리!</a></li>
						</c:if>
					</c:otherwise>
				</c:choose>
			</ul>
		</div>

		<div id="wrapper">
			<div id="content">
				<div class="blog-content">
					<!-- 등록된 글이 있을때 -->
					<h4>${PostVo.postTitle}</h4>
					<p>
					
						${PostVo.postContent}
						<br> <br>
					<p>


						<!-- 등록된 글이 없을때 -->
						<!-- 
					<h4>등록된 글이 없습니다.</h4>
					<p>
						
					<p>
					 -->
				</div>
				<ul class="blog-list">
					<li><a href=""><strong>${PostVo.postTitle}</strong></a> <span>${PostVo.regDate}</span></li>
					<c:forEach items="${PostList}" var="vo"> 
					<li><a href="">${vo.postTitle}</a> <span>${vo.regDate}</span></li>
					</c:forEach>
					
				</ul>
			</div>
		</div>

		<div id="extra">
			<div class="blog-logo">

				<!-- 기본 로고 -->
				<c:choose>
					<c:when test="${empty BlogVo.logoFile}">
						<td><img src="${pageContext.request.contextPath }/assets/images/spring-logo.jpg"></td>
					</c:when>
					<c:otherwise>
				<!-- 등록한 경우 자신의 로고 -->
						<img src="${pageContext.request.contextPath}/upload/${BlogVo.logoFile}">
					</c:otherwise>
				</c:choose>
			</div>
		</div>

		<div id="navigation">
			<h2>카테고리</h2>
			<ul>
			<c:forEach items="${categoryVo}" var="vo"> 
				<li><a href="">${vo.CATENAME}</a></li> 
			</c:forEach>
			</ul>
		</div>

		<div id="footer">
			<p>
				<strong>Spring 이야기</strong> is powered by JBlog (c)2019
			</p>
		</div>

	</div>
</body>

<script type="text/javascript">



</script>
</html>