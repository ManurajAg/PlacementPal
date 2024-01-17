<%@page import="com.placementpal.entities.Job"%>
<%@page import="com.placementpal.helper.ConnectionProvider"%>
<%@page import="com.placementpal.helper.UtilityFunctions"%>
<%@page import="com.placementpal.dao.JobDao"%>
<%@page import="com.placementpal.entities.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	User user = (User)session.getAttribute("currentUser");
	if(user == null){
		response.sendRedirect("index.jsp");
	}
	int jid =Integer.parseInt(request.getParameter("jid"));
	JobDao dao = new JobDao(ConnectionProvider.getConnection());
	Job job = dao.getJobByJID(jid);
	String sal = job.getSalary();
	sal = UtilityFunctions.returnSalary(sal);
	
%>
<!DOCTYPE html>
	<html>
		<head>
			<meta charset="UTF-8">
			<title><%=job.getCompany()%> || <%=job.getRole() %></title>
			<!-- BootStrap -->
			<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
			<!-- fontawesome -->
			<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
			<style>
				.primaryBtn{
					border: 1px solid #007BFF;
    				border-radius :8px;
    				color:#007BFF;
				}
				.primaryBtn:hover{
					background:#007BFF;
					color:white;
				}
				.text-green{
					color:green;
				}
				html{
				scroll-behavior: smooth;
				}
				.heavyWeight{
					font-weight:700;
				}
				.mediumWeigth{
					font-weight:400;
				}
				.mediumSize{
					font-size:20px;
				}
				.textSize{
					font-size:18px;
				}
			</style>
		</head>
		<body>
			<!-- navbar -->
			<nav class="navbar primaryColor bg-light justify-content-between">
 				<!-- Image and text -->
 				<div class = "container">
 					<a class="navbar-brand priamryColor" href="index.jsp"><img src="img/brbg.png" width="30" height="30" class="d-inline-block align-top" alt=""> Placement Pal</a>	
 				</div>
   				<a href = "#" class="btn btn-outline-primaryBtn primaryBorder mx-2 my-2 my-sm-0" data-toggle = "modal" data-target = "#profile-modal">Profile</a>
   				<a href="LogoutServlet" class="btn  btn-outline-danger primaryBorder my-2 my-sm-0">Logout</a>
  
			</nav>
			<section class = "my-4">
				<div class = "container" id = "jobDescription">
					<h1 style = "font-weight :700";><%=job.getCompany() %> Hiring</h1>
					<div class="row my-5">
						<div class="col">
							<p class = "heavyWeight mediumSize">Role :</p><p class = "textSize"><%=job.getRole()%></p>
						</div>
						<div class="col">
							<p class = "heavyWeight mediumSize">Salary :</p><p class = "textSize"><%=job.getSalary()%></p>
						</div>
						<div class="col">
							<p class = "heavyWeight mediumSize">Location :</p><p class = "textSize"><%=job.getLocation()%></p>
						</div>
						<div class="col">
							<p class = "heavyWeight mediumSize">Bond :</p><p class = "textSize" id = "bond"><%=job.getBond()%></p>
						</div>
						
					</div>
					<div class="row">
						<div class="col-3">
							<p class = "heavyWeight mediumSize">Type :</p><p class = "textSize" id = "type"><%=job.getType()%></p>
						</div>
						<div class="col-3">
							<p class = "heavyWeight mediumSize">Test Date :</p><p class = "textSize"><%=job.getTestDate()%></p>
						</div>
						<div class="col-6">
							<p class = "heavyWeight mediumSize">Skills :</p><p class = "textSize"><%=job.getSkills()%></p>
						</div>
						<h5 class = "heavyWeight my-4">Educational Requirements </h5>
					</div>
					<div class = "row my-3">
						<div class="col-3">
							<p class = "heavyWeight mediumSize">B.Tech :</p><p class = "textSize">
							<%	if(job.getBtech()==0.0){ %>
							Not Specified
							<%}else{%>
							<%=job.getBtech() %>
							<%}%></p>
						</div>
						<div class="col-3">
							<p class = "heavyWeight mediumSize">XII :</p><p class = "textSize">
							<%	if(job.getXii()==0.0){ %>
							Not Specified
							<%}else{%>
							<%=job.getXii() %>
							<%}%>
						</div>
						<div class="col-6">
							<p class = "heavyWeight mediumSize">X :</p><p class = "textSize">
							<%	if(job.getX()==0.0){ %>
							Not Specified
							<%}else{%>
							<%=job.getX() %>
							<%}%></p>
						</div>
						<h5 class = "heavyWeight my-4">Additional Information </h5>
					</div>
					<div class = "row my-3">
						<div class = "col-6">
							<p class = "heavyWeight mediumSize">Bond Information :</p><p class = "textSize">
							<%
								if(job.getBondInfo() == null){
							%>
							Not Specified
							<%}else{ %>
							<%=job.getBondInfo()%>
							<%}%></p>
						</div>
						<div class = "col-6">
							<p class = "heavyWeight mediumSize">Selection Procedure :</p><p class = "textSize">
							<%
								if(job.getSelectionProcedure() == null){
							%>
							Not Specified
							<%}else{ %>
							<%=job.getSelectionProcedure()%>
							<%}%></p>
						</div>
					</div>
					<div class = "container text-center" style=text-align:"center">
						<a href = "profile.jsp#jobsSection" class = "btn btn-primary btn-outline-primary">Back</a>
						<button  type = "button" id = "editJobBtn" class = "btn btn-primary btn-outline-primary">Edit</button>
						<a href = "DownloadCV?fileName=<%=job.getResume()%>" class = "btn btn-primary btn-outline-primary">Download CV</a>
					</div>
				</div>
				
				<!-- Edit job description -->
				<div class = "container" id = "editJobDescription" style = "display:none;">
					<form action = "UpdateJobServlet" method = "POST" id = "editJobform" enctype = "multipart/form-data">
					<h1 style = "font-weight :700;"><%=job.getCompany() %> Hiring</h1>
					<input type ="hidden" name = "jid" value = "<%=job.getJid() %>">
					<div class="row my-5">
						<div class="col">
							<p class = "heavyWeight mediumSize">Role :</p>
							<input type ="text" class = "form-control" name = "role" value = "<%=job.getRole()%>">
							
						</div>
						<div class="col">
							<p class = "heavyWeight mediumSize">Salary :</p>
							<input type ="text" class = "form-control" name = "salary" value = "<%=sal%>">
							<small>Enter full Salary like if 20LPA then 2000000</small>
						</div>
						<div class="col">
							<p class = "heavyWeight mediumSize">Location :</p>
							<input type ="text" class = "form-control" name = "location" value = "<%=job.getLocation()%>">
						</div>
						<div class="col">
							<p class = "heavyWeight mediumSize">Bond :</p>
							<div class="form-check form-check-inline">
								<input class="form-check-input" type="radio" name="bond" value="Yes" id = "YesBond">
								<label class="form-check-label" for="inlineRadio4">Yes</label>
							</div>
							<div class="form-check form-check-inline">
								<input class="form-check-input" type="radio" name="bond"  value="No" id = "NoBond">
								<label class="form-check-label" for="inlineRadio5">No</label>
							</div>
						</div>
						
					</div>
					<div class="row">
						<div class="col-3">
							<p class = "heavyWeight mediumSize">Type :</p>
							<div class="form-check form-check-inline">
								<input class="form-check-input" type="radio" name="type" id="WFOType" value="WFO">
								<label class="form-check-label" for="inlineRadio1">WFO</label>
							</div>
							<div class="form-check form-check-inline">
								<input class="form-check-input" type="radio" name="type" id="WFHType" value="WFH">
								<label class="form-check-label" for="inlineRadio2">WFH</label>
							</div>
							<div class="form-check form-check-inline">
								<input class="form-check-input" type="radio" name="type" id="HybridType" value="Hybrid">
								<label class="form-check-label" for="inlineRadio3">Hybrid</label>
							</div>
						</div>
						<div class="col-3">
							<p class = "heavyWeight mediumSize">Test Date :</p>
							<input type ="date" class = "form-control" name = "testDate" value = "<%=job.getTestDate()%>">
							
						</div>
						<div class="col-6">
							<p class = "heavyWeight mediumSize">Skills :</p>
							<input type ="text" class = "form-control" name = "skills" value = "<%=job.getSkills()%>">
						</div>
						<h5 class = "heavyWeight my-4">Educational Requirements </h5>
					</div>
					<div class = "row my-3">
						<div class="col-3">
							<p class = "heavyWeight mediumSize">B.Tech :</p><p class = "textSize">
							<%	if(job.getBtech()==0.0){ %>
							<input type ="text" class = "form-control" name = "btech">
							<%}else{%>
							<input type ="text" class = "form-control" name = "btech" value="<%=job.getBtech()%>">
							<%}%></p>
						</div>
						<div class="col-3">
							<p class = "heavyWeight mediumSize">XII :</p><p class = "textSize">
							<%	if(job.getXii()==0.0){ %>
							<input type ="text" class = "form-control" name = "hsc">
							<%}else{%>
							<input type ="text" class = "form-control" name = "hsc" value="<%=job.getXii()%>">
							<%}%>
						</div>
						<div class="col-3">
							<p class = "heavyWeight mediumSize">X :</p><p class = "textSize">
							<%	if(job.getX()==0.0){ %>
							<input type ="text" class = "form-control" name = "highSchool">
							<%}else{%>
							<input type ="text" class = "form-control" name = "highSchool" value = "<%=job.getX()%>">
							<%}%></p>
						</div>
						<div class = "col-3">
							<p class = "heavyWeight mediumSize">Resume :</p><p class = "textSize">
							<input type = "file" name = "resume" class = "form-control" value = "<%=job.getResume()%>"></p>
						</div>
						<h5 class = "heavyWeight my-4">Additional Information </h5>
					</div>
					<div class = "row my-3">
						<div class = "col-6">
							<p class = "heavyWeight mediumSize">Bond Information :</p><p class = "textSize">
							<%
								if(job.getBondInfo() == null){
							%>
							<input type ="text" class = "form-control" name = "bondInformation">
							<%}else{ %>
							<input type ="text" class = "form-control" name = "bondInformation" value="<%=job.getBondInfo()%>">
							<%}%>
						</div>
						<div class = "col-6">
							<p class = "heavyWeight mediumSize">Selection Procedure :</p><p class = "textSize">
							<%
								if(job.getSelectionProcedure() == null){
							%>
							<textarea class="form-control" name = "selectionProcedure" id="exampleFormControlTextarea1" rows="3"></textarea>
							<%}else{ %>
							<textarea class="form-control" name = "selectionProcedure" id="exampleFormControlTextarea1" rows="3"><%=job.getSelectionProcedure()%></textarea>
							<%}%>
							
						</div>
					</div>
					<div class = "container text-center" style=text-align:"center" id = "editJobSubmitController">
						<button type = "submit" class = "btn btn-primary btn-outline-primary" id = "editJobSubmit" >Save</button>
						<a href = "#" class = "btn btn-primary btn-outline-primary" id ="cancelJobEdit">Cancel</a>
						
					</div>
						
					</form>
					<div class="container text-center" id="jobEditloader" style="display: none;">
						<span class="fa fa-refresh fa-spin fa-3x"></span><br>
						<h4>Please Wait...</h4>
					</div>
				</div>
			</section>
			
			
			<!------------------- Modals ------------------------------->
					
		<!-- Profile Modal -->
		<div class="modal" id="profile-modal" tabindex="-1" role="dialog">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title">Profile</h5>
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
						<div class = "container text-center">
						
						<img src = "profilePics/<%=user.getProfile()%>" style = "border-radius:50%; max-width:150px;"><br>
							<h5 class = "modal-title mt-3" id = "exampleModalLabel"></h5>
							<div id = "profileDetails">
								<table class = "table">
									<tr>
										<th scope="row">ID :</th>
										<td><%=user.getId()%></td>
									</tr>
									<tr>
										<th scope="row">Name :</th>
										<td><%=user.getName()%></td>
									</tr>
									<tr>
										<th scope="row">Email :</th>
										<td><%=user.getEmail()%></td>
									</tr>
									<tr>
										<th scope="row">Gender :</th>
										<td><%=user.getGender()%></td>
									</tr>
								</table>
							</div>
							<!-- edit profile -->
							<div id = "editprofileDetails" style="display:none;">
							<h3 class = "mt-2">Please Edit Carefully</h3>
							<form action = "ProfileEditServlet" method = "POST" enctype="multipart/form-data">
						
								<table class = "table">
									<tr>
										<th scope="row">ID :</th>
										<td><%=user.getId() %></td>
									</tr>
									<tr>
										<th scope="row">Name :</th>
										<td><input type ="text" class = "form-control" name = "user_name" value = "<%=user.getName()%>"> 
										</td>
									</tr>
									<tr>
										<th scope="row">Email :</th>
										<td><input type ="email" class = "form-control" name = "user_email" value = "<%=user.getEmail()%>"> 
										</td>
									</tr>
									<tr>
										<th scope="row">Password :</th>
										<td><input type ="password" class = "form-control" name = "user_password" value = "<%=user.getPassword()%>"> 
										</td>
									</tr>
									<tr>
										<th scope="row">Gender :</th>
										<td><%=user.getGender().toUpperCase()%></td>
									</tr>
									<tr>
										<th scope="row">Profile Pic :</th>
										<td><input type = "file" name = "image" class = "form-control"></td>
									</tr>
								</table>
								<div class = "container" >
									<button type = "submit" class = "btn btn-outline-primary">Save</button>
								</div>
							</form>
						</div>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-primary" id="editButton">Edit</button>
						<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
					</div>
				</div>
			</div>
		</div>
		<!-- JS -->
		<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
		<script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
		<script src = "js/myjs.js" type = "text/javascript"></script>
		<!-- handling profile edit -->
		<script>
			$(document).ready(function(){
				let editStatus = false;
				$('#editButton').click(function(){
					if(editStatus == false){
						$('#profileDetails').hide();
						$('#editprofileDetails').show();
						editStatus = true;
						$(this).text("Back");	
					}
					else{
						$('#profileDetails').show();
						$('#editprofileDetails').hide();
						editStatus = false;
						$(this).text("Edit");
					}
					
					
				});
			});
		</script>
		<!--  setting bond and type -->
		<script>
			let bondDetails = document.getElementById("bond").textContent+"Bond";
			let typeDetails = document.getElementById("type").textContent+"Type";
			document.getElementById(bondDetails).checked = true;
			document.getElementById(typeDetails).checked = true;
		</script>
		<!--  handling job edit -->
		<script>
			$(document).ready(function(){
				$("#editJobBtn").click(function(){
					
					$('#jobDescription').hide();
					$('#editJobDescription').show();	
				});
				
				$("#cancelJobEdit").click(function(){
					$('#editJobDescription').hide();
					$('#jobDescription').show();
				})
			});
		</script>
		
		<!-- handling job edit -->
		<script>
			$(document).ready(function(){
				$('#editJobform').on("submit",function(event){
						event.preventDefault();
						$('#editJobSubmitController').hide();
						$('#jobEditloader').show();
						let  f = new FormData(this);
						$.ajax({
							url:'UpdateJobServlet',
							data:f,
							type:'POST',
							success:function(data,textStatus,jqXHR){
								$('#jobDescription').show();
								$('#editJobSubmitController').show();
								$('#editJobDescription').hide();
								$("#jobEditloader").hide();
								if(data.trim()==='Done'){
									swal({
										  title: "Yo!",
										  text: "Job Updated, Kindly Refresh",
										  icon: "success",
										  button: "Ok",
										});
									
								}
								else{
									swal(data);
								}
							},
							error:function(jqXHR,textStatus,errorThrown){
								console.log(jqXHR);
								$('#editJobSubmitController').show();
								$("#jobEditloader").hide();
								swal({
									  title: "Oops",
									  text: "Something Went wrong",
									  icon: "error",
									  button: "Ok",
									});
								
							},
							processData:false,
							contentType:false
							
						});
						
				});
			});
		</script>
		</body>
	</html>