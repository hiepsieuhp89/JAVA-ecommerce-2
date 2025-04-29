<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page
	import="com.shashi.service.impl.*, com.shashi.beans.*,com.shashi.service.*,java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<title>Shipped Items</title>
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
    // Add animation to table rows
    $('tr').each(function(index) {
        $(this).delay(index * 100).addClass('fade-in');
    });
    
    // Add hover effect to buttons
    $('.btn').hover(
        function() {
            $(this).css('transform', 'translateY(-2px)');
        },
        function() {
            $(this).css('transform', 'translateY(0)');
        }
    );
});
</script>
</head>
<body>
	<%
	/* Checking the user credentials */
	String userType = (String) session.getAttribute("usertype");
	String userName = (String) session.getAttribute("username");
	String password = (String) session.getAttribute("password");

	if (userType == null || !userType.equals("admin")) {
		response.sendRedirect("login.jsp?message=Access Denied, Login as admin!!");
	}
	else if (userName == null || password == null) {
		response.sendRedirect("login.jsp?message=Session Expired, Login Again!!");
	}
	%>

	<jsp:include page="header.jsp" />

	<div class="container">
		<div class="row">
			<div class="col-md-12">
				<div class="card">
					<div class="card-body">
						<h2 class="text-center mb-4">Shipped Items</h2>
						
						<div class="table-responsive">
							<table class="table table-hover">
								<thead class="thead-dark">
									<tr>
										<th>Order ID</th>
										<th>Product ID</th>
										<th>Product Name</th>
										<th>Quantity</th>
										<th>Price</th>
										<th>Customer Name</th>
										<th>Customer Address</th>
										<th>Order Date</th>
									</tr>
								</thead>
								<tbody>
									<!-- Add your shipped items data here -->
								</tbody>
							</table>
						</div>
						
						<div class="text-center mt-4">
							<a href="adminHome.jsp" class="btn btn-primary btn-lg">Back to Admin Home</a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<%@ include file="footer.html"%>
</body>
</html>