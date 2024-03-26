<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- error page선언
     page  isErrorPage="true"

 --%>
<%@ page  isErrorPage="true" %>  
<%@taglib  prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set  var="CP" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="${CP}/resources/css/user.css">
<title>PCWK</title>
</head>
<body>
    <h2>Exception</h2>
    <div>
        <table>
            <thead>
                <tr>
                    <th>구분</th>
                    <th>설명</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>상태코드</td>
                    <td><c:out value="${requestScope['javax.servlet.error.status_code']}"></c:out>  </td>
                </tr>
                <tr>
                    <td>예외이름</td>
                    <td><c:out value="${requestScope['javax.servlet.error.exception']}"></c:out>  </td>
                </tr>        
                <tr>
                    <td>예외 메시지</td>
                    <td><c:out value="${requestScope['javax.servlet.error.message']}"></c:out>  </td>
                </tr>
                <tr>
                    <td>요청URI</td>
                    <td><c:out value="${requestScope['javax.servlet.error.request_uri']}"></c:out>  </td>
                </tr>                                             
            </tbody>   
        </table>
    </div>
    
</body>
</html>