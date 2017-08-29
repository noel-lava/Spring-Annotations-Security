package com.jlava.model;

import java.util.Set;
import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Column;
import javax.persistence.FetchType;
import javax.persistence.OneToMany;
import javax.persistence.Embeddable;
import com.fasterxml.jackson.annotation.JsonBackReference;

// @Embeddable
@Entity
@Table(name="contact_type")
public class ContactType extends BaseModel{
	@Column(name="contact_type_code")
	private String code;

	@Column(name="type_desc")
	private String typeDesc;

	@OneToMany(fetch=FetchType.EAGER, mappedBy="contactType")
	@JsonBackReference
	private Set<Contact> contacts;

	public ContactType () {}
	public ContactType (String code, String typeDesc) {
		this.code = code;
		this.typeDesc = typeDesc;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getTypeDesc () {
		return typeDesc;
	}

	public void setTypeDesc(String typeDesc) {
		this.typeDesc = typeDesc;
	}

	public Set<Contact> getContacts() {
		return contacts;
	}

	public void setContacts(Set<Contact> contacts) {
		this.contacts = contacts;
	}
}