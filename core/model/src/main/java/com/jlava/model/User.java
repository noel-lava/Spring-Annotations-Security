package com.jlava.model;

import java.util.Set;

import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Column;
import javax.persistence.ManyToMany;
import javax.persistence.JoinTable;
import javax.persistence.JoinColumn;
import javax.persistence.FetchType;
import com.fasterxml.jackson.annotation.JsonBackReference;

@Entity
@Table(name="app_user")
public class User extends BaseModel{
	@Column(name="username")
	private String username;

	@Column(name="password")
	private String password;

	@ManyToMany(fetch=FetchType.EAGER)
	@JoinTable(name="user_role", joinColumns = {@JoinColumn(name="user_id", updatable=false)},
		inverseJoinColumns = {@JoinColumn(name="user_role_type_id", updatable=false)})
	@JsonBackReference
	private Set<UserRole> userRoles;

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public Set<UserRole> getUserRoles() {
		return userRoles;
	}

	public void setUserRoles(Set<UserRole> userRoles) {
		this.userRoles = userRoles;
	}
}