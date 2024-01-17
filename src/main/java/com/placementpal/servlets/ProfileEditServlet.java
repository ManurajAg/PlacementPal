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
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import java.util.*;

import com.placementpal.dao.UserDao;
import com.placementpal.entities.Message;
import com.placementpal.entities.User;
import com.placementpal.helper.ConnectionProvider;
import com.placementpal.helper.Helper;

/**
 * Servlet implementation class ProfileEditServlet
 */
@MultipartConfig
@WebServlet("/ProfileEditServlet")
public class ProfileEditServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ProfileEditServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		PrintWriter out = response.getWriter();
		String userName = request.getParameter("user_name");
		String userEmail = request.getParameter("user_email");
		String userPassword = request.getParameter("user_password");
		Part profilePic = request.getPart("image");
		String fileName = userEmail+profilePic.getSubmittedFileName();
		HttpSession session = request.getSession();
		User user = (User)session.getAttribute("currentUser");
		if(user == null) {
			response.sendRedirect("index.jsp");
		}
		else {
			user.setName(userName);
			user.setEmail(userEmail);
			user.setPassword(userPassword);
			if(!fileName.equals(userEmail)) {
				user.setProfile(fileName);
				String path = request.getRealPath("/")+"profilePics"+File.separator+fileName;
				Helper.saveFile(profilePic.getInputStream(),path);
			}
			UserDao dao = new UserDao(ConnectionProvider.getConnection());
			if(dao.updateUser(user)) {
				Message msg = new Message("Updated Successfully","credentialsSuccess","text-green");
				session.setAttribute("msg",msg);
			}
			else {
				Message msg = new Message("Something Went Wrong","Error","credentialsWarning");
				session.setAttribute("msg",msg);
			}
			response.sendRedirect("profile.jsp");
		}

	}

}
