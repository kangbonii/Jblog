<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<link rel="stylesheet" href="${pageContext.request.contextPath }/assets/css/jblog.css">
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
					<li><a href="${pageContext.request.contextPath }/${authUser.id}/admin/basic">기본설정</a></li>
					<li><a href="${pageContext.request.contextPath }/${authUser.id}/admin/cate">카테고리</a></li>
					<li class="selected"><a href="${pageContext.request.contextPath }/${authUser.id}/admin/basic/write">글작성</a></li>
				</ul>
				
				
				<form action="${pageContext.request.contextPath }/{id}/admin/basic/writeform" method="post">
			      	<table class="admin-cat-write">
			      		<tr>
			      			<td class="t">제목</td>
			      			<td>
			      				<input type="text" size="60" name="postTitle">
			      				 
				      			<select name="cateNo">
				      			<c:forEach items="${categoryVo}" var="vo"> 
			      					<option value="${vo.CATENO}">${vo.CATENAME}</option>
			      				</c:forEach>
				      			</select>
				      			
				      		</td>
			      		</tr>
			      		<tr>
			      			<td class="t">내용</td>
			      			<td><textarea name="postContent"></textarea></td>
			      		</tr>
			      		<tr>
			      			<td>&nbsp;</td>
			      			<td class="s"><input type="submit" value="포스트하기"></td>
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

</html>