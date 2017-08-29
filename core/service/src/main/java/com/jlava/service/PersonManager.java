package com.jlava.service;

import com.jlava.model.Person;
import com.jlava.model.Role;
import java.util.*;
import com.jlava.exception.*;

public interface PersonManager {
	Long addPerson(String lastName, String firstName, String midName, String suffix, String title,
				Date birthDate, Float gwa, Date dateHired, boolean employed, String street, String barangay, String municipality, Integer zipCode);

	Long addPerson(Person person);

	Long addPerson(String personDetails) throws InvalidNumericException, InvalidDateException;

	int deletePerson(Long personId);

	int updatePerson(Long personId, String lastName, String firstName, String midName, String suffix, String title,
				Date birthDate, Float gwa, Date dateHired, boolean employed, String street, String barangay, String municipality, Integer zipCode);

	int updatePerson(Person person);
	int updatePerson(Person person, Map<String, String> requestParams);

	List<Person> listPersons(int sortBy);

	void searchPerson(Long personId);

	Person getPerson(Long personId);

	// add person role
	int addPersonRole(Person person, Long roleId);

	// delete person role
	int deletePersonRole(Person person, Long roleId);
}