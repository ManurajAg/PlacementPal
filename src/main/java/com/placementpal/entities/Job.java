package com.placementpal.entities;

import java.sql.Date;

public class Job {

	private int jid;
	private String company;
	private String role;
	private String salary;
	private String location;
	private String type;
	private String bond;
	private Date testDate;
	private String skills;
	private String resume;
	private float btech;
	private float xii;
	private float x;
	private String bondInfo;
	private String selectionProcedure;
	private int userId;
	
	
	//Default Constructor
	public Job() {
		// TODO Auto-generated constructor stub
	}

	//constructor with all parameters
	public Job(int jid, String company, String role, String salary, String location, String type, String bond,Date testDate, String skills, String resume, float btech, float xii, float x, String bondInfo,String selectionProcedure, int userId) {
		
		this.jid = jid;
		this.company = company;
		this.role = role;
		this.salary = salary;
		this.location = location;
		this.type = type;
		this.bond = bond;
		this.testDate = testDate;
		this.skills = skills;
		this.resume = resume;
		this.btech = btech;
		this.xii = xii;
		this.x = x;
		this.bondInfo = bondInfo;
		this.selectionProcedure = selectionProcedure;
		this.userId = userId;
		
	}
	
	//constructor without job id
	public Job(String company, String role, String salary, String location, String type, String bond, Date testDate, String skills, String resume, float btech, float xii, float x, String bondInfo,String selectionProcedure, int userId) {
		this.company = company;
		this.role = role;
		this.salary = salary;
		this.location = location;
		this.type = type;
		this.bond = bond;
		this.testDate = testDate;
		this.skills = skills;
		this.resume = resume;
		this.btech = btech;
		this.xii = xii;
		this.x = x;
		this.bondInfo = bondInfo;
		this.selectionProcedure = selectionProcedure;
		this.userId = userId;
	}
	//constructor containing only mandatory fields
	public Job(String company, String role, String salary, String location, String type, String bond, String skills, int userId) {
		this.company = company;
		this.role = role;
		this.salary = salary;
		this.location = location;
		this.type = type;
		this.bond = bond;
		this.skills = skills;
		this.userId = userId;
	}
	
	
	//getters and setters
	public int getJid() {
		return jid;
	}
	public void setJid(int jid) {
		this.jid = jid;
	}
	public String getCompany() {
		return company;
	}
	public void setCompany(String company) {
		this.company = company;
	}
	public String getRole() {
		return role;
	}
	public void setRole(String role) {
		this.role = role;
	}
	public String getSalary() {
		return salary;
	}
	public void setSalary(String salary) {
		this.salary = salary;
	}
	public String getLocation() {
		return location;
	}
	public void setLocation(String location) {
		this.location = location;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getBond() {
		return bond;
	}
	public void setBond(String bond) {
		this.bond = bond;
	}
	
	public Date getTestDate() {
		return testDate;
	}

	public void setTestDate(Date testDate) {
		this.testDate = testDate;
	}

	public String getSkills() {
		return skills;
	}
	public void setSkills(String skills) {
		this.skills = skills;
	}
	public String getResume() {
		return resume;
	}
	public void setResume(String resume) {
		this.resume = resume;
	}
	public float getBtech() {
		return btech;
	}
	public void setBtech(float btech) {
		this.btech = btech;
	}
	public float getXii() {
		return xii;
	}
	public void setXii(float xii) {
		this.xii = xii;
	}
	public float getX() {
		return x;
	}
	public void setX(float x) {
		this.x = x;
	}
	public String getBondInfo() {
		return bondInfo;
	}
	public void setBondInfo(String bondInfo) {
		this.bondInfo = bondInfo;
	}
	public String getSelectionProcedure() {
		return selectionProcedure;
	}
	public void setSelectionProcedure(String selectionProcedure) {
		this.selectionProcedure = selectionProcedure;
	}
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
}
