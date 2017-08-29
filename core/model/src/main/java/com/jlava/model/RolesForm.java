package com.jlava.model;
import java.util.List;

public class RolesForm{
	private List<Role> roles;

	public RolesForm() {}
	public RolesForm(List<Role> roles) {
		this.roles = roles;
	}

	public List<Role> getRoles() {
		return roles;
	}

	public void setRoles(List<Role> roles) {
		this.roles = roles;
	}
}