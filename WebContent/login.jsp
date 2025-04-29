<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<title>Login</title>
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
<body style="background-color: #E6F9E6;">

	<%@ include file="header.jsp"%>

	<%
	String message = request.getParameter("message");
	%>
	
	<div class="container">
		<div class="row justify-content-center">
			<div class="col-md-6 col-lg-4">
				<div class="card">
					<div class="card-body">
						<div class="text-center mb-4">
							<h2 class="text-primary">Login</h2>
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
						
						<form action="./LoginSrv" method="post">
							<div class="form-group">
								<label for="username">Username</label>
								<input type="email" class="form-control" id="username" 
									name="username" placeholder="Enter your email" required>
							</div>
							
							<div class="form-group">
								<label for="password">Password</label>
								<input type="password" class="form-control" id="password" 
									name="password" placeholder="Enter your password" required>
							</div>
							
							<div class="form-group">
								<label for="usertype">Login As</label>
								<select class="form-control" id="usertype" name="usertype" required>
									<option value="customer" selected>Customer</option>
									<option value="admin">Admin</option>
								</select>
							</div>
							
							<div class="text-center">
								<button type="submit" class="btn btn-primary btn-lg">Login</button>
							</div>
							
							<div class="text-center mt-3">
								<p>Don't have an account? <a href="register.jsp">Register here</a></p>
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