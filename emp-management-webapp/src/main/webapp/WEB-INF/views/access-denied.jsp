<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@ page isELIgnored="false" %> 
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>Access Denied</title>
</head>
<body>
    <p style="text-align:right;font-size: 12px;"><a href="<c:url value='/home'/>">HOME</a></p>
    <br/>
    <h2 style="text-align: center">Sorry, You are not authorized to access this page.</h2>
</body>
</html>