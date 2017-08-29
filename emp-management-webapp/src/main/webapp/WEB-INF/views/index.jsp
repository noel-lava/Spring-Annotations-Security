<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@ page isELIgnored="false" %> 
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <meta name="_csrf" content="${_csrf.token}"/>
        <meta name="_csrf_header" content="${_csrf.headerName}"/>
        <title>Employee Management</title>
        <link href="<c:url value='/resources/font-awesome-4.7.0/css/font-awesome.css'/>" rel="stylesheet"/>
    </head>
    
    <style>
        table.solid, tr.solid > td {
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
        <h1 style="text-align: center;">Employee Management</h1>
        
        
            <div style="width: 80%;margin: auto">
                <form action="home" method="Post">
                    <table width="100%;">
                        <tr>
                            <td colspan="2" style="text-align: right">
                                <i style="color: red;">${searchResult}</i>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <select name="sortBy" id="sortBy">
                                    <option value="3" ${sortBy == 3 ? 'selected="selected"' : ''}>
                                        <spring:message code='field.lastName'/>
                                    </option>
                                    <option value="1" ${sortBy == 1 ? 'selected="selected"' : ''}>
                                        GWA
                                    </option>
                                    <option value="2" ${sortBy == 2 ? 'selected="selected"' : ''}>
                                        <spring:message code='field.dateHired'/>
                                    </option>
                                </select>
                                <button type="button" onClick="sortList();"><spring:message code='message.sort'/></button>
                            </td>
                            <td style="text-align: right;"> 
                                <security:authorize access="hasAnyRole('ADMIN', 'EMPLOYEE_ADMIN')">
                                    <input name="searchId" type="number" min="1"/>
                                    <input type="submit" name="search" value="<spring:message code='message.search'/>"/>
                                </security:authorize>
                            </td>
                        </tr>
                    </table>
                    <br/>
                    <div style="height: 70%;">
                        <table width="100%" style="text-align: center;" class="solid" id="personList"></table>
                    </div>
                    <div style="text-align: center;color: green;" id="deleteResult">${deleteResult}</div>
                    <input type="hidden" name="${_csrf.parameterName}"  value="${_csrf.token}" />
                </form>
                <br/>
                <div style="text-align: right;">
                    <security:authorize access="hasAnyRole('ADMIN', 'EMPLOYEE_ADMIN')">
                        <button onclick="location.href='manage-person/add'" type="button"><spring:message code='message.newEmployee'/></button>
                    </security:authorize>
                    <security:authorize url="/roles">
                    <button onclick="location.href='roles'" type="button"><spring:message code='message.manageRoles'/></button>
                    </security:authorize>
                </div>
            </div>
    </body>

    <script src="<c:url value='/resources/js/jquery-2.1.1.js'/>"></script>
    <script>
        $(function () {
            var token = $("meta[name='_csrf']").attr("content");
            var header = $("meta[name='_csrf_header']").attr("content");
            $(document).ajaxSend(function(e, xhr, options) {
                xhr.setRequestHeader(header, token);
            });
        });

        function clicked(e) { if(!confirm('Are you sure?')){e.preventDefault(); return}}

        $().ready(function(){
            sortList();
        });

        function sortList() {
            var response = "<tr class='solid'><th>ID</th><th><spring:message code='field.lastName' text='Last Name' /></th>" +
                        "<th><spring:message code='field.firstName' text='First Name' /></th><th>GWA</th><th><spring:message code='field.dateHired' text='Date Hired' /></th>" +
                        "<security:authorize access='hasAnyRole(&quot;ADMIN&quot;, &quot;EMPLOYEE_ADMIN&quot;)'><th colspan=2><spring:message code='message.action' text='Action' /></th></security:authorize>" + 
                        "</tr>";
            $.ajax({
                url : 'rest/populate-list',
                method : 'GET',
                contentType: 'application/json; charset=utf-8',
                data :{"sortBy" : $("#sortBy").val()},
                dataType:'json',
                success: function (data) {
                    //populate list
                    if(data.length > 0) {
                        $.each(data,function(key, obj){
                            response += "<tr id='person-" + obj["id"] + "' class='solid'><td>" + obj["id"] + "</td>";
                            response += "<td>" + obj["name"]["lastName"] + "</td>";
                            response += "<td>" + obj["name"]["firstName"] + "</td>";
                            response += "<td>" + obj["gwa"] + "</td>";
                            response += "<td>" + obj["dateHiredToString"] + "</td>";
                            response += "<security:authorize access='hasAnyRole(&quot;ADMIN&quot;, &quot;EMPLOYEE_ADMIN&quot;)'><td width=50px><a href='home/" + obj["id"] + "' style='cursor: pointer;color:green;' class='icon-block'><i class='fa fa-pencil-square-o' aria-hidden='true'></i></a></td>";
                            response += "<td width=50px><a onclick='deletePerson(" + obj['id'] + ")' style='cursor: pointer;color:red;' class='icon-block'><i class='fa fa-trash-o' aria-hidden='true'></i></a></td></security:authorize></tr>";
                        });
                    } else {
                        response += "<tr class='solid'><td colspan='6' style='color: red;'>No persons found</td></tr>";
                    }

                    $("#personList").html(response);      
                }
            });
        }

        function deletePerson(id) {
            if(confirm('Are you sure?')) {
                $.ajax({
                    url : 'rest/delete-person?delete='+id,
                    method : 'DELETE',
                    contentType: 'application/json; charset=utf-8',
                    dataType:'json',
                    success: function (data) {
                        $("#person-"+id).remove();
                        $("#deleteResult").html("<i style='color: green;'>" + data["deleteResult"] + "</i>");      
                    }
                });
            }
        }
    </script>
</html> 