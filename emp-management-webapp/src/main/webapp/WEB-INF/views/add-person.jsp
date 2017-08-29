<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<%@ page isELIgnored="false" %> 
<html>
    <head>
        <title>Employee Management</title>
        <link href="<c:url value='/resources/font-awesome-4.7.0/css/font-awesome.css'/>" rel="stylesheet"/>
        <meta name="_csrf" content="${_csrf.token}"/>
        <meta name="_csrf_header" content="${_csrf.headerName}"/>
    </head>

    <style>
        table .solid, tr.solid > td {
            border: 1px solid black;
            border-collapse: collapse;
        }
        
        th {
             border: 3px solid black;
        }

        a.icon-block {
            display:inline-block;
            /*width:10em;*/
            text-align:center;
            color: red;
        }
    </style>
    
    <body>
        <table width="100%;">
            <tr>
                <td>
                    <span style="font-size: 12px;">Language : <a href="?language=en">English</a>|<a href="?language=ph">Filipino</a></span><br/>
                    <span style="font-size: 12px;">Current Locale : ${pageContext.response.locale}</span>
                </td><td style="text-align: right;font-size: 12px;">
                    <strong ><security:authentication property="principal.username"/> | </strong><a href="<c:url value="/logout" />">Logout</a>
                </td>
            </tr>
        </table>
        <h1 style="text-align: center;"><spring:message code='message.newEmployee'/></h1>
        <form:form action="add" method="post" modelAttribute="person" enctype="multipart/form-data" id="form">
            <div style="width: 80%; margin: auto; text-align: center;">
                <table width="50%" style="margin: auto;">
                    <tr>
                        <td style="width: 50%;" colspan="2">
                            <table width="100%">
                                <tr>
                                    <td style="text-align: right;"><label for="lastName"><spring:message code='field.lastName'/></label></td>
                                    <td>
                                        <form:input id="lastName" type="text" path="name.lastName" value="${lastName}" style="width: 90%;" required="required"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="text-align: right;"><label for="firstName"><spring:message code='field.firstName'/></label></td>
                                    <td><form:input id="firstName" type="text" path="name.firstName" value="${firstName}" style="width: 90%;" required="required"/></td>
                                </tr>
                                <tr>
                                    <td style="text-align: right;"><label for="midName"><spring:message code='field.middleName'/></label></td>
                                    <td><form:input id="midName" type="text" path="name.midName" value="${midName}" style="width: 90%;" /></td>
                                </tr>
                                <tr>
                                    <td style="text-align: right;"><label for="suffix"><spring:message code='field.suffix'/></label></td>
                                    <td><form:input id="suffix" type="text" path="name.suffix" value="${suffix}" style="width: 90%;" /></td>
                                </tr>
                                <tr>
                                    <td style="text-align: right;"><label for="title"><spring:message code='field.title'/></label></td>
                                    <td><form:input id="title" type="text" path="name.title" value="${title}" style="width: 90%;" /></td>
                                </tr>
                                <tr>
                                    <td style="text-align: right;"><label for="birthDate"><spring:message code='field.birthDate'/></label></td>
                                    <td><form:input id="birthDate" type="date" path="birthDate" value="${birthDate}" style="width: 90%;" required="required"/></td>
                                </tr>
                                <tr>
                                    <td style="text-align: right;"><label for="gwa"><spring:message code='field.GWA'/></label></td>
                                    <td><form:input id="gwa" type="number" path="gwa" value="${gwa}" min="0" max="100" step="0.01" style="width: 90%;" /></td>
                                </tr>
                                <tr>
                                    <td style="text-align: right;"><label for="dateHired"><spring:message code='field.dateHired'/></label></td>
                                    <td><form:input id="dateHired" type="date" path="dateHired" value="${dateHired}" style="width: 90%;" /></td>
                                </tr>
                                <tr>
                                    <td style="text-align: right;"><label for="employed"><spring:message code='field.employed'/></label></td>
                                    <td>
                                        <form:select id="employed" path="employed" style="width: 93%;">
                                            <form:option value="true"><spring:message code='field.true'/></form:option>
                                            <form:option value="false"><spring:message code='field.false'/></form:option>
                                        </form:select>
                                    </td>
                                </tr>
                                <tr><td>&nbsp;</td></tr>
                                <tr>
                                    <!-- ADDRESS -->
                                    <td style="text-align: right;"><label for="street"><spring:message code='field.street'/></label></td>
                                    <td><form:input id="street" type="text" path="address.street" value="${street}" style="width: 90%;" /></td>
                                </tr>
                                <tr>
                                    <td style="text-align: right;"><label for="barangay"><spring:message code='field.barangay'/></label></td>
                                    <td><form:input id="barangay" type="text" path="address.barangay" value="${barangay}" style="width: 90%;" /></td>
                                </tr>
                                <tr>
                                    <td style="text-align: right;"><label for="municipality"><spring:message code='field.municipality'/></label></td>
                                    <td><form:input id="municipality" type="text" path="address.municipality" value="${municipality}" style="width: 90%;" required="required"/></td>
                                </tr>
                                <tr>
                                    <td style="text-align: right;"><label for="zipCode"><spring:message code='field.zipCode'/></label></td>
                                    <td><form:input id="zipCode" type="number" path="address.zipCode" value="${zipCode}" style="width: 90%;" /></td>
                                </tr>
                                <tr><td>&nbsp;</td></tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: left;">
                            <input type="file" name="empProfile"/><br/>
                            <button type="button" id="uploadFile" onClick="uploadEmployee()"><spring:message code='message.upload'/></button>
                            <i id="file-error" style="color: red"></i>
                        </td>
                        <td style="text-align: right;">
                            <i style="color: red">${addResult}</i><br/>
                            <button onclick="location.href='../home';" type="button"><spring:message code='message.cancel'/></button>
                            <input onclick="clicked(event)" type="submit" name="addPerson" value="<spring:message code='message.submit'/>"/>
                        </td>
                    </tr>
                </table>
            </div>
            <input type="hidden" name="${_csrf.parameterName}"  value="${_csrf.token}" />
        </form:form>
    </body>
    <script src="<c:url value='/resources/js/jquery-2.1.1.js'/>"></script>
    <script src="<c:url value='/resources/js-webshim/minified/polyfiller.js'/>"></script>
    <script>
        webshims.setOptions('forms-ext', {types: 'date'});
        webshims.polyfill('forms forms-ext');
    </script>
    <script>
        $(function () {
            var token = $("meta[name='_csrf']").attr("content");
            var header = $("meta[name='_csrf_header']").attr("content");
            $(document).ajaxSend(function(e, xhr, options) {
                xhr.setRequestHeader(header, token);
            });
        });

        function clicked(e) {
            if(!confirm('Are you sure?'))e.preventDefault();
        }

        function uploadEmployee(){
            var form = $("#form")[0];
            var data = new FormData(form);

            $.ajax({
                type: "POST",
                enctype: 'multipart/form-data',
                url: "rest/upload-person?",
                data: data,
                processData: false,
                contentType: false,
                cache: false,
                timeout: 600000,
                headers : {},
                success: function (data) {
                    if(data == "manage-person") {
                        window.location.href = "../"+data;
                    } else {
                        $("#file-error").html(data);
                    }
                },
                error: function (e) {
                    $("#file-error").html(data);
                }
            });
        }

    </script>
</html> 