package com.jlava.webapp.controller;

import static org.springframework.web.bind.annotation.RequestMethod.GET;
import static org.springframework.web.bind.annotation.RequestMethod.POST;
import static org.springframework.web.bind.annotation.RequestMethod.DELETE;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.Map;
import java.util.List;
import java.util.Collections;

import com.jlava.service.PersonManager;
import com.jlava.model.Person;
import com.jlava.apputil.AppUtil;

@RestController
@RequestMapping({"/rest", "/home/rest"})
public class HomeRestController{
	@Autowired 
	private PersonManager personManager;

	@RequestMapping(value={"/populate-list"}, method=GET)
	public List<Person> sortList(@RequestParam("sortBy") int sortBy, ModelMap model){
		return personManager.listPersons(sortBy);
	}

	@RequestMapping(value="/delete-person", method=DELETE)
	public Map<String, String> deleteEmployee(@RequestParam("delete") Long deleteId, ModelMap model, SessionStatus status){
		String deleteResult = "";

		if(deleteId != null) {
			try {
				int deleted = personManager.deletePerson(deleteId);
				deleteResult = 	(deleted > 0)?"Successfully deleted person with id = " + deleteId:"Cannot delete person with id = " + deleteId;
			} catch(Exception e) {
				deleteResult = "Person with id " + deleteId + " does not exist";				
			}
		} 
		status.setComplete();
		return Collections.singletonMap("deleteResult", deleteResult);
	}
}