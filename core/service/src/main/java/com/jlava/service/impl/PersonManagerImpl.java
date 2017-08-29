package com.jlava.service.impl;

import com.jlava.model.Person;
import com.jlava.model.Role;
import com.jlava.model.Address;
import com.jlava.model.Name;
import com.jlava.model.ContactType;
import com.jlava.model.Contact;
import com.jlava.dao.PersonDao;
import com.jlava.dao.RoleDao;
import com.jlava.service.PersonManager;
import com.jlava.service.ContactManager;
import com.jlava.apputil.AppUtil;
import com.jlava.exception.*;

import org.hibernate.ObjectNotFoundException;
import java.util.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class PersonManagerImpl implements PersonManager{
	private PersonDao personDao;
	private RoleDao roleDao;
	private ContactManager contactManager;

	@Autowired
	public PersonManagerImpl(PersonDao personDao, RoleDao roleDao, ContactManager contactManager) {
		this.personDao = personDao;
		this.roleDao = roleDao;
		this.contactManager = contactManager;
	}

	public Long addPerson(String lastName, String firstName, String midName, String suffix, String title,
				Date birthDate, Float gwa, Date dateHired, boolean employed, String street, String barangay, String municipality, Integer zipCode) {
		Address address = new Address(street, barangay, municipality, zipCode);
		Name name = new Name(lastName, firstName, midName, suffix, title);
		Person person = new Person(name, birthDate, gwa, dateHired, employed, address);

		Long personId = personDao.addPerson(person);
		if(personId != null) {
			System.out.println("[Successfully added " + person.getName().getLastName() + ", " + person.getName().getFirstName() + " with ID : " + personId + "]");
			return personId;
		} else {
			System.out.println("[Add person failed]");
			return new Long(0);
		}
	}
	public Long addPerson(Person person) {
		Long personId = personDao.addPerson(person);
		if(personId != null) {
			System.out.println("[Successfully added " + person.getName().getLastName() + ", " + person.getName().getFirstName() + " with ID : " + personId + "]");
			return personId;
		} else {
			System.out.println("[Add person failed]");
			return new Long(0);
		}
	}

	public Long addPerson(String personDetails) throws InvalidNumericException, InvalidDateException {
		Map<String,String> map = new HashMap<String,String>();
		String[] details = personDetails.replace("\n", "").split("\\,");

		for(String pair : details) {
			String[] keyVal = pair.split(":", 2);
			map.put(keyVal[0], keyVal[1]);
		}

		map.forEach((k,v) -> {
			System.out.println("-key-"+k + "- : -val-" + v + "-");
		});

		Name name = new Name(map.get("Last_Name"), map.get("First_Name"), map.get("Middle_Name"), map.get("Suffix"), map.get("Title"));
		Address address = new Address(map.get("Street"), map.get("Barangay"), map.get("Municipality"), AppUtil.readInt(map.get("Zip_Code"), 0, 9999, true, ""));
		Person person = new Person(name, AppUtil.readDate(map.get("Birth_Date"), false, "birthDate"+map.get("Birth_Date")), AppUtil.readFloat(map.get("GWA"), new Float(0), new Float(100),""), 
								AppUtil.readDate(map.get("Date_Hired"), true, "dateHired"), AppUtil.readBool(map.get("Employed")), address);

		return personDao.addPerson(person);
		// return new Long(0);
	}

	public int deletePerson(Long personId) {
		int ctr = personDao.deletePerson(personId);
		if(ctr > 0) {
			System.out.println("[Successfully deleted person " + personId + "]");
		} else {
			System.out.println("[Failed : Person with id " + personId + " not found]");
		}

		return ctr;
	}

	public int updatePerson(Long personId, String lastName, String firstName, String midName, String suffix, String title,
				Date birthDate, Float gwa, Date dateHired, boolean employed, String street, String barangay, String municipality, Integer zipCode) {
		Person person = getPerson(personId);

		if(person != null) {
			person.getName().setLastName(lastName);
			person.getName().setFirstName(firstName);
			person.getName().setMidName(midName);
			person.getName().setSuffix(suffix);
			person.getName().setTitle(title);

			person.setBirthDate(birthDate);
			person.setGwa(gwa);
			person.setDateHired(dateHired);
			person.setEmployed(employed);

			person.getAddress().setStreet(street);
			person.getAddress().setBarangay(barangay);
			person.getAddress().setMunicipality(municipality);
			person.getAddress().setZipCode(zipCode);

			personDao.updatePerson(person);
			return 1;
		}

		return 0;
	}

	public int updatePerson(Person person) {
		if(person != null) {
			personDao.updatePerson(person);
			System.out.println("[Successfully updated person " + person.getId() + "]");
			return 1;
		}

		return 0;
	}

	public int updatePerson(Person person, Map<String, String> requestParams) {
		// remove deleted roles
		for(Role role : new ArrayList<Role>(person.getRoles())) {
			if(role.isDeleted()) {
				person.getRoles().remove(role);
			}
		}

		// add roles and contacts
		for(Map.Entry<String,String> param : requestParams.entrySet()) {
			if(param.getKey().equals("newRoleId")) {
				Long roleId = Long.valueOf(param.getValue());
				Role role = new Role(requestParams.get("newRoleCode-"+roleId), requestParams.get("newRoleDesc-"+roleId));
				role.setId(roleId);
				role.setDeleted(false);

				person.getRoles().add(role);
			}

			if(param.getKey().equals("newContact")) {
				Long typeId = Long.valueOf(param.getValue());
				ContactType type = contactManager.getContactType(typeId);
				String contactDesc = requestParams.get("newContactDesc-"+typeId);

				Contact contact = new Contact(type, contactDesc);
				contact.setPerson(person);
				person.getContacts().add(contact);
			}
		}

		int result = updatePerson(person);

		// remove deleted contacts
		for(Contact contact : new ArrayList<Contact>(person.getContacts())) {
			if(contact.isDeleted()) {
				person.getContacts().remove(contact);
			}
		}
		return result;
	}

	public List<Person> listPersons(int sortBy) {
		List<Person> persons = personDao.listPerson(sortBy);

		if(persons == null || persons.size() < 1) {
			System.out.println("No persons found!");
			return null;
		} else {
			return persons;
		}
	}

	public void searchPerson(Long personId) {
		Person person = getPerson(personId);
		
		if(person != null) {	
			printPerson(person);
		}
	}

	public void printPerson(Person person) {
		Address address = person.getAddress();
		Name name = person.getName();
		String suffix = (name.getSuffix() != null)?name.getSuffix():"";
		String title = (name.getTitle() != null)?name.getTitle() + " ":"";
		String midName = (name.getMidName() != null)?name.getMidName():"";
		String addr = (address != null)?address.toString():"N/A";

		System.out.println("\n[PERSON ID : " + person.getId() + "]");
		System.out.println("\tName : " + title + name.getFirstName() + " " + midName + " " + name.getLastName() + " " + suffix);
		System.out.println("\tBirth Date : " + person.getBirthDate());
		System.out.println("\tGeneral Weighted Average (GWA) : " + person.getGwa());
		System.out.println("\tDate Hired : " + person.getDateHired());
		System.out.println("\tEmployed : " + person.getEmployed());
		System.out.println("\tAddress : " + addr);

		System.out.println("\n\t[ Contact Info ]");
		if(person.getContacts().size() > 0) {
			person.getContacts().forEach(contact -> {
				System.out.println("\n\t\tContact ID : " + contact.getId());
				System.out.println("\n\t\t" + contact.getContactType() + " - " + contact.getContactDesc());
			});
		} else {
			System.out.println("\tNo contacts.");
		}		

		System.out.println("\n\t[ Role(s) ]");
		if(person.getRoles().size() > 0) {
			person.getRoles().forEach(role -> {
				System.out.println("\t\tRole : " + role.getCode() + " " + role.getRoleDesc() + " - " + role.getId());
			});
		} else {
			System.out.println("\tNo roles.");
		}
	}

	public Person getPerson(Long personId) {
		Person person = personDao.getPerson(personId);

		if(person == null) {
			System.out.println("[Person with id " + personId + " not found]");
		}

		return person;
	}

	public int addPersonRole(Person person, Long roleId) {
		//Person person = getPerson(personId);
		if(person != null) {
			Role role = person.getRoles()
							.stream()
							.filter(r -> r.getId() == roleId)
							.findFirst()
							.orElse(null);
			role = (role != null)?role:getRole(roleId);

			if(role != null) {
				if(person.getRoles().contains(role)) {
					System.out.println("[Failed to add role : person " + person.getId() + " already has a " + role.getRoleDesc() + " role]");
					return 0;
				} else {
					person.getRoles().add(role);
					updatePerson(person);
					System.out.println("[Successfully added " + role.getRoleDesc() + " role to person " + person.getId() + "]");
					return 1;
				}
			}
		}

		return 0;
	}

	public int deletePersonRole(Person person, Long roleId) {
		//Person person = getPerson(personId);
		if(person != null) {
			Role role = person.getRoles()
							.stream()
							.filter(r -> r.getId() == roleId)
							.findFirst()
							.orElse(null);
			
			if(role != null) {
				person.getRoles().remove(role);
				//role.setDeleted(true);
				updatePerson(person);
				System.out.println("[Successfully deleted " + role.getRoleDesc() + " role from person " + person.getId() + "]");
				return 1;
			} else {
				System.out.println("[Role with id : " + roleId + " does not exist]");
			}
		}

		return 0;
	}

	public Role getRole(Long roleId) {
		Role role = roleDao.getRole(roleId);
		if(role == null) {
			System.out.println("[Role with id " + roleId + " not found]");
		}

		return role;
	}
}