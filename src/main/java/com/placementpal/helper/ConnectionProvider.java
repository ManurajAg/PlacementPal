package com.placementpal.helper;

import java.sql.Connection;
import java.sql.DriverManager;

public class ConnectionProvider {
	private static Connection con;
	
	public static Connection getConnection() {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/placementpal","root","root");
		
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return con;
	}
	
}
