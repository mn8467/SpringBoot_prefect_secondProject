<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="CP" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="en">

<head>
<jsp:include page="/WEB-INF/cmn/header.jsp"></jsp:include>

<style>
#mainchartdiv {
	width: 100%;
	height: 350px;
}
</style>

<style>
#mainbarchartdiv {
	width: 100%;
	height: 350px;
}
</style>

<style>
#maindonutchartdiv {
	width: 100%;
	height: 350px;
}
</style>


<style>
#hardchartdiv {
	width: 100%;
	height: 350px;
}
</style>


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

	<br>
	<br>
	<br>
	<br>
	<br>
	<div class="container">
		<div class="row">
			<div class="col-sm">
				<br>
				<h5 align="center">학력 현황</h5>
				<div id="mainchartdiv"></div>
				<!-- 삼막대 그래프-->
			</div>

			<div class="col-sm">
				<br>
				<h5 align="center">IT계열 취업률</h5>
				<div id="mainbarchartdiv"></div>
				<!--막대글프 -->
			</div>
		</div>
	</div>
	<div class="container">
		<div class="row">
			<div class="col-sm">
				<br>
				<h5 align="center">남녀 현황</h5>
				<div id="maindonutchartdiv"></div>
				<!-- 삼막대 그래프-->
			</div>

			<div class="col-sm">
				<br>
				<h5 align="center">훈련 과정 현황</h5>
				<div id="hardchartdiv"></div>
				<!--막대글프 -->
			</div>
		</div>
	</div>

	<!-- Middle End -->
	<!-- Fact Start -->
	<div class="container-fluid py-5">
		<div class="container">
			<div class="bg-light p-5 rounded">
				<div class="row g-4 justify-content-center;">
					<div class="col-md-3 col-lg-3 col-xl-3">
						<div class="counter bg-white rounded p-5">
							<i class="fa fa-users text-secondary"></i>
							<h5>회원수</h5>
							<div class="d" style="font-size: 17px">${totalUsers}</div>
						</div>
					</div>
					<div class="col-md-3 col-lg-3 col-xl-3">
						<div class="counter bg-white rounded p-5">
							<i class="fa fa-users text-secondary"></i>
							<h5>접속률</h5>
							<div class="d" style="font-size: 17px">89%</div>
							</h1>
						</div>
					</div>
					<div class="col-md-3 col-lg-3 col-xl-3">
						<div class="counter bg-white rounded p-5">
							<i class="fa fa-users text-secondary"></i>
							<h5>채팅방에 있는 인원</h5>
							<div class="d" style="font-size: 17px">33</div>
							</h1>
						</div>
					</div>
					<div class="col-md-3 col-lg-3 col-xl-3">
						<div class="counter bg-white rounded p-5">
							<i class="fa fa-users text-secondary"></i>
							<h5>게시글 수</h5>
							<div class="d" style="font-size: 17px">${totalBoard}</div>
							</h1>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- Fact Start -->


	<!-- Tastimonial Start -->
	<div class="container-fluid testimonial py-5">
		<div class="container py-5">
			<div class="testimonial-header text-center">
				<h4 class="text-primary">인기 게시글</h4>
				<h1 class="display-5 mb-5 text-dark">Top 5</h1>
			</div>
			<div class="owl-carousel testimonial-carousel">

				<c:forEach var="board" items="${topBoards}">
					<div
						class="testimonial-item img-border-radius bg-light rounded p-4">
						<div class="position-relative">
							<i
								class="fa fa-quote-right fa-2x text-secondary position-absolute"
								style="bottom: 30px; right: 0;"></i>
							<div class="mb-4 pb-4 border-bottom border-secondary">
								${board.title}</div>
							<div class="d-flex align-items-center flex-nowrap">
								<div >
									<a
										href="/board/doSelectOne.do?seq=${board.seq}&div=20">게시물
										보기</a>
								</div>


								<div class="ms-4 d-block">
									<!-- 추가 정보를 여기에 표시할 수 있음 -->
								</div>
							</div>
						</div>
					</div>
				</c:forEach>

			</div>
		</div>
	</div>
	<!-- Tastimonial End -->

	<!-- Back to Top -->
	<a href="#"
		class="btn btn-primary border-3 border-primary rounded-circle back-to-top">
		<i class="fa fa-arrow-up"></i>
	</a>

	<jsp:include page="/WEB-INF/cmn/footer.jsp"></jsp:include>

	<!--  chart Resources -->
	<script src="https://cdn.amcharts.com/lib/5/index.js"></script>
	<script src="https://cdn.amcharts.com/lib/5/xy.js"></script>
	<script src="https://cdn.amcharts.com/lib/5/percent.js"></script>
	<script src="https://cdn.amcharts.com/lib/5/themes/Animated.js"></script>
	<script src="/static/js/piechart.js" type="text/javascript"></script>
	<script src="/static/js/barchart.js" type="text/javascript"></script>
	<script src="/static/js/donutchart.js" type="text/javascript"></script>
	<script src="/static/js/haedchart.js" type="text/javascript"></script>


</body>

<script>
	
</script>

</html>