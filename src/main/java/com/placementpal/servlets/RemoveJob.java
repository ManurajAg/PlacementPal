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
import com.placementpal.helper.ConnectionProvider;

/**
 * Servlet implementation class RemoveJob
 */
@WebServlet("/RemoveJob")
public class RemoveJob extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RemoveJob() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		JobDao dao = new JobDao(ConnectionProvider.getConnection());
		int jid = Integer.parseInt(request.getParameter("jid"));
		HttpSession session = request.getSession();
		if(dao.removeJob(jid))	{
			Message msg2 = new Message("Removed Successfully","Success","text-green");
			session.setAttribute("msg2", msg2);
		}
		else {
			Message msg2 = new Message("Something Went Wrong","Error","text-red");
			session.setAttribute("msg2", msg2);
		}
		response.sendRedirect("profile.jsp#jobsSection");
	}

	

}
