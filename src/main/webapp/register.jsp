<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Register Here</title>
		<!-- CSS -->
		
		<style>
			.primaryColor{
				color: rgb(2,0,36);
    			color: linear-gradient(90deg, rgba(2,0,36,1) 0%, rgba(14,9,121,1) 21%, rgba(8,100,181,1) 64%, rgba(7,116,191,1) 69%, rgba(5,138,205,1) 76%, rgba(0,212,255,1) 100%);
			}
		</style>
		<!-- BootStrap -->
		<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
		<!-- fontawesome -->
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
	</head>
	<body>
		<%@include file = "normal_navbar.jsp" %>
		
		<!-- registration form -->
		<div class = "container my-3">
			<h5>Register here</h5><hr>
			<form action = "RegisterServlet" method = "POST" enctype="multipart/form-data" id="reg-form">
  				<div class="form-group">
    				<label for="username">Name <sup style="color:red">*</sup></label>
    				<input type="text" class="form-control" name = "userName" id="exampleInputEmail1" aria-describedby="emailHelp" placeholder="Enter name" required>
  				</div>
  				<div class="form-group">
    				<label for="exampleInputEmail1">Email address <sup style="color:red">*</sup></label>
    				<input type="email" class="form-control" name = "userEmail" id="exampleInputEmail1" aria-describedby="emailHelp" placeholder="Enter email" required>
	    			<small id="emailHelp" class="form-text text-muted">We'll never share your email with anyone else.</small>
  				</div>
  				<div class="form-group">
    				<label for="exampleInputPassword1">Password <sup style="color:red">*</sup></label>
	    			<input type="password" class="form-control" name = "userPassword" id="exampleInputPassword1" placeholder="Password" required>
  				</div>
  				<div class="form-group">
    				<label for="exampleInputPassword1">Gender</label><br>
	    			<div class="form-check form-check-inline">
  						<input class="form-check-input" type="radio" name="gender" id="inlineRadio1" value="Male">
  						<label class="form-check-label" for="inlineRadio1">Male</label>
					</div>
					<div class="form-check form-check-inline">
  						<input class="form-check-input" type="radio" name="gender" id="inlineRadio2" value="Female">
  						<label class="form-check-label" for="inlineRadio2">Female</label>
					</div>
  				</div>
  				<div class="form-group">
    				<label for="exampleFormControlFile1">Upload Profile Photo</label>
    				<input type="file" class="form-control-file" name = "userProfilePic" id="exampleFormControlFile1">
    			</div>
  				<div class="form-check">
    				<input type="checkbox" class="form-check-input" name = "checked" id="exampleCheck1">
    				<label class="form-check-label" for="exampleCheck1">Accept <a href="#">Terms & Conditions</a></label>
  				</div><br>
  				<!-- loader -->
				<div class = "container text-center" id = "loader" style="display:none;">
					<span class = "fa fa-refresh fa-spin fa-3x"></span><br>
					<h4>Please Wait...</h4>
				</div>
	  			<button type="submit" class="btn btn-primary" id="reg-button">Register</button>
			</form>
		</div>
		
		<!-- Javascript -->
		<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
		<script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
		<!-- Jquery -->
		<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
		<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
		<!-- Ajax Call for registration -->
		<script>
				$(document).ready(function(){
					$('#reg-form').on('submit',function(event){
						event.preventDefault();
						$('#reg-button').hide();
						$('#loader').show();
						let f = new FormData(this);
						$.ajax({
							url:"RegisterServlet",
							data:f,
							type:'POST',
							success:function(data,textStatus,jqXHR){
								console.log(data);
								$('#reg-button').show();
								$('#loader').hide();
								if(data.trim() === 'Done'){
									swal("Wohoo! Registered Successfully, redirecting to Login Page")
									.then((value) => {
							  			window.location="index.jsp";
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
								swal("Something Went Wrong!!");
							},
							processData:false,
							contentType:false
						});
					});
				});
		</script>
	</body>
</html>