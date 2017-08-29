package com.jlava.service;

import com.jlava.model.Role;
import com.jlava.model.Person;
import java.util.List;

public interface RoleManager {
	void addRole(String roleCode, String roleDesc);
	
	void updateRole(Long roleId, String roleDesc);
	void updateRole(Role role);

	List<Role> updateRoles(List<Role> roles);

	void deleteRole(Long roleId);
	void deleteRole(Role role);

	List<Role> listRoles();
	Role getRole(Long roleId);
	List<Person> getPersonsWithRole(Long roleId);
	boolean roleExists(Long roleId);
	boolean validCodeDesc(String roleDesc);
	boolean validCodeDesc(String code, String roleDesc);

	Role checkRoleFromUser(Person person, Long roleId);
}