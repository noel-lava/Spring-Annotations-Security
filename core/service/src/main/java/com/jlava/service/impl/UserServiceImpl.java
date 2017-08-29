package com.jlava.service.impl;

import com.jlava.model.User;
import com.jlava.service.UserService;
import com.jlava.dao.UserDao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserServiceImpl implements UserService{
	@Autowired
	private UserDao userDao;

	public User getUser(Long id) {
		return userDao.getUser(id);
	}

	public User getUser(String username) {
		return userDao.getUser(username);
	}
}