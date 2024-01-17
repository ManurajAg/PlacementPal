package com.placementpal.entities;

import java.sql.Timestamp;

public class User {
	private int id;
	private String name;
	private String email;
	private String password;
	private String gender;
	private String profile;
	private Timestamp rDate;
	
	//constructor with id;
	public User(int id, String name, String email, String password, String gender, String profile, Timestamp rDate) {
		this.id = id;
		this.name = name;
		this.email = email;
		this.password = password;
		this.gender = gender;
		this.profile = profile;
		this.rDate = rDate;
	}
	
	//constructor without id
	public User(String name, String email, String password, String gender, String profile) {
		this.name = name;
		this.email = email;
		this.password = password;
		this.gender = gender;
		this.profile = profile;
	}
	//constructor for default profile pic
	public User(String name, String email, String password, String gender) {
		this.name = name;
		this.email = email;
		this.password = password;
		this.gender = gender;
	}

	//getters and setters
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getProfile() {
		return profile;
	}

	public void setProfile(String profile) {
		this.profile = profile;
	}

	public Timestamp getrDate() {
		return rDate;
	}

	public void setrDate(Timestamp rDate) {
		this.rDate = rDate;
	}

	
	
	
	
	
}
