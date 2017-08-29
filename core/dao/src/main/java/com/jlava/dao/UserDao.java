package com.jlava.dao;

import com.jlava.model.User;
import com.jlava.model.UserRole;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import java.util.*;

import org.springframework.transaction.annotation.Transactional;
import org.springframework.stereotype.Repository;
import org.springframework.beans.factory.annotation.Autowired;

@Transactional
@Repository
public class UserDao {
	@Autowired
	SessionFactory sessionFactory;
	
	public User getUser(Long id) {
		return (User)getSession().get(User.class, id);
	}

	public User getUser(String username) {
		return (User)getSession().createQuery("From User WHERE username = :username")
			.setParameter("username", username)
			.uniqueResult();
	}

	private Session getSession() {
		return sessionFactory.getCurrentSession();
	}
}