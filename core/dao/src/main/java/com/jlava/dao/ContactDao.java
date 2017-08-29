package com.jlava.dao;

//import com.jlava.persistence.HibernateUtil;
import com.jlava.model.Contact;
import com.jlava.model.ContactType;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Query;
import org.hibernate.HibernateException;
import org.hibernate.Transaction;
import java.util.List;

import org.springframework.transaction.annotation.Transactional;
import org.springframework.stereotype.Repository;
import org.springframework.beans.factory.annotation.Autowired;

@Repository
@Transactional
public class ContactDao {
	@Autowired
	SessionFactory sessionFactory;
	
	public Contact getContact(Long personId, Long contactId) {
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("SELECT c FROM Contact c WHERE id = :contactId AND person.id = :personId AND deleted=false");
		query.setParameter("contactId", contactId);
		query.setParameter("personId", personId);

		return (Contact)query.uniqueResult();
	}

	public int updateContact(Long personId, Contact contact) {
		Session session = sessionFactory.getCurrentSession();
		int updated = 0;

		Query query = session.createQuery("UPDATE Contact SET contactDesc = :contactDesc, deleted = :deleted "
			+ "WHERE person.id = :personId AND id = :contactId");
		query.setParameter("contactDesc", contact.getContactDesc());
		query.setParameter("deleted", contact.isDeleted());
		query.setParameter("personId", personId);
		query.setParameter("contactId", contact.getId());
		
		updated = query.executeUpdate();
		return updated;
	}

	public int deleteContact(Long personId, Contact contact) {
		contact.setDeleted(true);
		return updateContact(personId, contact);
	}

	public List<ContactType> getContactTypes() {
		Session session = sessionFactory.getCurrentSession();
		return session.createQuery("FROM ContactType").list();
	}

	public ContactType getContactType(Long typeId) {
		Session session = sessionFactory.getCurrentSession();
		return (ContactType)session.createQuery("FROM ContactType WHERE id = :id")
					.setParameter("id", typeId)
					.uniqueResult();
	}
}