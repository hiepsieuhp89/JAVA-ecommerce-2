<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<title>Add Product</title>
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
		<div class="row justify-content-center">
			<div class="col-md-8">
				<div class="card">
					<div class="card-body">
						<div class="text-center mb-4">
							<h2 class="text-success">Add New Product</h2>
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
						
						<form action="./AddProductSrv" method="post" enctype="multipart/form-data">
							<div class="row">
								<div class="col-md-6">
									<div class="form-group">
										<label for="name">Product Name</label>
										<input type="text" class="form-control" id="name" name="name" 
											placeholder="Enter Product Name" required>
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<label for="type">Product Type</label>
										<select name="type" id="type" class="form-control" required>
											<option value="mobile">MOBILE</option>
											<option value="tv">TV</option>
											<option value="camera">CAMERA</option>
											<option value="laptop">LAPTOP</option>
											<option value="tablet">TABLET</option>
											<option value="speaker">SPEAKER</option>
											<option value="other">Other Appliances</option>
										</select>
									</div>
								</div>
							</div>
							
							<div class="form-group">
								<label for="info">Product Description</label>
								<textarea name="info" class="form-control" id="info" rows="3" required></textarea>
							</div>
							
							<div class="row">
								<div class="col-md-6">
									<div class="form-group">
										<label for="price">Unit Price</label>
										<input type="number" class="form-control" id="price" name="price"
											placeholder="Enter Unit Price" required>
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<label for="quantity">Stock Quantity</label>
										<input type="number" class="form-control" id="quantity" name="quantity"
											placeholder="Enter Stock Quantity" required>
									</div>
								</div>
							</div>
							
							<div class="form-group">
								<label for="image">Product Image</label>
								<input type="file" class="form-control" id="image" name="image" required>
							</div>
							
							<div class="row mt-4">
								<div class="col-md-6 text-center">
									<button type="reset" class="btn btn-danger btn-lg">Reset</button>
								</div>
								<div class="col-md-6 text-center">
									<button type="submit" class="btn btn-success btn-lg">Add Product</button>
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