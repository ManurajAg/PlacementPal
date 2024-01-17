package com.placementpal.servlets;

import java.io.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.placementpal.entities.Message;

/**
 * Servlet implementation class DownloadCV
 */
@WebServlet("/DownloadCV")
public class DownloadCV extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DownloadCV() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		PrintWriter out = response.getWriter();
		String fileName = request.getParameter("fileName");
		String path = request.getRealPath("/")+"Resume"+File.separator+fileName;
		File dwFile = new File(path);
		if(dwFile.exists()) {
			response.setContentType("application/octet-stream");
			response.setContentLength((int)dwFile.length());
			String hkey = "Content-Disposition";
			String hvalue = String.format("attachement;filename=\"%s\"",dwFile.getName());
			response.setHeader(hkey, hvalue);
			FileInputStream in = new FileInputStream(dwFile);
			int i ;
			while((i=in.read())!=-1) {
				out.write(i);
			}
			in.close();
			out.close();
		}
		else {
			Message msg = new Message("No CV Uploaded","Error","text-red");
			HttpSession session = request.getSession();
			session.setAttribute("msg2", msg);
			response.sendRedirect("profile.jsp#jobsSection");
		}
	}

}
