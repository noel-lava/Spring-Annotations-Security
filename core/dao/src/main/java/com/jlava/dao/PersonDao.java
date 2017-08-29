package com.jlava.dao;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Filter;
import org.hibernate.stat.Statistics;

import java.util.*;

import com.jlava.model.Person;

import org.springframework.transaction.annotation.Transactional;
import org.springframework.stereotype.Repository;
import org.springframework.beans.factory.annotation.Autowired;

@Transactional
@Repository
public class PersonDao {
	@Autowired
	private SessionFactory sessionFactory;

	public Long addPerson(Person person) {
		person.setDeleted(false);
		Session session = sessionFactory.getCurrentSession();
		Long personId = (Long) session.save(person);

		return personId;
	}

	public int deletePerson(Long personId) {
		Person person = getPerson(personId);
		person.setDeleted(true);
		return updatePerson(person);
	}

	public int updatePerson(Person person) {
		Session session = sessionFactory.getCurrentSession();
		session.update(person);
		return 1;
	}

	public List<Person> listPerson(int sortBy) {
		List<Person> persons = null;
		Session session = sessionFactory.getCurrentSession();

		switch(sortBy) {
			case 1 : // SORT BY GWA (JAVA)
				persons = session.createQuery("FROM Person WHERE deleted = false").list();
				Collections.sort(persons, (p1, p2) -> Float.compare(p1.getGwa(), p2.getGwa()));

				break;
			case 2 : // SORT BY DATE HIRED
				persons = session.createQuery("FROM Person WHERE deleted = false ORDER BY dateHired ASC").list();
				break;
			case 3 : // SORT BY LAST NAME
			default :
				persons = session.createQuery("FROM Person p WHERE p.deleted = false ORDER BY p.name.lastName ASC").list();
				break;
		}

		return persons;
	}

	public Person getPerson(Long personId) {
		Session session = sessionFactory.getCurrentSession();
		Filter filter = session.enableFilter("contactsFilter");
		filter.setParameter("isDeleted", false);

		return (Person)session.createQuery("FROM Person WHERE id = :id AND deleted = false")
			.setParameter("id", personId)
			.uniqueResult();
	}	
}