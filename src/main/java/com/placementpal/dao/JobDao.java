package com.placementpal.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.*;

import com.placementpal.entities.Job;

public class JobDao {

	Connection con = null;
	
	public JobDao(Connection con) {
		this.con = con;
	}
	
	public boolean saveJob(Job job) {
		boolean f=false;
		try {
			String query = "insert into jobs (company,role,salary,location,type,bond,testDate,skills,resume,btech,xii,x,bondInfo,selectionProcedure,userId) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
			PreparedStatement ps = con.prepareStatement(query);
			ps.setString(1, job.getCompany());
			ps.setString(2, job.getRole());
			ps.setString(3, job.getSalary());
			ps.setString(4, job.getLocation());
			ps.setString(5, job.getType());
			ps.setString(6, job.getBond());
			ps.setDate(7, job.getTestDate());
			ps.setString(8, job.getSkills());
			ps.setString(9, job.getResume());
			ps.setFloat(10, job.getBtech());
			ps.setFloat(11, job.getXii());
			ps.setFloat(12, job.getX());
			ps.setString(13, job.getBondInfo());
			ps.setString(14, job.getSelectionProcedure());
			ps.setInt(15, job.getUserId());
			ps.execute();
			f = true;
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return f;
	}
	
	public List<Job> getJobByUserId(int userId){
		List<Job> arr = new ArrayList<>();
		try {
			String query = "select * from jobs where userId = ?";
			PreparedStatement ps = con.prepareStatement(query);
			ps.setInt(1, userId);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				Job job = new Job();
				job.setJid(rs.getInt("jid"));
				job.setCompany(rs.getString("company"));
				job.setRole(rs.getString("role"));
				job.setSalary(rs.getString("salary"));
				job.setLocation(rs.getString("location"));
				job.setType(rs.getString("type"));
				job.setBond(rs.getString("bond"));
				job.setTestDate(rs.getDate("testDate"));
				job.setSkills(rs.getString("skills"));
				job.setResume(rs.getString("resume"));
				job.setBtech(rs.getFloat("btech"));
				job.setXii(rs.getFloat("xii"));
				job.setX(rs.getFloat("x"));
				job.setBondInfo(rs.getString("bondInfo"));
				job.setSelectionProcedure(rs.getString("selectionProcedure"));
				job.setUserId(rs.getInt("userId"));
				arr.add(job);
			}
			
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return arr;
	}
	
	public boolean removeJob(int jid) {
		boolean f = false;
		try {
			String query = "delete from jobs where jid = ?";
			PreparedStatement ps = con.prepareStatement(query);
			ps.setInt(1, jid);
			ps.executeUpdate();
			f = true;
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return f;
	}

	public int removeOldJobs(int userId) {
		int count = 0;
		try {
			String query = "delete from jobs where userId = ? AND testDate < ?";
			PreparedStatement ps = con.prepareStatement(query);
			ps.setInt(1, userId);
			long millis=System.currentTimeMillis();  
			Date date = new Date(millis);
			ps.setDate(2,date);
			count = ps.executeUpdate();
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return count;
	}

	public Job getJobByJID(int jid) {
		Job job = null;
		try {
			String query = "Select * from jobs where jid = ?";
			PreparedStatement ps = con.prepareStatement(query);
			ps.setInt(1, jid);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				job = new Job();
				job.setJid(rs.getInt("jid"));
				job.setCompany(rs.getString("company"));
				job.setRole(rs.getString("role"));
				job.setSalary(rs.getString("salary"));
				job.setLocation(rs.getString("location"));
				job.setBond(rs.getString("bond"));
				job.setType(rs.getString("type"));
				job.setTestDate(rs.getDate("testDate"));
				job.setSkills(rs.getString("skills"));
				job.setResume(rs.getString("resume"));
				job.setBtech(rs.getFloat("btech"));
				job.setXii(rs.getFloat("xii"));
				job.setX(rs.getFloat("x"));
				job.setBondInfo(rs.getString("bondInfo"));
				job.setSelectionProcedure(rs.getString("selectionProcedure"));
				job.setUserId(rs.getInt("userId"));
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return job;
	}

	public boolean updateJob(Job job) {
		boolean f = false;
		try {
			String query = "update jobs set company=?,role=?,salary=?,location=?,type=?,bond=?,testDate=?,skills=?,resume=?,btech=?,xii=?,x=?,bondInfo=?,selectionProcedure=? where jid = ?";
			PreparedStatement ps = con.prepareStatement(query);
			ps.setString(1, job.getCompany());
			ps.setString(2, job.getRole());
			ps.setString(3, job.getSalary());
			ps.setString(4, job.getLocation());
			ps.setString(5, job.getType());
			ps.setString(6, job.getBond());
			ps.setDate(7, job.getTestDate());
			ps.setString(8, job.getSkills());
			ps.setString(9, job.getResume());
			ps.setFloat(10, job.getBtech());
			ps.setFloat(11, job.getXii());
			ps.setFloat(12, job.getX());
			ps.setString(13, job.getBondInfo());
			ps.setString(14, job.getSelectionProcedure());
			ps.setInt(15, job.getJid());
			ps.executeUpdate();
			f = true;
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return f;
	}
}
