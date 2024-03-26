<%@page import="com.example.test_prefect.model.StringUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!doctype html>
<html>
<head>
<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="https://kit.fontawesome.com/53a8c415f1.js"
	crossorigin="anonymous"></script>
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script src="/static/js/eUtil.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>

<!-- Bootstrap CSS -->
<link rel="stylesheet" href="/static/template/login/assets/css/bootstrap.min.css" type="text/css">
<!-- FontAwesome CSS -->
<link rel="stylesheet" href="/static/template/login/assets/css/all.min.css" type="text/css">
<link rel="stylesheet" href="/static/template/login/assets/css/uf-style.css" type="text/css">
<style>
.arms-container {
    display: flex; /* 항목들을 가로로 정렬 */
    align-items: center; /* 항목들을 세로 중앙에 위치 */
}
body.swal2-height-auto {
  height: 100% !important
}

</style>
<script>
$(document).ready(function(){
    console.log("ready!");
    
    
    
    $("#doLogin").on("click", function(e){
        e.preventDefault(); // Prevent form submission
        console.log("doLogin click!");
        
        let email = document.querySelector("#email").value;
        if(eUtil.isEmpty(email)){
        	Swal.fire("아이디를 입력 하세요", "","warning");
            //document.querySelector("#email").focus();
            return;
        }
        console.log("email:" + email);
        
        let password = document.querySelector("#password").value;
        if(eUtil.isEmpty(password)){
        	Swal.fire("비밀번호를 입력 하세요", "","warning");
            //document.querySelector("#password").focus();
            return;
        }
        console.log("password:" + password);
        //window.confirm 
        Swal.fire({
            title: '로그인 하시겠습니까?',
            icon: 'question',
            showCancelButton: true,
            confirmButtonColor: '#6fa1ff',
            cancelButtonColor: '#cccccc',
            confirmButtonText: '예',
            cancelButtonText: '아니오'
        }).then((result) => {
            if (result.isConfirmed) {
                $.ajax({
                    type: "POST",
                    url: "/login/doLogin.do",
                    async: true,
                    dataType: "json",
                    data: {
                        "email": email,
                        "password": password
                    },
                    success: function(data){
                        console.log("data.msgId:" + data.msgId);
                        console.log("data.msgContents:" + data.msgContents);
                        
                        if("10" == data.msgId){
                        	Swal.fire(data.msgContents, "","error");
                            document.querySelector("#email").focus();
                        } else if("20" == data.msgId){
                        	Swal.fire(data.msgContents, "","error");
                            document.querySelector("#password").focus();
                        } else if("30" == data.msgId){
                        	Swal.fire(data.msgContents, "","success").then((value) => {
                                window.location.href = "/";
                            });
                        }
                        else if("40" == data.msgId){
                            Swal.fire(data.msgContents, "","success").then((value) => {
                                window.location.href = "/";
                            });
                        }
                        
                    },
                    error: function(data){
                        console.log("error:" + data);
                    },
                    complete: function(data){
                        console.log("complete:" + data);
                    }
                });
            }
        });
    });
});
</script>
<title>ARMS Login</title>
</head>

<body>
	<div class="uf-form-signin">
 		 <a href="/main.jsp" class="navbar-login">
           <div class="arms-container d-flex align-items-center">
              <img src="/static/template/img/acorn.png" alt="ARMS Logo" width="200" height="100">
           </div>
        </a>
		<form class="login-form" action="/login/doLogin.do" method="post">
			<div class="input-group uf-input-group input-group-lg mb-3">
				<span class="input-group-text fa fa-user"></span>
				<input type="text" id="email" name="email" class="form-control" placeholder="Email address">
			</div>
			<div class="d-flex mb-3 justify-content-between">
				<div class="form-check">
					<!-- 빈공간을 만들기 위함-->
				</div>
				<div class="search_email">
					<a href="/search/searchEmailView.do">이메일 찾기</a>
				</div>
			</div>
			<div class="input-group uf-input-group input-group-lg mb-3">
				<span class="input-group-text fa fa-lock"></span>
				<input type="password" id="password" name="password" class="form-control" placeholder="Password">
			</div>
			<div class="d-flex mb-3 justify-content-between">
				<div class="form-check">
					<!-- 빈공간을 만들기 위함-->
				</div>
				<a href="/search/searchPasswordView.do">비밀번호 찾기</a>
			</div>
			<div class="d-grid mb-4">
				<button type="submit" class="btn uf-btn-primary btn-lg" id="doLogin">  로   그   인  </button>
			</div>
			<div class="d-flex mb-3">
				<div class="dropdown-divider m-auto w-25"></div>
				<small class="text-nowrap text-white">다른 방법 로그인</small>
				<div class="dropdown-divider m-auto w-25"></div>
			</div>
			<div class="mt-4 text-center">
				<span class="text-white">회원이 아니신가요?</span> <a
					href="/user/moveToReg.do">회원가입</a>
			</div>
		</form>
	</div>

</body>
</html>