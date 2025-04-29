<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page
	import="com.shashi.service.impl.*, com.shashi.beans.*,com.shashi.service.*,java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<title>User Profile</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="css/changes.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
<script>
$(document).ready(function(){
    // Add animation to form
    $('.card').addClass('fade-in');
    
    // Add hover effect to buttons
    $('.btn').hover(
        function() {
            $(this).css('transform', 'translateY(-2px)');
        },
        function() {
            $(this).css('transform', 'translateY(0)');
        }
    );
    
    // Add focus effect to inputs
    $('.form-control').focus(function(){
        $(this).parent().addClass('focused');
    }).blur(function(){
        $(this).parent().removeClass('focused');
    });
});
</script>
</head>
<body>
	<%
	/* Checking the user credentials */
	String userType = (String) session.getAttribute("usertype");
	String userName = (String) session.getAttribute("username");
	String password = (String) session.getAttribute("password");

	if (userType == null || !userType.equals("user")) {
		response.sendRedirect("login.jsp?message=Access Denied, Login as user!!");
	}
	else if (userName == null || password == null) {
		response.sendRedirect("login.jsp?message=Session Expired, Login Again!!");
	}
	%>

	<jsp:include page="header.jsp" />

	<%
	String message = request.getParameter("message");
	UserServiceImpl userDao = new UserServiceImpl();
	UserBean user = userDao.getUserDetails(userName);
	%>
	
	<div class="container">
		<div class="row justify-content-center">
			<div class="col-md-8">
				<div class="card">
					<div class="card-body">
						<div class="text-center mb-4">
							<h2 class="text-primary">User Profile</h2>
							<%
							if (message != null) {
							%>
							<div class="alert alert-info fade-in">
								<%=message%>
							</div>
							<%
							}
							%>
						</div>
						
						<form action="./UpdateProfileSrv" method="post">
							<div class="row">
								<div class="col-md-6">
									<div class="form-group">
										<label for="username">Full Name</label>
										<input type="text" class="form-control" id="username" name="username" 
											value="<%=user.getUserName()%>" required>
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<label for="email">Email</label>
										<input type="email" class="form-control" id="email" name="email"
											value="<%=user.getUserEmail()%>" required>
									</div>
								</div>
							</div>
							
							<div class="form-group">
								<label for="address">Address</label>
								<textarea class="form-control" id="address" name="address" 
									rows="2" required><%=user.getUserAddress()%></textarea>
							</div>
							
							<div class="row">
								<div class="col-md-6">
									<div class="form-group">
										<label for="mobile">Mobile Number</label>
										<input type="number" class="form-control" id="mobile" name="mobile"
											value="<%=user.getUserMobile()%>" required>
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<label for="pincode">Pin Code</label>
										<input type="number" class="form-control" id="pincode" name="pincode"
											value="<%=user.getUserPinCode()%>" required>
									</div>
								</div>
							</div>
							
							<div class="row">
								<div class="col-md-6">
									<div class="form-group">
										<label for="password">Current Password</label>
										<input type="password" class="form-control" id="password" name="password"
											placeholder="Enter current password" required>
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<label for="newPassword">New Password</label>
										<input type="password" class="form-control" id="newPassword" name="newPassword"
											placeholder="Enter new password">
									</div>
								</div>
							</div>
							
							<div class="row mt-4">
								<div class="col-md-6 text-center">
									<a href="userHome.jsp" class="btn btn-danger btn-lg">Cancel</a>
								</div>
								<div class="col-md-6 text-center">
									<button type="submit" class="btn btn-success btn-lg">Update Profile</button>
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>

	<%@ include file="footer.html"%>
</body>
</html>