<%@ page import="com.example.test_prefect.model.UserVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>  
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="CP" value="${pageContext.request.contextPath}" scope="page" />  
<!DOCTYPE html>
<html>
<head>
 <meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"><link rel="stylesheet" href="/static/template/login/assets/css/bootstrap.min.css" type="text/css"><link rel="stylesheet" href="/static/template/login/assets/css/fontawesome-all.min.css" type="text/css"><link rel="stylesheet" href="/static/template/login/assets/css/uf-style.css" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script>
    $(document).ready(function() {
        // '로그인 화면으로 돌아가기' 버튼에 클릭 이벤트 리스너 추가
        $('#goToLogin').click(function() {
            // 지정된 URL로 페이지 이동
            window.location.href = '/login/loginView.do';
        });
    });
</script>

<head>
<meta charset="UTF-8">
<title>이메일 검색 결과</title>
<style>
       .resultWrap {
            width: 100%;
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .emailResult {
            width: 40%;
            background: white;
            border-radius: 20px;
            padding: 20px;
            text-align: center;
        }
    </style>

</head>

<body>
   <div class="resultWrap">
    <div class="emailResult">
        <h3>이메일 검색 결과</h3>
        <% 
            UserVO user = (UserVO) session.getAttribute("user");
            if(user != null && user.getEmail() != null && !user.getEmail().isEmpty()) {
        %>
       
                <p><strong><%= user.getEmail() %></strong></p>
        <%  } else { %>
                <p>검색된 이메일 정보가 없습니다.</p>
        <%  } %>
		<button class="btn btn-lg btn-primary btn-block" type="button" id="goToLogin">로그인 화면으로 돌아가기</button>
    </div>
</div>

</body>
</html>