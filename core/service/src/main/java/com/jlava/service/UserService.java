package com.jlava.service;

import com.jlava.model.User;

public interface UserService {
	User getUser(Long id);
	User getUser(String username);
}