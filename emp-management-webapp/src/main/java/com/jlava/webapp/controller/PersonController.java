package com.jlava.webapp.controller;

import static org.springframework.web.bind.annotation.RequestMethod.GET;
import static org.springframework.web.bind.annotation.RequestMethod.POST;
import static org.springframework.web.bind.annotation.RequestMethod.DELETE;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;

import java.util.Map;
import java.util.List;
import java.util.ArrayList;

import com.jlava.service.PersonManager;
import com.jlava.service.ContactManager;
import com.jlava.service.RoleManager;
import com.jlava.model.Person;
import com.jlava.model.Role;
import com.jlava.model.Contact;
import com.jlava.model.ContactType;
import com.jlava.apputil.AppUtil;

@Controller
@SessionAttributes({"person"})
@RequestMapping("/manage-person")
public class PersonController {
	private PersonManager personManager;
	private ContactManager contactManager;
	private RoleManager roleManager;

	@Autowired
	public PersonController(PersonManager personManager, ContactManager contactManager, RoleManager roleManager) {
		this.personManager = personManager;
		this.contactManager = contactManager;
		this.roleManager = roleManager;
	}

	@RequestMapping(value="/add", method=GET)
	public ModelAndView addEmployee() {
		return new ModelAndView("add-person", "person", new Person());
	}

	@PreAuthorize("hasAnyRole('ADMIN', 'EMPLOYEE_ADMIN')")
	@RequestMapping(value="/add", method=POST)
	public String addEmployee(@ModelAttribute("person") Person person, BindingResult result, ModelMap model) {
		Long id = personManager.addPerson(person);

		if(id > 0) {
			person.setId(id);
			System.out.println("PERSON ID : " + id);

		} else {
			System.out.println("ADD FAILED");
			// return error
		}

		model.addAttribute("person", person);
		return "redirect:../manage-person";
	}

	//Search Person
	@RequestMapping(method=GET)
	public String managePerson(ModelMap model) {
		if(!model.containsAttribute("person")) {
			return "redirect:home";
		}

		model.addAttribute("roles", roleManager.listRoles());
		model.addAttribute("contacts", contactManager.getContactTypes());

		return "manage-person";
	}

	//Update Person
	@RequestMapping(method=POST)
	public String updatePerson(@ModelAttribute("person") Person person, 
		@RequestParam Map<String,String> allRequestParams, 
		ModelMap model, RedirectAttributes redirectAttributes) {
		int result = personManager.updatePerson(person, allRequestParams);

		if(result > 0) {
			redirectAttributes.addFlashAttribute("goodUpdate", "Update Successful");
		} else {
			redirectAttributes.addFlashAttribute("badUpdate", "Update Failed");
		}

		model.addAttribute("person", person);
		return "redirect:manage-person";
	}
}