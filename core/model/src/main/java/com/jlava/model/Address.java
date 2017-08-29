package com.jlava.model;

import javax.persistence.Embeddable;
import javax.persistence.Column;

@Embeddable
public class Address {

	@Column(name="street", length=50)
	private String street;

	@Column(name="barangay", length=50)
	private String barangay;

	@Column(name="municipality", length=50)
	private String municipality;

	@Column(name="zipcode")
	private Integer zipCode;

	public Address() {}
	public Address(String street, String barangay, String municipality, Integer zipCode) {
		this.street = street;
		this.barangay = barangay;
		this.municipality = municipality;
		this.zipCode = zipCode;
	}

	public String getStreet() {
		return street;
	}

	public void setStreet(String street) {
		this.street = street;
	}

	public String getBarangay() {
		return barangay;
	}

	public void setBarangay(String barangay) {
		this.barangay = barangay;
	}

	public String getMunicipality() {
		return municipality;
	}

	public void setMunicipality(String municipality) {
		this.municipality = municipality;
	}

	public Integer getZipCode() {
		return zipCode;
	}

	public void setZipCode(Integer zipCode) {
		this.zipCode = zipCode;
	}

	public String toString(){ 
		String streetStr = (street != null)?street + ", ":"";
		String bgyStr = (barangay != null)?" brgy. " + barangay  + ", ": "";
		String muniStr = (municipality != null)?municipality : "";
		String zipStr = (zipCode <= 0)?", " + zipCode : "";

		return streetStr + bgyStr + muniStr + zipStr;
	}
}