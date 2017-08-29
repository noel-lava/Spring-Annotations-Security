<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page isELIgnored="false" %> 
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>Login</title>
        <link href="<c:url value='/resources/font-awesome-4.7.0/css/font-awesome.css'/>" rel="stylesheet"/>
    </head>
 
    <body>
        <br/><br/>
        <div style="text-align: center; width:50%; margin: auto">
            <div style="width: 50%; margin: auto;">
                <c:url var="loginUrl" value="/login" />
                <form action="${loginUrl}" method="post">
                    <c:if test="${param.error != null}">
                        <div style="color: red;font-size: 12px;">
                            <p>Invalid username and password.</p>
                        </div>
                    </c:if>
                    <c:if test="${param.logout != null}">
                        <div>
                            <p style="color: green;font-size: 12px;">You have been logged out successfully.</p>
                        </div>
                    </c:if>
                    <div>
                        <label for="username"><i class="fa fa-user"></i></label>
                        <input type="text" name="username" placeholder="Enter Username" required>
                    </div>
                    <div>
                        <label for="password"><i class="fa fa-lock"></i></label> 
                        <input type="password" name="password" placeholder="Enter Password" required>
                    </div>
                    <input type="hidden" name="${_csrf.parameterName}"  value="${_csrf.token}" />
                         
                    <div>
                        <input style="width:75%" type="submit" value="Login">
                    </div>
                </form>
            </div>
        </div>
 
    </body>
</html>