<%@page import="com.placementpal.entities.Job"%>
<%@page import="java.util.List"%>
<%@page import="com.placementpal.helper.ConnectionProvider"%>
<%@page import="com.placementpal.dao.JobDao"%>
<%@page import="com.placementpal.entities.Message"%>
<%@page import="com.placementpal.entities.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
		User user = (User)session.getAttribute("currentUser");
		if (user == null) {
			response.sendRedirect("index.jsp");
		}
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Dashboard</title>
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
			.text-red{
				color:red;
			}
			html{
			scroll-behavior: smooth;
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
			<section class="welcomeSection my-4" style="height:100vh">

				
				<div class = "container text-center">
					<%
						Message msg = (Message) session.getAttribute("msg");
						if (msg != null) {
					%>
					<div class="alert <%=msg.getCssClass()%>" role="alert">
							<%=msg.getContent()%>
					</div>
					<%
						session.removeAttribute("msg");
						}
					%>
					
  					<img src ="profilePics/<%=user.getProfile()%>" style = "border-radius:50%; max-width:300px;box-shadow: rgba(0, 0, 0, 0.25) 0px 45px 50px, rgba(0, 0, 0, 0.12) 0px -12px 30px, rgba(0, 0, 0, 0.12) 0px 4px 6px, rgba(0, 0, 0, 0.17) 0px 12px 13px, rgba(0, 0, 0, 0.09) 0px -3px 5px;">
  					<br><br><br><br><h2><b>Welcome, <%=user.getName() %></b></h2><br>
  					
  					<i><p>Persist relentlessly in the pursuit of your dreams</p></i>
  					<br>
  					<a href = "#" data-toggle = "modal" data-target = "#addJobModal" class = "btn primaryBtn">Add Job</a>
  					<a href = "#jobsSection" class = "btn primaryBtn">Your Applications</a>
  				</div>
			</section>
			

		<!-- JOBS Section -->
		<section id ="jobsSection" class = "my-4" style = "height:100vh;">
			<%
				Message msg2 =(Message) session.getAttribute("msg2");
				if(msg2!=null){
			%>
			<div class="alert <%=msg2.getCssClass()%>" role="alert"><%=msg2.getContent()%></div>
			<%
					session.removeAttribute("msg2");
				}
			%>
			<nav class="sticky-top navbar-light bg-light">
  				<div id = "controller" class = "container col-md-11">
				
					<a href ="#" data-toggle = "modal" data-target = "#addJobModal" class = "fa fa-plus mx-4 my-4"> Add Job</a>
					<a href ="deleteOldJob" id = "removeOldJobs" class = "fa fa-trash-o mx-4 my-4"> Delete old jobs</a>
					<a href ="profile.jsp" class = "fa fa-refresh mx-4 my-4"> Refresh</a>
					
				</div>
			</nav>
			
			<div class = "container col-md-11" id = "jobsTable">
				<table class = "table mx-6"style = "text-align:center" >
					<thead>
						<tr>
							<th>JID</th>
							<th>Company</th>
							<th>Role</th>
							<th>Salary</th>
							<th>Location</th>
							<th>Type</th>
							<th>Bond</th>
							<th>Date</th>
							<th>Skills</th>
							
						</tr>
					</thead>
					<tbody >
						<%
							JobDao dao = new JobDao(ConnectionProvider.getConnection());
							List<Job> jobList = dao.getJobByUserId(user.getId());
							if(!jobList.isEmpty()){
							
								for(Job job:jobList){
						%>
						<tr>
							<td><%=job.getJid()%></td>
							<td><%=job.getCompany()%></td>
							<td><%=job.getRole()%></td>
							<td><%=job.getSalary()%></td>
							<td><%=job.getLocation()%></td>
							<td><%=job.getType()%></td>
							<td><%=job.getBond()%></td>
							<td><%=job.getTestDate()%></td>
							<td><%=job.getSkills() %></td>
							<td><a href="DownloadCV?fileName=<%=job.getResume()%>" class = "btn btn-outline-success">Download CV</a></td>
							<td><a href = "viewJob.jsp?jid=<%=job.getJid()%>" class = "btn btn-outline-success">View Job</a></td>
							<td><a href = "RemoveJob?jid=<%=job.getJid()%>"class = "btn btn-outline-danger" id = "removeButton">Remove</a></td>
						</tr>
						<%
								}
							}
							else{
						%>
						<tr><td><h5>No Jobs Added</h5></td><tr>
						<%
								}
						%>
					</tbody>
				</table>
			</div>
			<div class="container text-center" id="loader" style="display: none;">
				<span class="fa fa-refresh fa-spin fa-3x"></span><br>
				<h4>Please Wait...</h4>
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
		
		<!-----  Add Job Modal ----->
		<div class="modal" id="addJobModal" tabindex="-1" role="dialog">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title">Add Job</h5>
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
						<div class = "container text-center">
							<!-- add Job -->
							<div id = "fillJobDetails">
							<form id = "add-job-form" action = "addJobServlet" method = "POST" enctype="multipart/form-data">
								<table class = "table">
									<tr>
										<th scope="row">Company <sup style = "color:red">*</sup> :</th>
										<td><input type ="text" class = "form-control" name = "company_name" required > 
										</td>
									</tr>
									<tr>
										<th scope="row">Role <sup style = "color:red">*</sup> :</th>
										<td><input type ="text" class = "form-control" name = "role" required> 
										</td>
									</tr>
									<tr>
										<th scope="row">Salary <sup style = "color:red">*</sup> :</th>
										<td><input type ="text" class = "form-control" name = "salary" required>
										<small>Enter full Salary like if 20LPA then 2000000</small> 
										</td>
									</tr>
									<tr>
										<th scope="row">Location <sup style = "color:red">*</sup> :</th>
										<td><input type ="text" class = "form-control" name = "location" required> 
										</td>
									</tr>
									<tr>
										<th scope="row">Type <sup style = "color:red">*</sup> :</th>
										<td>
											<div class="form-check form-check-inline">
												<input class="form-check-input" type="radio"
													name="type" id="inlineRadio1" value="WFO">
												<label class="form-check-label" for="inlineRadio1">WFO</label>
											</div>
											<div class="form-check form-check-inline">
												<input class="form-check-input" type="radio"
													name="type" id="inlineRadio2" value="WFH">
												<label class="form-check-label" for="inlineRadio2">WFH</label>
											</div>
											<div class="form-check form-check-inline">
												<input class="form-check-input" type="radio"
													name="type" id="inlineRadio3" value="Hybrid"
													> <label class="form-check-label"
													for="inlineRadio3">Hybrid</label>
											</div>
										</td>
									</tr>
									<tr>
										<th scope="row">Bond <sup style = "color:red">*</sup> :</th>
										<td>
										<div class="form-check form-check-inline">
												<input class="form-check-input" type="radio"
													name="bond" id="inlineRadio4" value="Yes">
												<label class="form-check-label" for="inlineRadio4">Yes</label>
											</div>
											<div class="form-check form-check-inline">
												<input class="form-check-input" type="radio"
													name="bond" id="inlineRadio5" value="No">
												<label class="form-check-label" for="inlineRadio5">No</label>
											</div> 
										</td>
									</tr>
									<tr>
										<th scope="row">Date :</th>
										<td><input type ="date" class = "form-control" name = "testDate"> 
										</td>
									</tr>
									<tr>
										<th scope="row">Skills <sup style = "color:red">*</sup> :</th>
										<td><input type ="text" class = "form-control" name = "skills" required> 
										</td>
									</tr>
									<tr>
										<th scope="row">Resume :</th>
										<td><input type = "file" name = "resume" class = "form-control" ></td>
									</tr>
								</table>
								<p>Extra Information</p>
								<table class = "table">
									<tr>
										<th scope="row">B.Tech Percentage :</th>
										<td><input type ="text" class = "form-control" name = "btech"> 
										</td>
									</tr>
									<tr>
										<th scope="row">XII Percentage :</th>
										<td><input type ="text" class = "form-control" name = "hsc"> 
										</td>
									</tr>
									<tr>
										<th scope="row">X Percentage :</th>
										<td><input type ="text" class = "form-control" name = "highSchool"> 
										</td>
									</tr>
									<tr>
										<th scope="row">Bond Information :</th>
										<td><input type ="text" class = "form-control" name = "bondInformation"> 
										</td>
									</tr>
									<tr>
										<th scope="row">Selection Procedure :</th>
										<td>
											<div class="form-group">
												<textarea class="form-control" name = "selectionProcedure" id="exampleFormControlTextarea1" rows="3"></textarea>
											</div>
										</td>
									</tr>
								</table>
								<div class="container text-center" id="loader"
									style="display: none;">
									<span class="fa fa-refresh fa-spin fa-3x"></span><br>
									<h4>Please Wait...</h4>
								</div>
								<div class="modal-footer">
									<button type="submit" id="submit-btn" class="btn btn-primary"
										id="editButton">Add</button>
									<button type="button" class="btn btn-secondary"
										data-dismiss="modal">Close</button>
								</div>
							</form>
						</div>
						</div>
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
		<!-- handling edit -->
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
		<!-- add job -->
		<script>
		$(document).ready(function(){
			$('#add-job-form').on('submit',function(event){
				event.preventDefault();
				$("#submit-btn").hide();
				$("#loader").show();
				let f = new FormData(this);
				$.ajax({
					url:"addJobServlet",
					data:f,
					type:'POST',
					success:function(data,textStatus,jqXHR){
						console.log(data);
						$("#submit-btn").show();
						$("#loader").hide();
							if(data.trim()==='Done'){
								swal({
									  title: "All The Best!",
									  text: "New Job Added",
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
						$("#submit-btn").show();
						$("#loader").hide();
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
		
		<!-- deleting old jobs -->
		<script>
			$(document).ready(function(){
				$("#removeOldJobs").on("click",function(event){
						event.preventDefault();
						$("#jobsTable").hide();
						$("#loader").show();
						$.ajax({
							url:"deleteOldJob",
							type:"GET",
							success:function(data,textStatus,jqXHR){
								$("#jobsTable").show();
								$("#loader").hide();
									if(data.trim()==='Done'){
										swal({
											  title: "Wohoo!",
											  text: "Expired Jobs Removed,kindly Refresh",
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
								$("#jobsTable").show();
								$("#loader").hide();
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