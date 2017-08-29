package com.jlava.model;

import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Column;
import javax.persistence.ManyToOne;
import javax.persistence.JoinColumn;
import javax.persistence.FetchType;
import javax.persistence.ElementCollection;
import javax.persistence.CollectionTable;
import javax.persistence.CascadeType;
import com.fasterxml.jackson.annotation.JsonManagedReference;

@Entity
@Table(name="contact")
public class Contact extends BaseModel{
	@Column(name="contact_desc")
	private String contactDesc;

	@Column(name="contact_type_id", updatable=false, insertable=false)
	private Long typeId;

	@ManyToOne(fetch=FetchType.EAGER)
	@JoinColumn(name="contact_type_id", nullable=false, updatable=false)
	@JsonManagedReference
	private ContactType contactType;

	@ManyToOne(fetch=FetchType.EAGER)
	@JoinColumn(name="person_id", nullable=false)
	@JsonManagedReference
	private Person person;

	public Contact() {}
	public Contact(Long typeId, String contactDesc) {
		this.contactDesc = contactDesc;
		this.typeId = typeId;
		super.setDeleted(false);
	}

	public Contact(ContactType contactType, String contactDesc) {
		this.contactType = contactType;
		this.contactDesc = contactDesc;
		super.setDeleted(false);
	}

	public String getContactDesc() {
		return contactDesc;
	}

	public void setContactDesc(String contactDesc) {
		this.contactDesc = contactDesc;
	}

	public Long getTypeId() {
		return typeId;
	}

	public void setTypeId(Long typeId) {
		this.typeId = typeId;
	}

	/*public String getContactType() {
		return contactType;
	}

	public void setContactType(String contactType) {
		this.contactType = contactType;
	}*/

	public ContactType getContactType() {
		return contactType;
	}

	public void setContactType(ContactType contactType) {
		this.contactType = contactType;
	}

	public Person getPerson() {
		return person;
	}

	public void setPerson(Person person) {
		this.person = person;
	}
}