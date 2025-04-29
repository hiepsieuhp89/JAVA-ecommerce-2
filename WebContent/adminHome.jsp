<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page
	import="com.shashi.service.impl.*, com.shashi.beans.*,com.shashi.service.*,java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<title>Admin Home</title>
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
    // Add animation to cards
    $('.card').each(function(index) {
        $(this).delay(index * 100).addClass('fade-in');
    });
    
    // Add hover effect to cards
    $('.card').hover(
        function() {
            $(this).css('transform', 'translateY(-5px)');
        },
        function() {
            $(this).css('transform', 'translateY(0)');
        }
    );
    
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

	<%
	String message = request.getParameter("message");
	%>
	
	<div class="container">
		<div class="row">
			<div class="col-md-12">
				<div class="card">
					<div class="card-body">
						<div class="text-center mb-4">
							<h2 class="text-primary">Welcome Admin</h2>
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
						
						<div class="row">
							<div class="col-md-4 mb-4">
								<div class="card">
									<div class="card-body text-center">
										<h3 class="card-title">Products</h3>
										<p class="card-text">Manage your products</p>
										<div class="mt-3">
											<a href="adminViewProduct.jsp" class="btn btn-primary btn-lg">View Products</a>
										</div>
									</div>
								</div>
							</div>
							
							<div class="col-md-4 mb-4">
								<div class="card">
									<div class="card-body text-center">
										<h3 class="card-title">Orders</h3>
										<p class="card-text">Manage customer orders</p>
										<div class="mt-3">
											<a href="unshippedItems.jsp" class="btn btn-warning btn-lg">Unshipped Orders</a>
										</div>
									</div>
								</div>
							</div>
							
							<div class="col-md-4 mb-4">
								<div class="card">
									<div class="card-body text-center">
										<h3 class="card-title">Stock</h3>
										<p class="card-text">Manage product stock</p>
										<div class="mt-3">
											<a href="adminStock.jsp" class="btn btn-info btn-lg">View Stock</a>
										</div>
									</div>
								</div>
							</div>
						</div>
						
						<div class="row">
							<div class="col-md-4 mb-4">
								<div class="card">
									<div class="card-body text-center">
										<h3 class="card-title">Add Product</h3>
										<p class="card-text">Add new products</p>
										<div class="mt-3">
											<a href="addProduct.jsp" class="btn btn-success btn-lg">Add Product</a>
										</div>
									</div>
								</div>
							</div>
							
							<div class="col-md-4 mb-4">
								<div class="card">
									<div class="card-body text-center">
										<h3 class="card-title">Update Product</h3>
										<p class="card-text">Update existing products</p>
										<div class="mt-3">
											<a href="updateProductById.jsp" class="btn btn-secondary btn-lg">Update Product</a>
										</div>
									</div>
								</div>
							</div>
							
							<div class="col-md-4 mb-4">
								<div class="card">
									<div class="card-body text-center">
										<h3 class="card-title">Remove Product</h3>
										<p class="card-text">Remove products</p>
										<div class="mt-3">
											<a href="removeProduct.jsp" class="btn btn-danger btn-lg">Remove Product</a>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<%@ include file="footer.html"%>
</body>
</html>