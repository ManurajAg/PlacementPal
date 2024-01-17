package com.placementpal.servlets;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import com.placementpal.dao.JobDao;
import com.placementpal.entities.Job;
import com.placementpal.entities.User;
import com.placementpal.helper.ConnectionProvider;
import com.placementpal.helper.Helper;

/**
 * Servlet implementation class UpdateJobServlet
 */
@MultipartConfig
@WebServlet("/UpdateJobServlet")
public class UpdateJobServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdateJobServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession();
		User user = (User)session.getAttribute("currentUser");
		PrintWriter out = response.getWriter();
		JobDao dao = new JobDao(ConnectionProvider.getConnection());
		int jid = Integer.parseInt(request.getParameter("jid"));
		Job job = dao.getJobByJID(jid);
		job.setRole(request.getParameter("role"));
		String salary = request.getParameter("salary");
		Float sal = Float.parseFloat(salary);
		//performing conversion on salary
		sal = sal/100000;
		salary = sal.toString()+"LPA";
		job.setSalary(salary);
		job.setLocation(request.getParameter("location"));
		job.setBond(request.getParameter("bond"));
		job.setType(request.getParameter("type"));
		
		String btech = request.getParameter("btech");
		if(!btech.isEmpty()) job.setBtech(Float.parseFloat(btech));
		
		String hsc = request.getParameter("hsc");
		if(!hsc.isEmpty()) job.setXii(Float.parseFloat(hsc));
		
		
		String highSchool = request.getParameter("highSchool");
		if(!highSchool.isEmpty()) job.setX(Float.parseFloat(highSchool));
		
		
		String bondInfo = request.getParameter("bondInformation");
		if(!bondInfo.isEmpty()) job.setBondInfo(bondInfo);
		
		
		String selectionProcedure = request.getParameter("selectionProcedure");
		if(!selectionProcedure.isEmpty()) job.setSelectionProcedure(selectionProcedure);
		
		
		String date = request.getParameter("testDate");
		if(!date.isEmpty()) {
			Date testDate = Date.valueOf(date);
			job.setTestDate(testDate);
		}		
		Part resume = request.getPart("resume");
		String concatFile = user.getId()+UUID.randomUUID().toString();
		String fileName = concatFile+resume.getSubmittedFileName();
		if(!fileName.equals(concatFile)) {
			job.setResume(fileName);
			String path = request.getRealPath("/")+"Resume"+File.separator+fileName;
			Helper.saveFile(resume.getInputStream(), path);	
		}
		if(dao.updateJob(job))	out.println("Done");
		else out.println("Error");
	}

}
