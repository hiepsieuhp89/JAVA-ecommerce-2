<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page
	import="com.shashi.service.impl.*, com.shashi.beans.*,com.shashi.service.*,java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<title>Update Product</title>
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
	String prodId = request.getParameter("prodid");
	ProductServiceImpl prodDao = new ProductServiceImpl();
	ProductBean product = prodDao.getProductDetails(prodId);
	%>
	
	<div class="container">
		<div class="row justify-content-center">
			<div class="col-md-8">
				<div class="card">
					<div class="card-body">
						<div class="text-center mb-4">
							<h2 class="text-primary">Update Product</h2>
						</div>
						
						<form action="./UpdateProductSrv" method="post" enctype="multipart/form-data">
							<input type="hidden" name="prodid" value="<%=prodId%>">
							
							<div class="row">
								<div class="col-md-6">
									<div class="form-group">
										<label for="name">Product Name</label>
										<input type="text" class="form-control" id="name" name="name" 
											value="<%=product.getProdName()%>" required>
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<label for="type">Product Type</label>
										<select name="type" id="type" class="form-control" required>
											<option value="mobile" <%=product.getProdType().equals("mobile") ? "selected" : ""%>>MOBILE</option>
											<option value="tv" <%=product.getProdType().equals("tv") ? "selected" : ""%>>TV</option>
											<option value="camera" <%=product.getProdType().equals("camera") ? "selected" : ""%>>CAMERA</option>
											<option value="laptop" <%=product.getProdType().equals("laptop") ? "selected" : ""%>>LAPTOP</option>
											<option value="tablet" <%=product.getProdType().equals("tablet") ? "selected" : ""%>>TABLET</option>
											<option value="speaker" <%=product.getProdType().equals("speaker") ? "selected" : ""%>>SPEAKER</option>
											<option value="other" <%=product.getProdType().equals("other") ? "selected" : ""%>>Other Appliances</option>
										</select>
									</div>
								</div>
							</div>
							
							<div class="form-group">
								<label for="info">Product Description</label>
								<textarea name="info" class="form-control" id="info" rows="3" required><%=product.getProdInfo()%></textarea>
							</div>
							
							<div class="row">
								<div class="col-md-6">
									<div class="form-group">
										<label for="price">Unit Price</label>
										<input type="number" class="form-control" id="price" name="price"
											value="<%=product.getProdPrice()%>" required>
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<label for="quantity">Stock Quantity</label>
										<input type="number" class="form-control" id="quantity" name="quantity"
											value="<%=product.getProdQuantity()%>" required>
									</div>
								</div>
							</div>
							
							<div class="form-group">
								<label for="image">Product Image</label>
								<input type="file" class="form-control" id="image" name="image">
								<small class="form-text text-muted">Leave empty to keep current image</small>
							</div>
							
							<div class="row mt-4">
								<div class="col-md-6 text-center">
									<a href="adminViewProduct.jsp" class="btn btn-danger btn-lg">Cancel</a>
								</div>
								<div class="col-md-6 text-center">
									<button type="submit" class="btn btn-success btn-lg">Update Product</button>
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