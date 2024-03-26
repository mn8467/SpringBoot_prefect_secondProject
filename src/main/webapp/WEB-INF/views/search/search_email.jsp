<%@page import="com.example.test_prefect.model.StringUtil"%>
<%@page import="com.example.test_prefect.model.BoardVO"%>
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
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="/static/template/login/assets/css/bootstrap.min.css" type="text/css">
<link rel="stylesheet" href="/static/template/login/assets/css/fontawesome-all.min.css" type="text/css">
<link rel="stylesheet" href="/static/template/login/assets/css/uf-style.css" type="text/css">
<script src="http://code.jquery.com/jquery-latest.js"></script>
<title>이메일 찾기</title>
<style>


body {
	margin : -100px;
    background-color: #f7f8fa;
    color: #495057;
}
.uf-form-signin {
    max-width: 400px;
    padding: 15px;
    margin: 100px auto;
    background-color: white;
    border-radius: 5px;
}
.uf-form-signin h1 {
    text-align: right;
    margin-bottom: 30px;
    margin-top: 4px;
    font-size : 23px
}
.form-label {
    font-weight: bold;
}
.btn-primary {
    background-color: #007bff;
    border: none;
}
.btn-primary:hover {
    background-color: #0056b3;
}
.btn-secondary {
    background-color: #6c757d;
    border: none;
}
.btn-secondary:hover {
    background-color: #545b62;
}
.form-control {
    margin-bottom: 15px;
}
</style>
</head>
<body>
    <div class="uf-form-signin">
   		 <a href="/" class="navbar-brand">
            <div class="arms-container d-flex align-items-center">
             <img src="/static/template/img/acorn.png" alt="ARMS Logo" width="150" height="75">
           </div>    
        </a>
        <h1 class="h3 mb-3 font-weight-normal">이메일 찾기</h1>
        <form>
            <div class="mb-3">
                <label for="name" class="form-label">이름</label>
                <input type="text" id="name" class="form-control" placeholder="이름을 입력하세요" required autofocus>
            </div>
            <div class="mb-3">
                <label for="tel" class="form-label">전화번호</label>
                <input type="text" id="tel" class="form-control" placeholder="전화번호를 입력하세요" required>
            </div>
            <button class="btn btn-lgg btn-primary btn-block" type="submit" id="searchEmailResult">이메일 확인</button>
            <button class="btn btn-lgg btn-secondary btn-block" onclick="history.go(-1);">취소</button>
        </form>
    </div>
     <script type="text/javascript">
		$(document).ready(function(){
		    console.log("ready!");
		
		    // 버튼의 type을 'button'으로 변경했습니다.
		    $("#searchEmailResult").on("click",function(e){
		        e.preventDefault(); // 폼 제출을 막기 위해 추가
		        console.log("searchEmailResult click!");
		
		        let name = $("#name").val().trim();
		        if(name === ""){
		            alert('이름을 입력하세요.');
		            $("#name").focus();
		            return;
		        }
		        console.log("이름:" + name);
		
		        let tel = $("#tel").val().trim();
		        if(tel === ""){
		            alert('전화번호를 입력하세요.');
		            $("#tel").focus();
		            return;
		        }
		        console.log("전화번호:" + tel);
		
		        if(confirm("이메일을 확인하시겠습니까?") === false) return;
		        $.ajax({
		            type: "POST",
		            url: "/user/search/searchEmail.do",
		            async: true,
		            dataType: "json",
		            data: {
		                "name": name,
		                "tel": tel
		            },
		            success: function(data){
		                console.log("data.msgId:" + data.msgId);
		                console.log("data.msgContents:" + data.msgContents);
		
		                if("10" == data.msgId){
		                    alert(data.msgContents);
		                    $("#name").focus();
		                } else if("20" == data.msgId){
		                    alert(data.msgContents);
		                    $("#tel").focus();                 
		                } else if("30" == data.msgId){
		                    window.location.href = "/user/search/searchEmailResultView.do";
		                }
		            },
		            error: function(data){
		                console.log("error:" + data);
		            },
		            complete: function(data){
		                console.log("complete:" + data);
		            }
		        });
		    });
		});
	</script>

</body>
</html>