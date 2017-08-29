package com.jlava.webapp.controller;

import static org.springframework.web.bind.annotation.RequestMethod.GET;
import static org.springframework.web.bind.annotation.RequestMethod.POST;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.Map;
import java.util.List;
import java.util.Collections;

import com.jlava.service.PersonManager;
import com.jlava.model.Person;

@Controller
@SessionAttributes({"person"})
@RequestMapping({"/","/home"})
public class HomeController {
	private final PersonManager personManager;
	private static final Logger LOG = LoggerFactory.getLogger(HomeController.class);

	@Autowired
	public HomeController(PersonManager personManager) {
		this.personManager = personManager;
	}
	
	@RequestMapping(method=GET)
	public String loadHome(ModelMap model) {
		LOG.info("Load Home");
		return "index";
	}

	@RequestMapping(method=POST)
	@PreAuthorize("hasAnyRole('ADMIN', 'EMPLOYEE_ADMIN')")
	public String searchEmployee(@RequestParam("searchId") Long searchId, ModelMap model){
		String searchResult = "";
		if(searchId != null) {
			try {
				Person person = personManager.getPerson(searchId);
				if(person != null) {
					model.addAttribute("person", person);
					return "redirect:manage-person";
				} else {
					searchResult = "Person with id " + searchId + " not found";
				}
			} catch(Exception e) {
				searchResult = "Invalid Id";
			}
		} 

		model.addAttribute("searchResult", searchResult);
		return "index";
	}

	@RequestMapping(value="/{searchId}", method=GET)
	@PreAuthorize("hasAnyRole('ADMIN', 'EMPLOYEE_ADMIN')")
	public String getEmployee(@PathVariable Long searchId, ModelMap model){
		String searchResult = "";
		if(searchId != null) {
			try {
				Person person = personManager.getPerson(searchId);
				if(person != null) {
					model.addAttribute("person", person);
					return "redirect:/manage-person";
				} else {
					searchResult = "Person with id " + searchId + " not found";
				}
			} catch(Exception e) {
				searchResult = "Invalid Id";
			}
		} 

		model.addAttribute("searchResult", searchResult);
		return "index";
	}

}