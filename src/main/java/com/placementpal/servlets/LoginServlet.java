package com.placementpal.servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.placementpal.helper.ConnectionProvider;
import com.placementpal.dao.*;
import com.placementpal.entities.Message;
import com.placementpal.entities.User;
/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginServlet() {
        super();
        // TODO Auto-generated constructor stub
    }
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String email = request.getParameter("user_email");
		String password = request.getParameter("user_password");
		UserDao dao = new UserDao(ConnectionProvider.getConnection());
		User user = (User)dao.getUserByEmailAndPassword(email, password);
		if(user == null) {
			Message msg = new Message("Invalid Credentials","Error","credentialsWarning");
			HttpSession session = request.getSession();
			session.setAttribute("msg",msg);
			response.sendRedirect("index.jsp");
		}
		else {
			HttpSession session = request.getSession();
			session.setAttribute("currentUser",user);
			response.sendRedirect("profile.jsp");
		}
	}

}
