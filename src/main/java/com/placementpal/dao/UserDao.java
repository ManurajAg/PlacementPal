package com.placementpal.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;

import com.placementpal.entities.*;

public class UserDao {

	Connection con = null;
	public UserDao(Connection con) {
		this.con = con;
	}
	
	
	public boolean saveUser(User user) {
		boolean f = false;
		try {
			String query = "insert into users (name,email,password,gender) values (?,?,?,?)";
			PreparedStatement ps = con.prepareStatement(query);
			if(user.getProfile()!=null) {
				query = "insert into users (name,email,password,gender,profile) values (?,?,?,?,?)";
				ps = con.prepareStatement(query);
				ps.setString(5, user.getProfile());
			}
			
			ps.setString(1, user.getName());
			ps.setString(2, user.getEmail());
			ps.setString(3, user.getPassword());
			ps.setString(4, user.getGender());
			ps.execute();
			f = true;
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		
		
		return f;
	}
	
	public User getUserByEmailAndPassword(String email,String password) {
		User user = null;
		try {
			String query = "select * from users where email = ? and password = ?";
			PreparedStatement ps = con.prepareStatement(query);
			ps.setString(1, email);
			ps.setString(2, password);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				int id = rs.getInt("id");
				String userName = rs.getString("name");
				String userEmail = rs.getString("email");
				String userPassword = rs.getString("password");
				String userGender = rs.getString("gender");
				String userProfile = rs.getString("profile");
				Timestamp rDate = rs.getTimestamp("rDate");
				user = new User(id,userName,userEmail,userPassword,userGender,userProfile,rDate);
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return user;
	}
	
	public boolean updateUser(User user) {
		boolean f = false;
		try {
			String query = "update users set name = ?,email = ?,password = ?,profile = ? where id = ?";
			PreparedStatement ps = con.prepareStatement(query);
			ps.setString(1, user.getName());
			ps.setString(2, user.getEmail());
			ps.setString(3, user.getPassword());
			ps.setString(4,user.getProfile());
			ps.setInt(5, user.getId());
			ps.executeUpdate();
			f = true;
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		
		return f;
	}
	
}
