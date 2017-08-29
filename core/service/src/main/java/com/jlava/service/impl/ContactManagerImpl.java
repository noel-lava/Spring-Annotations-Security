package com.jlava.service.impl;

import com.jlava.model.Contact;
import com.jlava.model.ContactType;
import com.jlava.dao.ContactDao;
import com.jlava.service.ContactManager;
import com.jlava.apputil.AppUtil;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ContactManagerImpl implements ContactManager{
	private ContactDao contactDao;

	@Autowired
	public ContactManagerImpl(ContactDao contactDao) {
		this.contactDao = contactDao;
	}

	public List<ContactType> getContactTypes() {
		return contactDao.getContactTypes();
	}

	public ContactType getContactType(Long typeId) {
		return contactDao.getContactType(typeId);
	}

	public boolean validateContact(int type, String contactInfo) {
		String contactDesc = "";
		try{
			switch(type) {
				case 1:
					contactDesc = AppUtil.readNumeric(contactInfo, false, 7, "Phone");
					break;
				case 2:
					contactDesc = AppUtil.readNumeric(contactInfo, false, 11, "Cellphone");
					break;
				case 3:
				default:
					contactDesc = AppUtil.readLine(contactInfo, false, 30, "Email");
					break;
			}

			return true;
		} catch(Exception e) {
			return false;
		}
	}
}