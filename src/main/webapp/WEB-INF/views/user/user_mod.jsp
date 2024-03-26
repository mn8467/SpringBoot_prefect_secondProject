<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>ARMS - 마이페이지</title>
<jsp:include page="/WEB-INF/cmn/header.jsp"></jsp:include>

<style>
.button {
	width: auto;
	/* 버튼의 크기를 내용에 맞게 자동으로 조절합니다. */
	/* 다른 스타일을 원하는 대로 추가할 수 있습니다. */
	padding: 10px 20px;
	/* 내용과 버튼의 테두리 간격을 조정합니다. */
	border: none;
	text-align: center;
	text-decoration: none;
	display: inline-block;
	font-size: 16px;
	cursor: pointer;
	border-radius: 8px;
	background-color: #3986ff
}
</style>
<style>
#regDt {
	width: 200px;
}

.hidden {
	display: none;
}
</style>

<!-- chart -->
<style>
#chartdiv1 {
	width: 100%;
	height: 500px;
}

.basicselect {
	border: 1px solid #ced4da; /* 테두리 선 스타일 및 색상 지정 */
	border-radius: .25rem; /* 테두리 모서리를 둥글게 만듭니다. */
	padding: .375rem .75rem; /* 콘텐츠와 테두리 사이의 간격을 조정합니다. */
	line-height: 1.5; /* 텍스트 라인 높이를 설정합니다. */
	transition: border-color .15s ease-in-out, box-shadow .15s ease-in-out;
	/* 테두리 색상이 변할 때 부드럽게 전환되도록 지정합니다. */
}
</style>

<style>
#stepcountchartdiv {
	width: 100%;
	height: 350px;
}
</style>


<title>마이페이지</title>

</head>
<body>

	<!-- Spinner Start -->
	<div id="spinner"
		class="show w-100 vh-100 bg-white position-fixed translate-middle top-50 start-50  d-flex align-items-center justify-content-center">
		<div class="spinner-grow text-primary" role="status"></div>
	</div>
	<!-- Spinner End -->




	<!-- Modal Search Start -->
	<div class="modal fade" id="searchModal" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-fullscreen">
			<div class="modal-content rounded-0">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">Search by
						keyword</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body d-flex align-items-center">
					<div class="input-group w-75 mx-auto d-flex">
						<input type="search" class="form-control p-3"
							placeholder="keywords" aria-describedby="search-icon-1">
						<span id="search-icon-1" class="input-group-text p-3"><i
							class="fa fa-search"></i></span>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- Modal Search End -->

	<%--   <jsp:include page="/WEB-INF/cmn/header.jsp"></jsp:include>
  <jsp:include page="/WEB-INF/cmn/nav.jsp"></jsp:include> --%>

	<div class="container">
		<!-- 제목 -->
		<div class="row">
			<div class="col-lg-12">
				<c:choose>
					<c:when
						test="${sessionScope.user.role == 20 || sessionScope.user.role == 30}">
						<h2 class="page-header" style="text-align: center;">마이페이지</h2>
					</c:when>
					<c:otherwise>
						<h2 class="page-header" style="text-align: center;">회원 정보</h2>
					</c:otherwise>
				</c:choose>

			</div>
		</div>

		<!--// 제목 ----------------------------------------------------------------->
		<!-- 버튼 -->
		<div class="row justify-content-end">
			<div class="col-auto">
				<input type="button" class="btn btn-primary" value="수정"
					id="doUpdate" onclick="window.doUpdate();"> <input
					type="button" class="btn btn-primary" value="삭제" id="doDelete"
					onclick="window.doDelete();"> <input type="button"
					class="btn btn-primary" value="목록" id="moveToList"
					onclick="window.moveToList();">
			</div>
		</div>
		<!--// 버튼 ----------------------------------------------------------------->

		<!-- 회원 등록영역 -->
		<!-- 삼항연산자 사용해봄 -->
		<div class="row">
			<div class="container col-md-6">
				<form action="#" name="userRegFrm">
					<div class="mb-3">
						<label for="email" class="form-label">이메일</label> <input
							type="text" class="form-control ppl_input" readonly="readonly"
							name="email" id="email"
							value="${outVO != null ? outVO.email : userSession.email}"
							size="20" maxlength="30">
					</div>

					<div class="mb-3">
						<label for="password" class="form-label">비밀번호</label> <input
							type="password" class="hidden" readonly="readonly"
							name="password" id="password"
							value="${outVO != null ? outVO.password : userSession.password}"
							size="20" maxlength="30"><br>
						<c:choose>
							<c:when
								test="${sessionScope.user.role == 20 || sessionScope.user.role == 30}">
								<input type="button" value="변경하기" class="btn btn-primary"
									id="passwordReset">
							</c:when>
							<c:otherwise>
								<input type="button" value="변경하기" class="btn btn-primary"
									id="passwordReset" disabled>
							</c:otherwise>
						</c:choose>

					</div>

					<div class="mb-3">
						<!--  아래쪽으로  여백 -->
						<label for="name" class="form-label">이름</label> <input type="text"
							class="form-control" name="name" id="name"
							placeholder="이름을 입력 하세요." size="20"
							value="${outVO != null ? outVO.name : userSession.name}"
							maxlength="21">
					</div>

					<div class="mb-3">
						<label for="tel" class="form-label">전화번호</label> <input
							type="text" class="form-control" name="tel" id="tel"
							placeholder="전화번호 수정"
							value="${outVO != null ? outVO.tel : userSession.tel}" size="20"
							maxlength="11">
					</div>
					<br>
					<div class="mb-3">
						<label for="gender" class="form-label">성별</label> <select
							id="gender" name="gender" class="basicselect">
							<!-- 검색 조건 옵션을 동적으로 생성 -->
							<c:forEach items="${gender}" var="vo">
								<option value="<c:out value='${vo.detCode}'/>"
									${outVO != null ? (vo.detCode eq outVO.gender ? 'selected' : '') : (userSession.gender eq vo.detCode ? 'selected' : '')}>
									<c:out value="${vo.detName}" />
								</option>
							</c:forEach>
						</select> <label for="edu" class="form-label">학력</label> <select
							id="education" name="education" class="basicselect">
							<!-- 검색 조건 옵션을 동적으로 생성 -->
							<c:forEach items="${education}" var="vo">
								<option value="<c:out value='${vo.detCode}'/>"
									${outVO != null ? (vo.detCode eq outVO.edu ? 'selected' : '') : (userSession.edu eq vo.detCode ? 'selected' : '')}>
									<c:out value="${vo.detName}" />
								</option>
							</c:forEach>
						</select>
					</div>
					<br>
					<c:choose>
						<c:when
							test="${sessionScope.user.role == 20 || sessionScope.user.role == 30}">
							<div class="mb-3 hidden">
								<label for="role" class="form-label">역할</label> <select
									id="role" name="role" class="basicselect">
									<!-- 검색 조건 옵션을 동적으로 생성 -->
									<c:forEach items="${role1}" var="vo">
										<option value="<c:out value='${vo.detCode}'/>"
											${outVO != null ? (vo.detCode eq outVO.role ? 'selected' : '') : (userSession.edu eq vo.detCode ? 'selected' : '')}>
											<c:out value="${vo.detName}" />
										</option>
									</c:forEach>
								</select>
							</div>
						</c:when>
						<c:otherwise>
							<div class="mb-3">
								<label for="role" class="form-label">역할</label> <select
									id="role" name="role" class="basicselect">
									<!-- 검색 조건 옵션을 동적으로 생성 -->
									<c:forEach items="${role1}" var="vo">
										<option value="<c:out value='${vo.detCode}'/>"
											${outVO != null ? (vo.detCode eq outVO.role ? 'selected' : '') : (userSession.edu eq vo.detCode ? 'selected' : '')}>
											<c:out value="${vo.detName}" />
										</option>
									</c:forEach>
								</select>`
							</div>
							<br>
							<input type="hidden" class="form-control" id="status"
								name="status"
								value="${outVO != null ? outVO.status : userSession.status}"
								size="20" maxlength="11">

							<div class="mb-3">
								<input type="button"
									value="${outVO.status == '0' ? '정지해제' : '활동정지'}"
									class="btn btn-primary" id="doPauseUser"
									onclick="window.doPauseUser();">
							</div>

						</c:otherwise>
					</c:choose>


					<c:if test="${sessionScope.user.role == 30}">
						<div class="row">
							<!-- 라이센스 부분 -->
							<div class="col-md-6">
								<label for="licenses" class="form-label">자격증</label> <select
									id="licenses" name="licenses" class="form-select">
									<!-- 검색 조건 옵션을 동적으로 생성 -->
									<c:forEach items="${licenses}" var="vo">
										<option value="${vo.licensesSeq}">${vo.licensesName}</option>
									</c:forEach>
								</select>
							</div>

								<div class="col-md-6">
									<label for="regDt" class="form-label">등록일</label>
									<div class="input-group">
										<input type="date" id="regDt" name="regDt"
											class="form-control">
										<button type="button" class="btn btn-primary"
											id="doSaveLicenses">선택</button>
									</div>
								</div>

						</div>

						<!-- 선택한 자격증에 대한 목록을 표시할 테이블 -->
						<table id="licensesList" class="table table-responsive">
							<thead>
								<tr>
									<th>자격증명</th>
									<th>등록일</th>
									<th>취소</th>
								</tr>
							</thead>
							<tbody id="tableTbody">
								<c:choose>
									<c:when test="${userLicenses.size()>0}">
										<c:forEach var="vo" items="${userLicenses}">
											<tr>
												<td class="hidden">${vo.licensesSeq}</td>
												<td>${vo.licensesName}</td>
												<td>${vo.regDt}</td>
												<td><button class="deleteRowBtn btn"
														style="margin-bottom: 5px">
														<img src="${CP}/resources/template/img/x.png" alt="삭제"
															style="width: 20px; height: 20px;">
													</button>
											</tr>
										</c:forEach>
									</c:when>
								</c:choose>
							</tbody>
						</table>
					</c:if>
				</form>
			</div>
			<!--// 회원 등록영역 ------------------------------------------------------>
			<!-- chart -->
			<c:if test="${sessionScope.user.role == 30}">
				<div class="container col-md-6 mt-4">
					<div class="col-sm">
						<!-- Area Chart -->
						<h5 align="center">과목 점수</h5>
						<div id="chartdiv1"></div>
					</div>
				</div>
			</c:if>

			<c:if test="${sessionScope.user.role == 20}">
				<input type="hidden" value="${sessionScope.user.email}"
					id="emailval">
				<div class="container col-md-6 mt-4">
					<div class="col-sm">
						<!-- Area Chart -->
						<h5 align="center">출석 현황</h5>
						<div id="stepcountchartdiv"></div>
					</div>
				</div>
			</c:if>
		</div>
	</div>


	<script>
		document.getElementById("passwordReset").addEventListener("click",
				function() {
					// 여기에 이동할 URL을 설정합니다.
					var setPasswordUrl = "search/searchPasswordView.do";

					// 새 창에서 URL을 엽니다.
					window.location.href = setPasswordUrl;
				});

		function doDelete() {
			console.log("----------------------");
			console.log("-doDelete()-");
			console.log("----------------------");

			let email = document.querySelector("#email").value;
			console.log("email:" + email);

			if (eUtil.isEmpty(email) == true) {
				alert('아이디를 입력 하세요.');
				document.querySelector("#email").focus();
				return;
			}

			if (window.confirm('삭제 하시겠습니까?') == false) {
				return;
			}
			console.log("-confirm:");
			$.ajax({
				type : "GET",
				url : "/user/doDelete.do",
				asyn : "true",
				dataType : "json", /*return dataType: json으로 return */
				data : {
					"email" : email
				},
				success : function(data) {//통신 성공
					console.log("success data:" + data);
					//let parsedJSON = JSON.parse(data);
					if ("1" === data.msgId) {
						alert(data.msgContents);
						moveToList();
					} else {
						alert(data.msgContents);
					}

				},
				error : function(data) {//실패시 처리
					console.log("error:" + data);
				},
				complete : function(data) {//성공/실패와 관계없이 수행!
					console.log("complete:" + data);
				}
			});
		}

		function doPauseUser() {
			console.log("----------------------");
			console.log("-doPauseUser()-");
			console.log("----------------------");

			let email = document.querySelector("#email").value;
			console.log("email:" + email);

			let status = document.querySelector("#status").value;
			console.log("status:" + status);

			if (status == 0)
				status = 1;
			else
				status = 0;

			console.log("status:" + status);

			if (window.confirm(email + '의 활동상태를 바꾸시겠습니까?') == false) {
				return;
			}
			console.log("-confirm:");
			$.ajax({
				type : "POST",
				url : "/user/doPauseUser.do",
				asyn : "true",
				dataType : "html", /*return dataType: json으로 return */
				data : {
					"status" : status,
					"email" : email
				},
				success : function(data) {//통신 성공
					console.log("success data:" + data);
					//let parsedJSON = JSON.parse(data);
					alert(email + '의 활동상태를 변경하였습니다.');
					window.location.reload();

				},
				error : function(data) {//실패시 처리
					console.log("error:" + data);
				},
				complete : function(data) {//성공/실패와 관계없이 수행!
					console.log("complete:" + data);
				}
			});
		}

		function moveToList() {
			console.log("----------------------");
			console.log("-moveToList()-");
			console.log("----------------------");

			window.location.href = "/user/doRetrieve.do";
		}

		function doUpdate() {
			console.log("----------------------");
			console.log("-doUpdate()-");
			console.log("----------------------");

			//javascript
			console.log("javascript email:"
					+ document.querySelector("#email").value);
			console.log("javascript ppl_input:"
					+ document.querySelector(".ppl_input").value);

			//$("#email").val() : jquery id선택자
			//$(".email")

			console.log("jquery email:" + $("#email").val());
			console.log("jquery ppl_input:" + $(".ppl_input").val());

			if (eUtil.isEmpty(document.querySelector("#email").value) == true) {
				alert('아이디를 입력 하세요.');
				//$("#email").focus();//사용자 id에 포커스
				document.querySelector("#email").focus();
				return;
			}

			if (eUtil.isEmpty(document.querySelector("#name").value) == true) {
				alert('이름을 입력 하세요.');
				//$("#email").focus();//사용자 email에 포커스
				document.querySelector("#name").focus();
				return;
			}

			if (eUtil.isEmpty(document.querySelector("#password").value) == true) {
				alert('비밀번호를 입력 하세요.');
				//$("#email").focus();//사용자 email에 포커스
				document.querySelector("#password").focus();
				return;
			}

			if (eUtil.isEmpty(document.querySelector("#tel").value) == true) {
				alert('전화번호을 입력 하세요.');
				//$("#email").focus();//사용자 email에 포커스
				document.querySelector("#tel").focus();
				return;
			}

			if (eUtil.isEmpty(document.querySelector("#education").value) == true) {
				alert('학력을 입력 하세요.');
				//$("#email").focus();//사용자 email에 포커스
				document.querySelector("#education").focus();
				return;
			}

			if (eUtil.isEmpty(document.querySelector("#role").value) == true) {
				alert('역할을 입력 하세요.');
				//$("#email").focus();//사용자 email에 포커스
				document.querySelector("#role").focus();
				return;
			}

			//confirm
			if (confirm("수정 하시겠습니까?") == false)
				return;

			$.ajax({
				type : "POST",
				url : "/user/doUpdate.do",
				asyn : "true",
				dataType : "html",
				data : {
					email : document.querySelector("#email").value,
					name : document.querySelector("#name").value,
					password : document.querySelector("#password").value,
					tel : document.querySelector("#tel").value,
					edu : document.querySelector("#education").value,
					role : document.querySelector("#role").value,
					gender : document.querySelector("#gender").value,
				},
				success : function(data) {//통신 성공     
					console.log("success data:" + data);
					//data:{"msgId":"1","msgContents":"dd가 등록 되었습니다.","no":0,"totalCnt":0,"pageSize":0,"pageNo":0}
					let parsedJSON = JSON.parse(data);
					if ("1" === parsedJSON.msgId) {
						alert(parsedJSON.msgContents);
						moveToList();
					} else {
						alert(parsedJSON.msgContents);
					}

				},
				error : function(data) {//실패시 처리
					console.log("error:" + data);
				},
				complete : function(data) {//성공/실패와 관계없이 수행!
					console.log("complete:" + data);
				}
			});

		}
		$(document)
				.ready(
						function() {

							var selectedLicenses = [];
							// 선택 버튼 클릭 시
							$('#doSaveLicenses')
									.click(
											function() {
												console
														.log('licensesdoSave click');
												var licensesSeq = $('#licenses')
														.val();
												var licenseName = $(
														'#licenses option:selected')
														.text();
												var regDt = $('#regDt').val(); // 등록일 가져오기

												// 등록일 유효성 검사
												if (!validateDate(regDt)) {
													return;
												}

												// 이미 선택된 자격증인지 확인
												$('#tableTbody tr')
														.each(
																function() {
																	var licenseSeq = $(
																			this)
																			.find(
																					'td:first')
																			.text();
																	selectedLicenses
																			.push(licenseSeq);
																});

												if (selectedLicenses
														.includes(licensesSeq)) {
													alert('이미 선택된 자격증입니다.');
													return; // 이미 선택된 자격증이면 함수 종료
												}

												// AJAX 요청 - 선택 버튼 클릭 시 수행할 작업
												$
														.ajax({
															type : "POST",
															url : "/licenses/doSave.do",
															async : true,
															dataType : "json",
															data : {
																licensesSeq : licensesSeq,
																email : $(
																		"#email")
																		.val(),
																regDt : regDt
															},
															success : function(
																	data) { // 통신 성공
																console
																		.log("success data:"
																				+ data);
																selectedLicenses
																		.push(licensesSeq);
																// AJAX 요청 완료 후 페이지 리로드
																location
																		.reload(); // 페이지 리로드
															},
															error : function(
																	data) { // 실패시 처리
																console
																		.log("error:"
																				+ data);
															},
															complete : function(
																	data) { // 성공/실패와 관계없이 수행!
																console
																		.log("complete:"
																				+ data);
															}
														});

												// 표에 추가
												var newRow = '<tr><td data-license-seq="' + licensesSeq + '">'
														+ licenseName
														+ '</td><td>'
														+ regDt
														+ '</td><td><button class="deleteRowBtn">삭제</button></td></tr>';
												$('#licensesList tbody')
														.append(newRow);
											});

							// 삭제 버튼 클릭 시
							$(document)
									.on(
											'click',
											'.deleteRowBtn',
											function() {
												console
														.log('deleteRowBtn click');
												var licensesSeqText = $(this)
														.closest('tr').find(
																'td:first')
														.text();
												var licensesSeq = parseInt(licensesSeqText);

												// 배열에서 해당 자격증 제거
												var index = selectedLicenses
														.indexOf(licensesSeq);
												if (index !== -1) {
													selectedLicenses.splice(
															index, 1);
												}
												// 테이블에서 행 제거
												$(this).closest('tr').remove();

												// AJAX를 사용하여 선택된 자격증을 삭제하는 요청 보내기
												$
														.ajax({
															type : "POST",
															url : "/licenses/doDelete.do",
															async : true,
															dataType : "json",
															data : {
																licensesSeq : licensesSeq,
																email : $(
																		"#email")
																		.val()
															},
															success : function(
																	data) { // 통신 성공
																console
																		.log("success data:"
																				+ data);
																$(this)
																		.closest(
																				'tr')
																		.remove();
																// AJAX 요청 완료 후 페이지 리로드
																location
																		.reload(); // 페이지 리로드
															},
															error : function(
																	data) { // 실패시 처리
																console
																		.log("error:"
																				+ data);
																// 실패 처리를 추가할 수 있습니다.
															},
															complete : function(
																	data) { // 성공/실패와 관계없이 수행!
																console
																		.log("complete:"
																				+ data);
															}
														});
											});

							// 등록일 유효성 검사 함수
							function validateDate(dateString) {
								var regex = /^\d{4}-\d{2}-\d{2}$/; // YYYY-MM-DD 형식의 정규식
								if (!regex.test(dateString)) {
									alert('날짜 형식이 올바르지 않습니다. (YYYY-MM-DD)');
									return false;
								}

								var parts = dateString.split('-');
								var year = parseInt(parts[0]);
								var month = parseInt(parts[1]);
								var day = parseInt(parts[2]);

								if (isNaN(year) || isNaN(month) || isNaN(day)) {
									alert('숫자 형식이 아닌 값이 포함되어 있습니다.');
									return false;
								}

								return true;
							}
						});
	</script>


	<!--  chart Resources -->
	<script src="https://cdn.amcharts.com/lib/5/index.js"></script>
	<script src="https://cdn.amcharts.com/lib/5/xy.js"></script>
	<script src="https://cdn.amcharts.com/lib/5/radar.js"></script>
	<script src="https://cdn.amcharts.com/lib/5/themes/Animated.js"></script>
	<script src="/static/js/amchart.js" type="text/javascript"></script>
	<script src="/static/js/countchart.js" type="text/javascript"></script>


	<jsp:include page="/WEB-INF/cmn/footer.jsp"></jsp:include>
</body>
</html>