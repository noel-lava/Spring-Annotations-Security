package com.jlava.service;

import com.jlava.model.Contact;
import com.jlava.model.ContactType;
import java.util.List;

public interface ContactManager {
	List<ContactType> getContactTypes();
	ContactType getContactType(Long typeId);
	boolean validateContact(int type, String contactInfo);
}