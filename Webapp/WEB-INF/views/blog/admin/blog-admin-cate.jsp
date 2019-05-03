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
					<li class="selected"><a href="${pageContext.request.contextPath }/${authUser.id}/admin/cate">카테고리</a></li>
					<li><a href="${pageContext.request.contextPath }/${authUser.id}/admin/basic/write">글작성</a></li>
				</ul>

				<table class="admin-cat">
					<thead>
						<tr>
							<th>번호</th>
							<th>카테고리명</th>
							<th>포스트 수</th>
							<th>설명</th>
							<th>삭제</th>
						</tr>
					</thead>
					<tbody id=cateList>
						
					</tbody>
				</table>

				<h4 class="n-c">새로운 카테고리 추가</h4>
				<table id="admin-cat-add">
					<tr>
						<td class="t">카테고리명</td>
						<td><input type="text" name="name" value=""></td>
					</tr>
					<tr>
						<td class="t">설명</td>
						<td><input type="text" name="desc"></td>
					</tr>
					<tr>
						<td class="s">&nbsp;</td>
						<td><input id="btnAddCate" type="submit" value="카테고리 추가"></td>
					</tr>
				</table>

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
	$(document).ready(function() { //레디될때 기능을 넣어줌.그리기직전
			
		$.ajax({
			url : "${pageContext.request.contextPath }/${authUser.id}/admin/basic/category", //컨트롤주소
			type : "get",
			//contentType : "application/json", //보낼데이터의 형태
		   //뒤에 데이터 붙어가는 뒤에가var email
			//데이터안가져오고 시키기만하면되니			

			//여기부턴 받을때
			dataType : "json",
			success : function(categoryList) {
				/*성공시 처리해야될 코드 작성*/
				console.log("리스트받아",categoryList);

				for (var i = 0; i < categoryList.length; i++) {
					render(categoryList[i], "down");
				}

			},
			error : function(XHR, status, error) {
				console.error(status + " : " + error);
			}
		})

	});

	$("#btnAddCate").on("click", function(){
		var CATENAME = $("[name=name]").val();
		var DESCRIPTION = $("[name=desc]").val();
		
		$.ajax({
			url : "${pageContext.request.contextPath }/${authUser.id}/admin/basic/cateadd", //컨트롤주소
			type : "post",
			/*contentType : "application/json", //보낼데이터의 형태*/
			data : {CATENAME:CATENAME, DESCRIPTION:DESCRIPTION},  //뒤에 데이터 붙어가는 뒤에가var email
			//데이터안가져오고 시키기만하면되니			

			//여기부턴 받을때
			dataType : "json",
			success : function(category) {
				/*성공시 처리해야될 코드 작성*/
				console.log(category);
				render(category, "up");
	
			},
			error : function(XHR, status, error) {
				console.error(status + " : " + error);
			}
		});

	});
	
	
	//삭제
	$("#cateList").on("click","#btn-del", function(){
		$this = $(this);
		
		console.log("btn_de클릭");
		var CATENO = $this.data("cateno");
		var delpoint = "#delform"+CATENO;
		
		//if(postcnt = 0){
	 	$.ajax({
			url : "${pageContext.request.contextPath }/${authUser.id}/admin/basic/delete", //컨트롤주소
			type : "post",
			//contentType : "application/json", //보낼데이터의 형태
			data : {CATENO:CATENO},  
			//데이터안가져오고 시키기만하면되니			

			//여기부턴 받을때
			dataType : "json",
			success : function(count) {
				
				$(delpoint).remove();
				
				
			}
		}); 
		
	   	
	});

	//데이터 그리기 함수 정의부분
 	function render(CategoryVo, updown) {
		var str = "";
		str += "	<tr id='delform" + CategoryVo.cateno + "'>";
		str += "		<td>" + CategoryVo.cateno + "</td>";
		str += "		<td>" + CategoryVo.catename + "</td>";
		str += "		<td>" + CategoryVo.postcnt + "</td>";
		str += "		<td>" + CategoryVo.description + "</td>";
		str += "		<td><img class='btn_cateDel' data-cateno='" + CategoryVo.cateno + "' id='btn-del' style='curser:pointer' src='${pageContext.request.contextPath }/assets/images/delete.jpg'></td>";
		str += "	</tr>";

		if (updown == "up") {
			$("#cateList").prepend(str);
		} else if ((updown == "down")) {
			$("#cateList").append(str);
		} else {
			console.log("오류");
		}		

	} 
</script>
</html>
