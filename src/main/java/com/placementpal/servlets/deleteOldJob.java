package com.placementpal.servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.placementpal.dao.JobDao;
import com.placementpal.entities.Message;
import com.placementpal.entities.User;
import com.placementpal.helper.ConnectionProvider;

/**
 * Servlet implementation class deleteOldJob
 */
@WebServlet("/deleteOldJob")
public class deleteOldJob extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public deleteOldJob() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession();
		User user = (User)session.getAttribute("currentUser");
		JobDao dao = new JobDao(ConnectionProvider.getConnection());
		
		if(dao.removeOldJobs(user.getId())>=0){
			
			response.getWriter().println("Done");
		}
		else {
			response.getWriter().println("Error");
		}
	}

}
