package com.jlava.service.impl;

import com.jlava.model.Person;
import com.jlava.model.Role;
import com.jlava.dao.RoleDao;
import com.jlava.service.PersonManager;
import com.jlava.service.RoleManager;
import java.util.*;

import org.hibernate.ObjectNotFoundException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class RoleManagerImpl implements RoleManager{
	private RoleDao roleDao;
	private PersonManager personManager;

	@Autowired
	public RoleManagerImpl(PersonManager personManager, RoleDao roleDao) {
		this.personManager = personManager;
		this.roleDao = roleDao;
	}

	public void addRole(String roleCode, String roleDesc) {
		Role role = new Role(roleCode, roleDesc);
		Long roleId = roleDao.addRole(role);	
		if(roleId != null) {
			System.out.println("[New role added] : " + role.getId() + " - " + roleDesc);
		}
	}

	public void updateRole(Long roleId, String roleDesc) {
		Role role = getRole(roleId);
		if(role != null) {
			role.setRoleDesc(roleDesc);
			int updated = roleDao.updateRole(role);
			
			if(updated > 0) {
				System.out.println("[Successfully updated role " + roleId + " to " + roleDesc + "]");
			} else {
				System.out.println("[Update Failed]");
			}
		}
	}

	public void updateRole(Role role) {
		if(role != null) {
			int updated = roleDao.updateRole(role);
			
			if(updated > 0) {
				System.out.println("[Successfully updated role " + role.getId() + " to " + role.getRoleDesc() + "]");
			} else {
				System.out.println("[Update Failed]");
			}
		}
	}

	public List<Role> updateRoles(List<Role> roles) {
		for(Role role : new ArrayList<Role>(roles)) {
			if(role.getRoleDesc() != null || !role.getRoleDesc().isEmpty()) {
				updateRole(role);
				if(role.isDeleted()) {
					roles.remove(role);
				}
			}
		}

		return roles;
	}

	public void deleteRole(Long roleId) {
		Role role = getRole(roleId);
		if(role != null) {
			// Get all person with role = roleId
			List<Person> persons = getPersonsWithRole(roleId);

			if(persons!= null && persons.size() > 0) {
			// delete all person role with roleId = roleId;
				persons.forEach(person -> {
					personManager.deletePersonRole(person, roleId);
				});
			}

			int deleted = roleDao.deleteRole(role);

			if(deleted > 0) {
				System.out.println("[Successfully deleted role " + roleId + "]");	
			} else {
				System.out.println("[Deletion Failed]");
			}
		}		
	}

	public void deleteRole(Role role) {
		if(role != null) {
			// Get all person with role = roleId
			List<Person> persons = getPersonsWithRole(role.getId());

			if(persons!= null && persons.size() > 0) {
			// delete all person role with roleId = roleId;
				persons.forEach(person -> {
					personManager.deletePersonRole(person, role.getId());
				});
			}

			int deleted = roleDao.deleteRole(role);

			if(deleted > 0) {
				System.out.println("[Successfully deleted role " + role.getId() + "]");	
			} else {
				System.out.println("[Deletion Failed]");
			}
		}		
	}

	public List<Role> listRoles() {
		List<Role> roles= roleDao.getRoles();
		if(roles != null && roles.size() > 0) {
			System.out.println("\n[ ROLES ]");
			roles.forEach(role -> {
				System.out.println("\t["+role.getId()+"] " + role.getRoleDesc());
			});
		} else {
			System.out.println("[No roles found]");
			return null;
		}

		return roles;
	}

	public Role getRole(Long roleId) {
		Role role = roleDao.getRole(roleId);
		if(role == null) {
			System.out.println("[Role with id " + roleId + " not found]");
		}

		return role;
	}

	public List<Person> getPersonsWithRole(Long roleId) {
		List<Person> persons = roleDao.getPersonsWithRole(roleId);

		if(persons != null && persons.size() < 1) {
			System.out.println("[No persons with role " + roleId + " found]");
		} else {
			System.out.println(persons.size() + " persons found.");
		}

		return persons;
	}

	public boolean roleExists(Long roleId) {
		return (getRole(roleId) != null)?true:false;
	}

	public boolean validCodeDesc(String roleDesc) {
		boolean valid = true;
		for(Role role : listRoles()) {
			if(role.getRoleDesc().equals(roleDesc)) {
				return false;
			}
		}

		return valid;
	}

	public boolean validCodeDesc(String code, String roleDesc) {
		boolean valid = true;
		for(Role role : listRoles()) {
			if(role.getCode().equals(code) || role.getRoleDesc().equals(roleDesc)) {
				return false;
			}
		}

		return valid;
	}

	public Role checkRoleFromUser(Person person, Long roleId) {
		Role role = getRole(roleId);

		for(Role pRole : person.getRoles()) {
			if(role.getId() == pRole.getId()) {
				return null;
			}
		}

		return role;
	}
}