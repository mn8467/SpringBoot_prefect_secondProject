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
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"><link rel="stylesheet" href="/static/template/login/assets/css/bootstrap.min.css" type="text/css"><link rel="stylesheet" href="/static/template/login/assets/css/fontawesome-all.min.css" type="text/css"><link rel="stylesheet" href="/static/template/login/assets/css/uf-style.css" type="text/css">
<script src="http://code.jquery.com/jquery-latest.js"></script>
<title>비밀번호 찾기</title>
<style>
body {
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
    text-align: end;
    margin-bottom: 30px;
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
    margin-top: 1.05rem
}
.btn-secondary:hover {
    background-color: #545b62;
}
.form-control {
    margin-bottom: 15px;
}
.select-wrapper select {
    width: 100%;
    padding: 10px 15px;
    border: 1px solid #ddd;
    border-radius: 5px;
    background-color: #fff;
    font-size: 16px;
    color: #333;
    appearance: none;
}
.select-wrapper::after {
    content: '▼';
    position: absolute;
    top: 50%;
    right: 15px;
    transform: translateY(-50%);
    pointer-events: none;
    color: #333;
}
.find-email-link {
	magint-top : 10px;
    color: #007bff;
    text-decoration: underline;
}
</style>
</head>
<body>
    <div class="uf-form-signin col-md-6">
 		 <a href="/" class="navbar-brand">
            <div class="arms-container d-flex align-items-center">
             <img src="/static/template/img/acorn.png" alt="ARMS Logo" width="150" height="75">
           </div>    
        </a>
        <h1 class="h3 mb-3 font-weight-normal">비밀번호 인증</h1>
        <!-- 비밀번호 찾기 양식 -->
        <form>
            <div class="mb-3">
                <label for="name" class="form-label">이름</label>
                <input type="text" id="name" class="form-control" placeholder="이름을 입력하세요" required autofocus>
            </div>
            <div class="mb-3 email-form">
                <label for="userEmail1" class="form-label">이메일</label>
                <div class="input-group">
                    <input type="text" class="form-control" id="userEmail1" placeholder="이메일" required>
                    <select class="form-control" id="userEmail2">
                        <option>@naver.com</option>
                        <option>@daum.net</option>
                        <option>@gmail.com</option>
                        <option>@hanmail.net</option>
                        <option>@yahoo.co.kr</option>
                    </select>
                </div>
                <button type="button" class="btn btn-primary mt-2" id="mail-Check-Btn">본인인증</button>
            </div>
            <div class="mb-3 mail-check-box">
                <input class="form-control mail-check-input" placeholder="인증번호 6자리를 입력해주세요!" disabled="disabled" maxlength="6">
            </div>
            </form>
            <span id="mail-check-warn"></span><br>
            <button class="btn btn-lgg btn-primary btn-block mt-3" id="searchPasswordResult" onclick="moveToChangePassword()" disabled>비밀번호 변경</button>
            <button class="btn btn-lgg btn-secondary btn-block" onclick="history.go(-1);">취소</button>
        	<div class="d-flex mb-3 justify-content-between">
				<div class="form-check">
					<!-- 빈공간을 만들기 위함-->
				</div>
				<div class="search_email">
					<br>
					<div class="email-reminder">
					    이메일이 기억나지 않는다면?<a href="/search/searchEmailView.do">  이메일 찾기</a>
					</div>		
				</div>
			</div>
    </div>
     <script type="text/javascript">
     $(document).ready(function(){
         console.log("ready!");
         
         //이메일 인증, 이름, 이메일 있는지 확인
         $('#mail-Check-Btn').click(function() {
             const email = $('#userEmail1').val() + $('#userEmail2').val(); // 이메일 주소값 얻어오기!
             console.log('완성된 이메일 : ' + email); // 이메일 오는지 확인
             const checkInput = $('.mail-check-input') // 인증번호 입력하는곳 
             
             let name = $("#name").val();
             if(name.trim() === ""){
                 alert('이름을 입력하세요.');
                 $("#name").focus();
                 return;
             }
             console.log("이름:" + name);
             
             if($('#userEmail1').val() === ""){
                 alert('이메일을 입력하세요.');
                 $("#email").focus();
                 return;
             }
             console.log("이메일:" + email);
             
             $.ajax({
                 type: "POST",
                 url: "/user/search/searchPassword.do",
                 async: true,
                 dataType: "json",
                 data: {
                     "name": name,
                     "email": email
                 },
                 success: function(data){
                     console.log("data.msgId:" + data.msgId);
                     console.log("data.msgContents:" + data.msgContents);
                     
                     if("10" == data.msgId){
                         alert(data.msgContents);
                         $("#name").focus();
                     } else if("20" == data.msgId){
                         alert(data.msgContents);
                         $("#userEmail1").focus();                 
                     } else if("30" == data.msgId){
                    	 
                    	 //이름, 이메일  있으면 인증 이메일 보내기
                    	 $.ajax({
                             type : 'get',
                             url : '/user/search/findPassword.do?email='+email, // GET방식이라 Url 뒤에 email을 붙일 수 있다.
                             success : function (data) {
                                 console.log("data : " +  data);
                                 checkInput.attr('disabled',false);
                                 code =data;
                                 alert('인증번호가 전송되었습니다.')
                             }           
                         }); // end ajax
                     }
                 },
                 error: function(data){
                     console.log("error:" + data);
                 },
                 complete: function(data){
                     console.log("complete:" + data);
                 }
             });
            
         }); // end send eamil

         // 인증번호 비교 
         // blur -> focus가 벗어나는 경우 발생
         $('.mail-check-input').blur(function () {
             const inputCode = $(this).val();
             const $resultMsg = $('#mail-check-warn');
             const findBtn = $('#searchPasswordResult');
             
             if(inputCode == code){
                 $resultMsg.html('인증번호가 일치합니다.');
                 $resultMsg.css('color','green');
                 $('#mail-Check-Btn').attr('disabled',true);
                 $('#userEamil1').attr('readonly',true);
                 $('#userEamil2').attr('readonly',true);
                 $('#userEmail2').attr('onFocus', 'this.initialSelect = this.selectedIndex');
                 $('#userEmail2').attr('onChange', 'this.selectedIndex = this.initialSelect');
                 findBtn.attr('disabled',false);
             }else{
                 $resultMsg.html('인증번호가 불일치 합니다. 다시 확인해주세요!.');
                 $resultMsg.css('color','red');
             }
         });
         
         $("#searchPasswordResult").on("click",function(e){
             console.log("searchPasswordResult click!");
             const email = $('#userEmail1').val() + $('#userEmail2').val(); // 이메일 주소값 얻어오기!
             window.location.href ="/user/search/changePassword.do?email=" +email;
         });
     });

     </script>
</body>
</html>