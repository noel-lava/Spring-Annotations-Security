<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@ page isELIgnored="false" %> 
<!DOCTYPE html>
<html>
    <head>
        <title>Employee Management</title>
        <link href="<c:url value='/resources/font-awesome-4.7.0/css/font-awesome.css'/>" rel="stylesheet"/>
        <meta name="_csrf" content="${_csrf.token}"/>
        <meta name="_csrf_header" content="${_csrf.headerName}"/>
    </head>
    <style>
        table.solid, tr.solid > td {
            border: 1px solid black;
            border-collapse: collapse;
        }
        
        th {
             border: 3px solid black;
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
        <h1 style="text-align: center;"><spring:message code='message.roles'/></h1>
        <div style="width: 60%; text-align: center; margin: auto;">
            <div>   
                <form:form action="roles" method="post" modelAttribute="rolesForm">            
                    <div style="height: 80%;">
                        <table width="100%" style="text-align: center;" class="solid">
                            <tr class="solid">
                                <th width="20%"><spring:message code='message.code'/></th>
                                <th width="85%;"><spring:message code='message.role'/></th>
                                <th><spring:message code='message.delete'/></th>
                            </tr>
                            <c:choose>
                                <c:when test="${not empty rolesForm.roles}">
                                <c:forEach var="role" items="${rolesForm.roles}" varStatus="status">
                                <tr class="solid" id="role-${role.id}">
                                    <td>
                                        <input type="hidden" name="roles[${status.index}].id" value="${role.id}"/>
                                        <input type="hidden" name="roles[${status.index}].code" value="${role.code}"/>
                                        ${role.code}
                                    </td>
                                    <td>
                                        <input style="width: 90%;" type="text" name="roles[${status.index}].roleDesc" value="${role.roleDesc}"/>
                                    </td>
                                    <td>
                                        <input id="delete-${role.id}" type="hidden" name="roles[${status.index}].deleted" value="${role.deleted}"/>
                                        <a onclick="deleteRole(${role.id})" class="icon-block" style="cursor: pointer;color:red;"><i class="fa fa-trash-o" aria-hidden="true"></i></a>
                                    </td>
                                </tr>
                                </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr class="solid">
                                        <td colspan="4" style="color: red;">No Roles Found</td>
                                    </tr>
                                </c:otherwise>
                            </c:choose>
                        </table>
                        <br/>
                        <div style="text-align: left; width: 100%; margin: auto;">
                            <label for="newCode"><spring:message code='message.code'/>  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: </label>
                            <input style="width: 15%;" type="text" id="newCode" name="newCode"/><br/>
                            <label for="newRole"><spring:message code='message.description'/> : </label>
                            <input style="width:25%;" type="text" name="newRole" id="newRole"/><br/>
                            <table width="100%">
                                <tr>
                                    <td>
                                        <input type="submit" name="addNewRole" value="<spring:message code='message.addNewRole'/>" onclick="clicked(event)"/>
                                    </td>
                                    <td style="text-align: right;">
                                        <input type="submit" name="update" value="<spring:message code='message.save'/>">
                                    </td>
                                </tr>
                                <tr>
                                    <td style="text-align: left;">
                                        <i style="color:green;">${goodAdd}</i>
                                        <i style="color:red;">${badAdd}</i>
                                    </td>
                                    <td style="text-align: right;">
                                        <i style="color:green;">${goodUpdate}</i>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                    <input type="hidden" name="${_csrf.parameterName}"  value="${_csrf.token}" />
                </form:form>
            </div>
            <br/><br/>       
            <div style="height: 80%;">
                <div style="text-align: left;">
                    <select name="filterBy" id="filterList"></select>
                    <button type="button" onClick="filterByRole()"><spring:message code='message.filter'/></button>
                </div>
                <table width="100%" style="text-align: center;" class="solid" id="personsWithRole"></table>
            </div>
            <br/>

            <div style="text-align: center;">
                <i style="color: red;">${operationResult}</i>
                <i style="color: green;">${goodResult}</i>
            </div>

            <br/><br/>
            <div style="text-align: right;">
                <button onclick="location.href='home'" type="button"><spring:message code='message.done'/></button>
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
        
        function clicked(e) { if(!confirm('Are you sure?'))e.preventDefault(); }

        $().ready(function(){
            getRoleList();
        });

        function getRoleList() {
            $.ajax({
                url : 'roles/rest/populate-roles',
                method : 'GET',
                contentType : 'application/json',
                dataType : 'json',
                success: function(data) {
                    var response = "";
                    $.each(data, function(key, obj){
                        response += "<option value='" + obj["id"] + "'>" + obj["roleDesc"] + "</option>"
                    });

                    $("#filterList").html(response);
                    filterByRole();
                }
            });
        }

        function filterByRole() {
            var response = "<tr class='solid'><th width='20%'>ID</th><th width='80%'><spring:message code='field.firstName'/></th></tr>";
            $.ajax({
                url : 'roles/rest/populate-person-role',
                method : 'GET',
                contentType : 'application/json',
                data : {filterBy: $("#filterList").val()},
                dataType : 'json',
                success : function (data) {
                    if(data.length > 0) {
                        $.each(data, function(key,obj){
                            response += "<tr class='solid'>" + 
                                            "<td>" + obj["id"] + "</td>" +
                                            "<td>" + obj["name"]["lastName"] + ", " + obj["name"]["firstName"] + "</td>" +
                                        "</tr>";
                        });
                    } else {
                        response += "<tr class='solid'> <td colspan='2' style='color: red;'>No persons found with this role</td> </tr>";
                    }
                    $("#personsWithRole").html(response);
                },
                error : function (data) {
                    alert(JSON.stringify(data))
                }
            });
        }

        function deleteRole(roleId) {
            $("#delete-"+roleId).val(true);
            $("#role-"+roleId).hide();
        }
    </script>
</html> 