<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="${pageContext.request.contextPath }/assets/css/jblog.css">
<script type="text/javascript" src="${pageContext.request.contextPath }/assets/js/jquery/jquery-1.12.4.js"></script>
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
					<c:when test="${empty authUser }">
						<!-- 로그인 전 메뉴 -->
						<li><a href="${pageContext.request.contextPath }/user/loginform">로그인</a></li>
					</c:when>
					<c:otherwise>
						<!-- 로그인 후 메뉴 -->
						<li><a href="${pageContext.request.contextPath }/user/logout">로그아웃</a></li>

						<c:if test="${sessionScope.authUser.id == UserVo.id }">
							<li><a href="${pageContext.request.contextPath }/${authUser.id}/admin/basic">내블로그 관리</a></li>
						</c:if>
					</c:otherwise>
				</c:choose>
			</ul>
		</div>


		<div id="wrapper">
			<div id="content" class="full-screen">
				<ul class="admin-menu">
					<li class="selected"><a href="${pageContext.request.contextPath }/${authUser.id}/admin/basic">기본설정</a></li>
					<li><a href="${pageContext.request.contextPath }/${authUser.id}/admin/cate">카테고리</a></li>
					<li><a href="${pageContext.request.contextPath }/${authUser.id}/admin/basic/write">글작성</a></li>
				</ul>

				<form action="${pageContext.request.contextPath}/${authUser.id}/admin/basic/update" method="POST" enctype="multipart/form-data">
					<table class="admin-config">
						<tr>
							<td class="t">블로그 제목</td>
							<td><input type="text" size="40" name="blogTitle" value="${BlogVo.blogTitle}"></td>
						</tr>
						<tr>
							<td class="t">로고이미지</td>
							<c:choose>
								<c:when test="${empty BlogVo.logoFile}">
									<td><img src="${pageContext.request.contextPath }/assets/images/spring-logo.jpg" id="img"></td>
								</c:when>
								<c:otherwise>
									<td><img src="${pageContext.request.contextPath }/upload/${BlogVo.logoFile}" id="img"></td>
								</c:otherwise>
							</c:choose>
						</tr>
						<tr>
							<td class="t">&nbsp;</td>
							<td><input type="file" name="file" id="putfile"></td>
						</tr>
						<tr>
							<td class="t">&nbsp;</td>
							<td class="s"><input type="submit" value="기본설정 변경"></td>
						</tr>
					</table>
				</form>
			</div>
		</div>


		<div id="footer">
			<p>
				<strong>Spring 이야기</strong> is powered by JBlog (c)2019
			</p>
		</div>

	</div>
</body>

<script type="text/javascript">
    function readURL(input) {
        if (input.files && input.files[0]) {
            var reader = new FileReader();
            reader.onload = function(e) {
                $('#img').attr('src', e.target.result);
            }
            reader.readAsDataURL(input.files[0]);
        }
    }

    $("#putfile").change(function() {
        readURL(this);
    });
</script>

</html>