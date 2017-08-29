package com.jlava.model;

import javax.persistence.Embeddable;
import javax.persistence.Column;

@Embeddable
public class Name {
	@Column(name="last_name", nullable=false, length=50)
	private String lastName;

	@Column(name="first_name", nullable=false, length=50)
	private String firstName;

	@Column(name="mid_name", length=50)
	private String midName;

	@Column(name="suffix", length=4)
	private String suffix;

	@Column(name="title", length=6)
	private String title; 

	public Name() {}
	public Name(String lastName, String firstName, String midName, String suffix, String title) {
		this.lastName = lastName;
		this.firstName = firstName;
		this.midName = midName;
		this.suffix = suffix;
		this.title = title;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getMidName() {
		return midName;
	}

	public void setMidName(String midName) {
		this.midName = midName;
	}

	public String getSuffix() {
		return suffix;
	}

	public void setSuffix(String suffix) {
		this.suffix = suffix;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}
}