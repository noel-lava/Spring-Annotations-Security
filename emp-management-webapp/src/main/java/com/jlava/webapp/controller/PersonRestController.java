package com.jlava.webapp.controller;

import static org.springframework.web.bind.annotation.RequestMethod.GET;
import static org.springframework.web.bind.annotation.RequestMethod.POST;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.validation.BindingResult;
import org.springframework.ui.ModelMap;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.Map;

import com.jlava.service.PersonManager;
import com.jlava.service.ContactManager;
import com.jlava.service.RoleManager;
import com.jlava.model.Person;
import com.jlava.model.Role;
import com.jlava.model.Contact;
import com.jlava.model.ContactType;
import com.jlava.apputil.AppUtil;

@RestController
@SessionAttributes({"person"})
@RequestMapping("/manage-person/rest")
public class PersonRestController{ 
	private PersonManager personManager;
	private ContactManager contactManager;
	private RoleManager roleManager;

	@Autowired
	public PersonRestController(PersonManager personManager, ContactManager contactManager, RoleManager roleManager) {
		this.personManager = personManager;
		this.contactManager = contactManager;
		this.roleManager = roleManager;
	}

	@RequestMapping(value="/upload-person", method=POST)
	public String uploadEmployee(@RequestParam("empProfile") MultipartFile empProfile, ModelMap model) {
		String message = "";
		if(empProfile.isEmpty()) {
			message = "No file attached";
		} else {
			try {
				String content = new String(empProfile.getBytes(), "UTF-8");
				Person person = personManager.getPerson(personManager.addPerson(content));
				model.addAttribute("person", person);

				return "manage-person";
			} catch(Exception e) {
				message = "Invalid file attached";
				e.printStackTrace();
			}
		}

		return message;
	}

	@RequestMapping(value="/get-role", method=GET)
	public Role validateRole(@RequestParam("roleId") Long roleId, ModelMap model) {
		return roleManager.checkRoleFromUser((Person) model.get("person"), roleId);
	}

	@RequestMapping(value="/get-contact-type", method=GET)
	public ContactType getContactType(@RequestParam("typeId") Long typeId, @RequestParam("contactInfo") String contactInfo, ModelMap model) {
		if(!contactManager.validateContact(typeId.intValue(), contactInfo)) {
			return null;
		}
		
		return contactManager.getContactType(typeId);
	}
}