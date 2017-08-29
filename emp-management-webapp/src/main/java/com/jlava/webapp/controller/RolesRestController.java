package com.jlava.webapp.controller;

import static org.springframework.web.bind.annotation.RequestMethod.GET;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.beans.factory.annotation.Autowired;
import java.util.List;

import com.jlava.service.RoleManager;
import com.jlava.model.Person;
import com.jlava.model.Role;

@RestController
@RequestMapping("/roles/rest")
public class RolesRestController {
	@Autowired
	private RoleManager roleManager;

	@RequestMapping(value="/populate-roles", method=GET)
	public List<Role> getRoleList(ModelMap model){
		return roleManager.listRoles();
	}

	@RequestMapping(value="/populate-person-role", method=GET)
	public List<Person> filterByRole(@RequestParam("filterBy") Long filterBy, ModelMap model){
		return roleManager.getPersonsWithRole(filterBy);
	}
}