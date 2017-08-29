package com.jlava.model;

import java.util.Set;

import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Column;
import javax.persistence.ManyToMany;
import javax.persistence.FetchType;
import com.fasterxml.jackson.annotation.JsonManagedReference;

@Entity
@Table(name="role_type")
public class UserRole extends BaseModel{
	@Column(name="type")
	private String type;

	@ManyToMany(fetch=FetchType.EAGER, mappedBy="userRoles")
	@JsonManagedReference
	private Set<User> users;

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public Set<User> getUsers() {
		return users;
	}

	public void setUsers(Set<User> users) {
		this.users = users;
	}
}