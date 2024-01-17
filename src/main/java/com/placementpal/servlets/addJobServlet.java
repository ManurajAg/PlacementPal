package com.placementpal.servlets;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;
import java.util.UUID;
import java.sql.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import java.lang.*;

import com.oreilly.servlet.MultipartRequest;
import com.placementpal.dao.JobDao;
import com.placementpal.entities.Job;
import com.placementpal.entities.User;
import com.placementpal.helper.ConnectionProvider;
import com.placementpal.helper.Helper;

/**
 * Servlet implementation class addJobServlet
 */
@MultipartConfig
@WebServlet("/addJobServlet")
public class addJobServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public addJobServlet() {
        super();
        // TODO Auto-generated constructor stub
    }


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		HttpSession session = request.getSession();
		User user = (User)session.getAttribute("currentUser");
		//fetching data from form
		String company = request.getParameter("company_name");
		String role = request.getParameter("role");
		String location = request.getParameter("location");
		String type = request.getParameter("type");
		String bond = request.getParameter("bond");
		String skills = request.getParameter("skills");
		String salary = request.getParameter("salary");
		Float sal = Float.parseFloat(salary);
		//performing conversion on salary
		sal = sal/100000;
		salary = sal.toString()+"LPA";
		Job job = new Job(company,role,salary,location,type,bond,skills,user.getId());
		//checking if not mandatory fields are filled or not
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
		
		//saving job to database
		JobDao dao = new JobDao(ConnectionProvider.getConnection());
		if(dao.saveJob(job)) {
			out.println("Done");
		}
		else {
			out.println("Error");
		}
		
		
	}

}
