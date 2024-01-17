package com.placementpal.servlets;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.placementpal.dao.UserDao;
import com.placementpal.entities.User;
import com.placementpal.helper.ConnectionProvider;
import com.placementpal.helper.Helper;

/**
 * Servlet implementation class RegisterServlet
 */
@MultipartConfig
@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RegisterServlet() {
        super();
        // TODO Auto-generated constructor stub
    }


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		PrintWriter out = response.getWriter();
		response.setContentType("text/html");
		String TandC = request.getParameter("checked");
		if(TandC == null) {
			out.println("Please Accept Terms and Conditions");
		}
		else {
			String name = request.getParameter("userName");
			String email = request.getParameter("userEmail");
			String password = request.getParameter("userPassword");
			String gender = request.getParameter("gender");
			Part profilePic = request.getPart("userProfilePic");
			String image = email+profilePic.getSubmittedFileName();
//			out.println(image);
			User user = null;
			if(image.equals(email)) {
				user = new User(name,email,password,gender);	
			}
			else {
				user = new User(name,email,password,gender,image);
				String path = request.getRealPath("/")+"profilePics"+File.separator+image;
				Helper.saveFile(profilePic.getInputStream(), path);
				System.out.println(path);
			}
			UserDao dao = new UserDao(ConnectionProvider.getConnection());
			if(dao.saveUser(user)) {
				out.println("Done");
			}
			else {
				out.println("Error");
			}
		}
		
		
		
	}

}
