<%@page import="com.example.test_prefect.model.StringUtil"%>
<%@ page import="com.example.test_prefect.model.UserVO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	UserVO dto = (UserVO) request.getAttribute("searchVO");
%>
<!DOCTYPE html>
<html>
<jsp:include page="/WEB-INF/cmn/header.jsp"></jsp:include>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="/resources/static/css/layout.css" rel="stylesheet" type="text/css">

<style>

/* 호버 가능한 행에 대한 스타일 */
.hoverable:hover {
	background-color: #f5f5f5; /* 마우스 호버 시 배경색 변경 */
	cursor: pointer; /* 클릭 가능한 항목임을 나타내는 커서 스타일 */
}

/* 툴팁 스타일 */
.tooltip {
	position: relative;
	display: inline-block;
}

.tooltip .tooltiptext {
	visibility: hidden;
	width: 120px;
	background-color: black;
	color: #fff;
	text-align: center;
	border-radius: 6px;
	padding: 5px 0;
	/* 위치 */
	position: absolute;
	z-index: 1;
	bottom: 100%;
	left: 50%;
	margin-left: -60px;
	/* 페이드인 효과 */
	opacity: 0;
	transition: opacity 0.6s;
}

.tooltip:hover .tooltiptext {
	visibility: visible;
	opacity: 1;
}

/* 테이블 스타일 */
.table {
	width: 100%;
	margin-bottom: 1rem;
	color: #212529;
}

.table th, .table td {
	padding: 0.75rem;
	vertical-align: top;
	border-top: 1px solid #dee2e6;
}

.data-cell {
	text-align: left; /* 텍스트를 왼쪽 정렬합니다. */
	padding-left: 20px; /* 왼쪽 패딩을 조정하여 내용을 오른쪽으로 조금 이동합니다. */
}

/* 테이블 헤더 스타일 */
.table thead th {
	vertical-align: bottom;
	border-bottom: 2px solid #dee2e6;
}

/* 테이블 바디 스타일 */
.table tbody+tbody {
	border-top: 2px solid #dee2e6;
}

/* 테이블 행 스타일 */
.table tr {
	display: table-row;
	vertical-align: inherit;
	border-color: inherit;
}

/* 페이지네이션 및 버튼 스타일 */
.pagination {
	display: flex;
	padding-left: 0;
	list-style: none;
	border-radius: 0.25rem;
}

.button {
	display: inline-block;
	font-weight: 400;
	color: #212529;
	text-align: center;
	vertical-align: middle;
	user-select: none;
	background-color: transparent;
	border: 1px solid transparent;
	padding: 0.375rem 0.75rem;
	font-size: 1rem;
	line-height: 1.5;
	border-radius: 0.25rem;
	transition: color 0.15s ease-in-out, background-color 0.15s ease-in-out,
		border-color 0.15s ease-in-out, box-shadow 0.15s ease-in-out;
}

.button:hover {
	color: #212529;
	background-color: #e9ecef;
	border-color: #dee2e6;
}
</style>
<script type="text/javascript">
<!-- 이 함수는 페이지를 로드 하기 전에 적용되야 하기에  이 함수만 위에서 작용 -->
	$(document).ready(function() {
		// 전화번호 형식을 변환하는 함수
		function formatPhoneNumber(phoneNumber) {
			//전화번호 사이에 숫자를 제외한 문자 삭제
			var cleaned = ('' + phoneNumber).replace(/\D/g, '');
			//정규식 함수를 이용 해서 010,1234,1234 3파트로 나누기
			var match = cleaned.match(/^(\d{3})(\d{4})(\d{4})$/);
			// 파트 사이마다 -를 적용
			if (match) {
				return match[1] + '-' + match[2] + '-' + match[3];
			}
			return null;
		}

		// 모든 전화번호에 대해 형식을 변환합니다.
		//$('.tel').each(function(){ 선언 함으로써 클래스에 tel이 붙은걸 찾아서 위 함수 적용
		$('.tel').each(function() {
			var formattedTel = formatPhoneNumber($(this).text());
			$(this).text(formattedTel);
		});
	});
</script>
</head>
<body>

	<!-- Spinner Start -->
	<div id="spinner"
		class="show w-100 vh-100 bg-white position-fixed translate-middle top-50 start-50  d-flex align-items-center justify-content-center">
		<div class="spinner-grow text-primary" role="status"></div>
	</div>
	<!-- Spinner End -->


	<div class="container">
		<!-- 제목 -->
		<div class="row">
			<div class="col-lg-12">
				<h2 class="page-header" style="text-align: center;">회원 조회</h2>
			</div>
		</div>
		<br> <br>
		<!--// 제목 ----------------------------------------------------------------->
		<form action="#" method="get" name="userFrm" style="display: inline;">
			<input type="hidden" name="pageNo">
			<!-- 검색구분 -->
			<div class="row g-1 justify-content-end ">
				<label for="searchDiv" class="col-auto col-form-label">검색조건</label>
				<div class="col-auto">
					<select name="searchDiv" id="searchDiv"
						class="form-select pcwk_select">
						<option value="">전체</option>
						<c:forEach var="vo" items="${userSearch }">
							<option value="<c:out value='${vo.detCode}'/>"
								<c:if test="${vo.detCode == searchVO.searchDiv }">selected</c:if>><c:out
									value="${vo.detName}" /></option>
						</c:forEach>
					</select>
				</div>
				<!-- 검색어 -->
				<div class="col-auto">
					<input type="text" class="form-control"
						value="${searchVO.searchWord }" name="searchWord" id="searchWord"
						placeholder="검색어를 입력하세요">
				</div>
				<div class="col-auto">
					<!-- pageSize: 10,20,30,50,10,200 -->
					<select class="form-select" id="pageSize" name="pageSize">
						<c:forEach var="vo" items="${pageSize }">
							<option value="<c:out value='${vo.detCode }' />"
								<c:if test="${vo.detCode == searchVO.pageSize }">selected</c:if>><c:out
									value='${vo.detName}' /></option>
						</c:forEach>
					</select>
				</div>
				<!-- button -->
				<div class="col-auto ">
					<!-- 열의 너비를 내용에 따라 자동으로 설정 -->
					<input type="button" class="btn btn-primary" value="조회"
						id="doRetrieve" onclick="window.doRetrieve(1);">
				</div>
			</div>
		</form>
		<br> <br>
		<!-- table -->
		<table class="table table-responsive" id="userTable">
			<thead>
				<tr>
					<th scope="col" class="text-center">번호</th>
					<th scope="col" class="text-center">사용자이메일</th>
					<th scope="col" class="text-center">이름</th>
					<th scope="col" class="text-center">전화번호</th>
					<th scope="col" class="text-center">학력</th>
					<th scope="col" class="text-center">성별</th>
					<th scope="col" class="text-center">역할</th>
				</tr>
			</thead>
			<tbody>
				<c:choose>
					<%-- 조회데이터가 있는 경우:jsp comment(html에 노출 않됨) --%>
					<c:when test="${not empty list }">
						<c:forEach var="vo" items="${list}">
							<tr>
								<td class="text-center">${vo.no}</td>
								<td class="text-center">${vo.email}</td>
								<td class="text-center">${vo.name }</td>
								<td class="text-center tel">${vo.tel }</td>
								<c:forEach items="${education}" var="eduVO">
									<c:if test="${eduVO.detCode == vo.edu}">
										<td class="text-center"><c:out value="${eduVO.detName}" />
										</td>
									</c:if>
								</c:forEach>
								<td class="text-center"><c:forEach items="${gender}"
										var="genderVO">
										<c:if test="${genderVO.detCode == vo.gender}">
											<c:out value="${genderVO.detName}" />
										</c:if>
									</c:forEach> <c:if test="${vo.gender == null}">
				                &nbsp; <!-- 성별이 null일 때 빈 칸을 표시 -->
									</c:if></td>
								<!-- 역할 -->
								<td class="text-center"><c:forEach items="${role}"
										var="roleVO">
										<c:if test="${roleVO.detCode == vo.role}">
											<c:out value="${roleVO.detName}" />
										</c:if>
									</c:forEach> <c:if test="${vo.role == null}">
				                &nbsp; <!-- 성별이 null일 때 빈 칸을 표시 -->
									</c:if></td>
							</tr>
						</c:forEach>
					</c:when>
					<%-- 조회데이터가 없는 경우:jsp comment(html에 노출 않됨) --%>
					<c:otherwise>
						<tr>
							<td colspan="6" class="text-center" style="border: none;">No
								data found.</td>
						</tr>
					</c:otherwise>


				</c:choose>
			</tbody>
		</table>
		<!--// table -------------------------------------------------------------->
		<!-- 페이징 : 함수로 페이징 처리 
         총글수, 페이지 번호, 페이지 사이즈, bottomCount, url,자바스크립트 함수
    -->

		<div class="container-fluid py-5">
			<div class="container">
				<div class="row">
					<div class="col-lg-12">
						<!-- Pagination -->
						<div class="pagination d-flex justify-content-center mt-5">
							<nav>${pageHtml }</nav>
						</div>
						<!-- End of Pagination -->
					</div>
				</div>
			</div>
		</div>
		<!--// 페이징 ---------------------------------------------------------------->



	</div>



	<script type="text/javascript">
		function pageDoRerive(url, pageNo) {
			console.log('url:' + url);
			console.log('pageNo:' + pageNo);

			let frm = document.forms['userFrm'];//form

			frm.pageNo.value = pageNo;
			//pageNo
			frm.action = url;
			//서버 전송
			frm.submit();
		}
		//jquery event감지
		$("#searchWord").on("keypress", function(e) {
			console.log('searchWord:keypress');
			//e.which : 13
			console.log(e.type + ':' + e.which);
			if (13 == e.which) {
				e.preventDefault();//버블링 중단
				doRetrieve(1);
			}
		});

		//jquery:table 데이터 선택     
		$("#userTable>tbody").on("dblclick", "tr", function(e) {
			console.log('----------------------------');
			console.log('userTable>tbody');
			console.log('----------------------------');

			let tdArray = $(this).children();//td

			let email = tdArray.eq(1).text();
			console.log('email:' + email);

			window.location.href = "/user/doSelectOne.do?email=" + email;

		});

		function moveToReg() {
			console.log('----------------------------');
			console.log('moveToReg');
			console.log('----------------------------');

			let frm = document.userFrm;
			frm.action = "login/moveToReg.do";
			frm.submit();

			//window.location.href= '/user/moveToReg.do';

		}

		function doRetrieve(pageNo) {
			console.log('----------------------------');
			console.log('doRetrieve');
			console.log('----------------------------');

			let frm = document.forms['userFrm'];//form
			let pageSize = frm.pageSize.value;
			console.log('pageSize:' + pageSize);

			let searchDiv = frm.searchDiv.value;
			console.log('searchDiv:' + searchDiv);

			let searchWord = frm.searchWord.value;
			console.log('searchWord:' + searchWord);

			console.log('pageNo:' + pageNo);
			frm.pageNo.value = pageNo;

			console.log('pageNo:' + frm.pageNo.value);
			//pageNo
			frm.action = "/user/doRetrieve.do";
			//서버 전송
			frm.submit();
		}
	</script>
	<jsp:include page="/WEB-INF/cmn/footer.jsp"></jsp:include>
</body>
</html>