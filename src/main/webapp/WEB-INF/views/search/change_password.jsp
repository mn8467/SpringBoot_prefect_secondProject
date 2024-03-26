<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="CP" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/WEB-INF/cmn/header.jsp"></jsp:include>
<style>
#regDt {
    width: 200px;
}

.hidden {
    display: none;
}
</style>
<title>마이페이지</title>
<script>

	function moveToLoginPage() {
		console.log("----------------------");
		console.log("-moveToLoginPage()-");
		console.log("----------------------");

		window.location.href = "/login/loginView.do";
	}

	function doUpdatePassword() {
		console.log("----------------------");
		console.log("-doUpdatePassword()-");
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

		console.log("javascript password:"
				+ document.querySelector("#user-password").value);
		
		if (eUtil.isEmpty(document.querySelector("#user-password").value) == true) {
			alert('비밀번호를 입력 하세요.');
			//$("#email").focus();//사용자 email에 포커스
			document.querySelector("#user-password").focus();
			return;
		}

		//confirm
		if (confirm("수정 하시겠습니까?") == false)
			return;

		$.ajax({
			type : "POST",
			url : "/user/doUpdatePassword.do",
			asyn : "true",
			dataType : "html",
			data : {
				email : document.querySelector("#email").value,
				password : document.querySelector("#user-password").value
			},
			success : function(data) {//통신 성공     
				console.log("success data:" + data);
				//data:{"msgId":"1","msgContents":"dd가 등록 되었습니다.","no":0,"totalCnt":0,"pageSize":0,"pageNo":0}
				let parsedJSON = JSON.parse(data);
				if ("1" === parsedJSON.msgId) {
					alert(parsedJSON.msgContents);
					moveToLoginPage();
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

</script>
</head>
<body>
	<%--   <jsp:include page="/WEB-INF/cmn/header.jsp"></jsp:include>
  <jsp:include page="/WEB-INF/cmn/nav.jsp"></jsp:include> --%>
 
	<div class="container">
		<!-- 제목 -->
		<div class="row">
			<div class="col-lg-12">
				<h1 class="page-header">비밀번호 변경</h1>
			</div>
		</div>
		<!--// 제목 ----------------------------------------------------------------->
		<!-- 버튼 -->
		<div class="row justify-content-end">
			<div class="col-auto">
				<input type="button" class="btn btn-primary" value="수정"
					id="doUpdatePassword" onclick="window.doUpdatePassword();"> 
			</div>
		</div>
		<!--// 버튼 ----------------------------------------------------------------->

		<!-- 회원 등록영역 -->
		<div>
			<form action="#" name="userRegFrm">
				<div class="mb-3">
					<label for="email" class="form-label">이메일</label> <input
						type="text" class="form-control ppl_input" readonly="readonly"
						name="email" id="email" value="${user.email }" size="20"
						maxlength="30">
				</div>
				<div class="mb-3">
					<label for="password" class="form-label">비밀번호</label>
                   <input type="password"  class="form-control"  name="password" id="user-password" placeholder="비밀번호를 입력 하세요." size="20"  maxlength="30" required oninput="passwordCheck()">
                   <span class="password_ok" style="color:green; display:none;">사용 가능한 비밀번호입니다.</span>
                   <span class="password_notok" style="color:red; display:none;"> 8글자 이상, 영문, 숫자, 특수문자를 사용해주세요.</span>
				</div>
			</form>
		</div>
		<!--// 회원 등록영역 ------------------------------------------------------>

	</div>
	<jsp:include page="/WEB-INF/cmn/footer.jsp"></jsp:include>
	<script>
	     function strongPassword(str) {
	         return /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$/.test(str);
	     }
	
	     function passwordCheck() {
	         var str = document.querySelector("#user-password").value; // 값을 가져와야 함
	         if (strongPassword(str) === true) { // 문자열을 전달해야 함
	             $('.password_ok').css("display", "inline-block");
	             $('.password_notok').css("display", "none");
	             console.log('----비밀번호 인정----')
	            
	         } else {
	             $('.password_notok').css("display", "inline-block");
	             $('.password_ok').css("display", "none");
	         }
	     }
	
	     function passwordReCheck(){
	         var str1 = document.querySelector("#user-password").value;
	         var str2 = document.querySelector("#user-password2").value;
	
	         if(str1 === str2){
	             $('.ok-ok').css("display", "inline-block");
	             $('.ok-no').css("display", "none");
	            document.querySelector("#passwordCheckYet").value = 1;
	
	         }else{
	             $('.ok-no').css("display", "inline-block");
	             $('.ok-ok').css("display", "none");
	         }
	     }
     </script>
</body>
</html>
