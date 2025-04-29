<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<title>Register</title>
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
	<%@ include file="header.jsp"%>
	<%
	String message = request.getParameter("message");
	%>
	
	<div class="container">
		<div class="row justify-content-center">
			<div class="col-md-6">
				<div class="card">
					<div class="card-body">
						<div class="text-center mb-4">
							<h2 class="text-success">Create Account</h2>
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
						
						<form action="./RegisterSrv" method="post">
							<div class="row">
								<div class="col-md-6">
									<div class="form-group">
										<label for="username">Full Name</label>
										<input type="text" class="form-control" id="username" name="username" 
											placeholder="Enter your full name" required>
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<label for="email">Email</label>
										<input type="email" class="form-control" id="email" name="email"
											placeholder="Enter your email" required>
									</div>
								</div>
							</div>
							
							<div class="form-group">
								<label for="address">Address</label>
								<textarea class="form-control" id="address" name="address" 
									rows="2" placeholder="Enter your address" required></textarea>
							</div>
							
							<div class="row">
								<div class="col-md-6">
									<div class="form-group">
										<label for="mobile">Mobile Number</label>
										<input type="number" class="form-control" id="mobile" name="mobile"
											placeholder="Enter mobile number" required>
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<label for="pincode">Pin Code</label>
										<input type="number" class="form-control" id="pincode" name="pincode"
											placeholder="Enter pin code" required>
									</div>
								</div>
							</div>
							
							<div class="row">
								<div class="col-md-6">
									<div class="form-group">
										<label for="password">Password</label>
										<input type="password" class="form-control" id="password" name="password"
											placeholder="Enter password" required>
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<label for="confirmPassword">Confirm Password</label>
										<input type="password" class="form-control" id="confirmPassword" name="confirmPassword"
											placeholder="Confirm password" required>
									</div>
								</div>
							</div>
							
							<div class="row mt-4">
								<div class="col-md-6 text-center">
									<button type="reset" class="btn btn-danger btn-lg">Reset</button>
								</div>
								<div class="col-md-6 text-center">
									<button type="submit" class="btn btn-success btn-lg">Register</button>
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