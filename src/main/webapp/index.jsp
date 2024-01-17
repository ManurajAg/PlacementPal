<%@page import="com.placementpal.entities.Message"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Home || Placement Pal</title>
		<!-- css -->
		
		<link href = "css/style.css" rel = "stylesheet" type = "text/css">
		
		<style>
			.credentialsWarning{
				color:red;
				display:block;
			}
			.text-green{
				color:green;
			}
		</style>
	</head>
	<body>
		<div class = "my_container">
        <div class = "logo-container">
            <div class = "logo-content">
                <h3>Placement Pal</h3>
            </div>
            <div class = "logo">
                <div class = "upper-p rotate">
                    <h1>P</h1>
                </div>
                <div class = "lower-p rotate">
                    <h1>P</h1>
                </div>
            </div>
            
        </div>
        <div class = "login-container">
            <div class = "form-container">
                <h3>Login</h3><br>
                <%
                	Message msg = (Message)session.getAttribute("msg");
                	if(msg != null){
                %>
                <p class = "<%=msg.getCssClass()%>" ><%=msg.getContent() %></p>
                <%
                	}
                	session.removeAttribute("msg");
                %>
            <form action = "LoginServlet" method = "POST">
                <div class = "imgContainer"><img src = "img/default.png"></div><br>
                <label>Username</label>
                <input type = "email" placeholder="Enter your email here" name = "user_email"><br>
                <label>Password</label>
                <input type = "password" placeholder="Enter your password here" name = "user_password"><br>
                <button type = "submit" class="mybtn">Submit</button>
            </form>
            <a href = "register.jsp">New User ? Register Here</a><br>
            </div>
        </div>
    </div>
		
		<!-- JS -->
		<script src = "js/myjs.js" type = "text/javascript"></script>
	</body>
</html>