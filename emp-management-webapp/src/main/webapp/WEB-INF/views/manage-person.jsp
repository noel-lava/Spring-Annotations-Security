<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
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
        <h1 style="text-align: center;"><spring:message code='message.manageEmployee'/></h1>
        <form:form action="manage-person" method="post" modelAttribute="person">
	        <div style="width: 80%; margin: auto; text-align: center;">
	        	<table width="100%">
	        		<tr>
			        	<td style="width: 50%;">
			        		<table width="100%">
			        			<tr>
				        			<td style="text-align: right;"><label for="lastName"><spring:message code='field.lastName'/></label></td>
						        	<td>
						        		<input id="lastName" type="text" name="name.lastName" value="${person.name.lastName}" style="width: 90%;" required="required"/>
						        	</td>
					        	</tr>
					        	<tr>
						        	<td style="text-align: right;"><label for="firstName"><spring:message code='field.firstName'/></label></td>
						        	<td><input id="firstName" type="text" name="name.firstName" value="${person.name.firstName}" style="width: 90%;" required="required"/></td>
					        	</tr>
					        	<tr>
						        	<td style="text-align: right;"><label for="midName"><spring:message code='field.middleName'/></label></td>
						        	<td><input id="midName" type="text" name="name.midName" value="${person.name.midName}" style="width: 90%;" /></td>
					        	</tr>
					        	<tr>
						        	<td style="text-align: right;"><label for="suffix"><spring:message code='field.suffix'/></label></td>
						        	<td><input id="suffix" type="text" name="name.suffix" value="${person.name.suffix}" style="width: 90%;" /></td>
					        	</tr>
					        	<tr>
						        	<td style="text-align: right;"><label for="title"><spring:message code='field.title'/></label></td>
						        	<td><input id="title" type="text" name="name.title" value="${person.name.title}" style="width: 90%;" /></td>
					        	</tr>
					        	<tr>
						        	<td style="text-align: right;"><label for="birthDate"><spring:message code='field.birthDate'/></label></td>
						        	<td><input id="birthDate" type="date" name="birthDate" value="${person.getBirthDateToString()}" style="width: 90%;" required="required"/></td>
					        	</tr>
					        	<tr>
						        	<td style="text-align: right;"><label for="gwa"><spring:message code='field.GWA'/></label></td>
						        	<td><input id="gwa" type="number" name="gwa" value="${person.gwa}" min="0" max="100" step="0.01" style="width: 90%;" /></td>
					        	</tr>
					        	<tr>
						        	<td style="text-align: right;"><label for="dateHired"><spring:message code='field.dateHired'/></label></td>
						        	<td><input id="dateHired" type="date" name="dateHired" value="${person.getDateHiredToString()}" style="width: 90%;" /></td>
					        	</tr>
					        	<tr>
						        	<td style="text-align: right;"><label for="employed"><spring:message code='field.employed'/></label></td>
						        	<td>
						        		<select id="employed" name="employed" style="width: 93%;">
						        			<option value="true" ${person.employed ? 'selected="selected"' : ''}><spring:message code='field.true'/></option>
						        			<option value="false" ${!person.employed ? 'selected="selected"' : ''}><spring:message code='field.false'/></option>
						        		</select>
						        	</td>
					        	</tr>
					        	<tr><td>&nbsp;</td></tr>
					        	<tr>
					        		<!-- ADDRESS -->
						        	<td style="text-align: right;"><label for="street"><spring:message code='field.street'/></label></td>
						        	<td><input id="street" type="text" name="address.street" value="${person.address.street}" style="width: 90%;" /></td>
					        	</tr>
					        	<tr>
						        	<td style="text-align: right;"><label for="barangay"><spring:message code='field.barangay'/></label></td>
						        	<td><input id="barangay" type="text" name="address.barangay" value="${person.address.barangay}" style="width: 90%;" /></td>
					        	</tr>
					        	<tr>
						        	<td style="text-align: right;"><label for="municipality"><spring:message code='field.municipality'/></label></td>
						        	<td><input id="municipality" type="text" name="address.municipality" value="${person.address.municipality}" style="width: 90%;" required="required"/></td>
					        	</tr>
					        	<tr>
						        	<td style="text-align: right;"><label for="zipCode"><spring:message code='field.zipCode'/></label></td>
						        	<td><input id="zipCode" type="number" name="address.zipCode" value="${person.address.zipCode}" style="width: 90%;" /></td>
					        	</tr>
					        	<tr><td>&nbsp;</td></tr>
			        		</table>
			        	</td>
			        	<td style="width: 50%;" valign="top">
			        		<table width="100%">
			        			<tr style="text-align: center"><td><strong><spring:message code='message.roles'/></strong></td></tr>
			        			<tr>
			        				<td>
				        				<table class="solid"  width="100%" id="personRoles">
				        					<tr class="solid">
				        						<th width="20%"><spring:message code='message.code'/></th>
				        						<th width="70%"><spring:message code='message.role'/></th>
				        						<th width="10%"><spring:message code='message.delete'/></th>
				        					</tr>
				        					<c:choose>
					        					<c:when test="${not empty person.roles}">
						        					<c:forEach var="role" items="${person.roles}" varStatus="status">
							        					<tr class="solid personRole" id="role-${role.id}">
							        						<td width="20%">${role.code}</td>
							        						<td width="70%">${role.roleDesc}</td>
							        						<td width="10%">
							        							<input type="hidden" id="deleteRole-${role.id}" name="roles[${status.index}].deleted" value="${role.deleted}">
							        							<a onclick="deleteRole(${role.id})" class="icon-block" style="cursor: pointer;color:red;">
							        								<i class="fa fa-trash-o" aria-hidden="true"></i></a>
							        						</td>
							        					</tr>
						        					</c:forEach>
					        					</c:when>
					        					<c:otherwise>
						        					<tr class="solid" id="noRoles">
						        						<td colspan="3"><i style="color: red;">No roles registered</i></td>
						        					</tr>
					        					</c:otherwise>
				        					</c:choose>
				        				</table>
			        				</td>
			        			</tr>
			        			<tr>
	        						<td style="text-align: right;">
	        							<select id="selectRole" style="width: 80%;">
	        								<c:forEach var="role" items="${roles}">
	        									<option value="${role.id}">${role.roleDesc}</option>
	        								</c:forEach>
	        							</select>
	        							<button type="button" onclick="addRole()"><spring:message code='message.add'/></button>
	        						</td>
	        					</tr>
	        					<tr>
	        						<td colspan="3">
	        							<i style="color: red;" id="roleResult"></i>
	        						</td>
	        					</tr>
			        			<tr style="text-align: center"><td><br/><br/><strong><spring:message code='message.contacts'/></strong></td></tr>
			        			<tr>
			        				<td>
				        				<table class="solid" width="100%" id="contactsTable">
				        					<tr class="solid">
				        						<th width="25%"><spring:message code='message.type'/></th>
				        						<th width="65%"><spring:message code='message.contact'/></th>
				        						<th width="10%"><spring:message code='message.delete'/></th>
				        					</tr>
				        					<c:choose>
				        						<c:when test="${not empty person.contacts}">
				        							<c:forEach var="contact" items="${person.contacts}" varStatus="status">
							        					<tr class="solid" id="contact-${contact.id}">
							        						<td>${contact.contactType.typeDesc}</td>
							        						<td>
							        							<input type="text" name="contacts[${status.index}].contactDesc" value="${contact.contactDesc}"/>
							        						</td>
							        						<td>
							        							<input type="hidden" id="deleteContact-${contact.id}" name="contacts[${status.index}].deleted" value="${contact.deleted}"/>
							        							<a onclick="deleteContact(${contact.id})" class="icon-block" style="cursor: pointer;color:red;"><i class="fa fa-trash-o" aria-hidden="true"></i></a>
							        						</td>
							        					</tr>
						        					</c:forEach>
					        					</c:when>
					        					<c:otherwise>
						        					<tr class="solid" id="noContacts">
						        						<td colspan="4"><i style="color: red;">No Contacts</i></td>
						        					</tr>
					        					</c:otherwise>
				        					</c:choose>
				        				</table>
			        				</td>
			        			</tr>
			        			<tr>
	        						<td style="text-align: right;">
	        							<select id="selectContactType" style="width: 20%;">
	        								<c:forEach var="contact" items="${contacts}">
	        									<option value="${contact.id}">${contact.typeDesc}</option>
	        								</c:forEach>
	        							</select>
	        							<input type="text" id="contactInfo">
	        							<button type="button" onClick="addContact()"><spring:message code='message.add'/></button>
	        						</td>
	        					</tr>
	        					<tr>
	        						<td colspan="3">
	        							<i style="color: red;" id="contactResult">${contactResult}</i>
	        						</td>
	        					</tr>
			        		</table>
			        	</td>
		        	</tr>
		        	<tr>	
		        		<td style="text-align: left; margin-right:5%;">
		        			<input type="hidden" name="personId" value="${person.id}"/>
							<button onclick="deletePerson(${person.id})" type="button">
								<spring:message code='message.deletePerson'/>
							</button>
		        		</td>
						<td style="text-align: right;">
		        			<i style="color: red">${badUpdate}</i>
		        			<i style="color: green">${goodUpdate}</i>
		        			<input onclick="clicked(event)" type="submit" name="updatePerson" value="<spring:message code='message.update'/>"/>
							<button onclick="location.href='home';" type="button"><spring:message code='message.done'/></button>
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

        function deleteRole(roleId) {
            $("#deleteRole-"+roleId).val(true);
            $("#role-"+roleId).hide();
        }

        function removeRole(roleId) {
            $("#newRole-"+roleId).remove();
        }

        function addRole() {
        	var roleId = $("#selectRole").val();

        	$.ajax({
                url : 'manage-person/rest/get-role',
                method : 'GET',
                contentType : 'application/json',
                data : {"roleId" : roleId},
                dataType : 'json',
                success: function(data) {
                	if(data != null) {
                		var roleCode = data["code"];
			        	var roleDesc = data["roleDesc"];
			        	var index = $(".personRole").length;

			        	var role = "<tr class='solid personRole' id='newRole-" + roleId + "' >" +
			        					"<td width='20%'>" + roleCode +
			        						"<input type='hidden' name='newRoleId' value='" + roleId + "'>" +
			        						"<input type='hidden' name='newRoleCode-" + roleId + "' value='" + roleCode + "'>" +
			        					"</td>" +
			    						"<td width='70%'>" + roleDesc + 
			        						"<input type='hidden' name='newRoleDesc-" + roleId + "' value='" + roleDesc + "'>" +
			        					"</td>" +
			    						"<td width='10%'>" +
			    							"<a onclick='removeRole(" + roleId + ")' class='icon-block' style='cursor: pointer;color:red;'>" +
			    								"<i class='fa fa-trash-o' aria-hidden='true'></i></a>" +
			    						"</td></tr>";
			    		$("#noRoles").hide();
			        	$("#personRoles").append(role);
                	} 
                },
                error : function(data){
                	$("#roleResult").html("<spring:message code='error.roleExists'/>");
                }
            });
        }

        function addContact() {
        	var typeId = $("#selectContactType").val();
			var contactDesc = $("#contactInfo").val();		

        	$.ajax({
                url : 'manage-person/rest/get-contact-type',
                method : 'GET',
                contentType : 'application/json',
                data : {"typeId" : typeId, "contactInfo" : contactDesc},
                dataType : 'json',
                success: function(data) {
                	//alert(JSON.stringify(data))
                	if(data != null) {
                		var typeDesc = data["typeDesc"];

			        	var contact = "<tr class='solid' id='newContact-" + typeId + "'> " +
        						"<td>" + typeDesc + "</td>" +
        						"<td>" +
        							"<input type='text' name='newContactDesc-" + typeId + "' value='" + contactDesc + "'/>" +
        						"</td>" +
        						"<td>" +
        							"<input type='hidden' name='newContact' value='" + typeId + "'/>" +
        							"<a onclick='removeContact(" + typeId + ")' class='icon-block' style='cursor: pointer;color:red;'><i class='fa fa-trash-o' aria-hidden='true'></i></a>" +
        						"</td>" +
        					"</tr>";

        				$("#noContacts").hide();
			        	$("#contactsTable").append(contact);
                		$("#contactResult").html("");
                	} 
                },
                error : function(data){
                	//alert(JSON.stringify(data))
                	$("#contactResult").html("<spring:message code='error.invalidContact'/>");
                }
            });
        }

        function removeContact(contactId) {
        	$("#newContact-"+contactId).remove();
        }

        function deleteContact(contactId) {
            $("#deleteContact-"+contactId).val(true);
            $("#contact-"+contactId).hide();
        }

        function deletePerson(id) {
            if(confirm('Are you sure?')) {
                $.ajax({
                    url : './home/rest/delete-person?delete='+id,
                    method : 'DELETE',
                    contentType: 'application/json; charset=utf-8',
                    dataType:'json',
                    success: function (data) {
                        alert(data["deleteResult"])
                        window.location.href = "./home";
                    }
                });
            }
        }
    </script>
</html> 