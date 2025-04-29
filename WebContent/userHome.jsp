<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page
	import="com.shashi.service.impl.*, com.shashi.beans.*,com.shashi.service.*,java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<title>User Home</title>
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
    // Add animation to product cards
    $('.product-card').each(function(index) {
        $(this).delay(index * 100).addClass('fade-in');
    });
    
    // Add hover effect to product cards
    $('.product-card').hover(
        function() {
            $(this).css('transform', 'translateY(-5px)');
            $(this).find('.product-image').css('transform', 'scale(1.05)');
        },
        function() {
            $(this).css('transform', 'translateY(0)');
            $(this).find('.product-image').css('transform', 'scale(1)');
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
	%>
	
	<div class="container">
		<div class="row">
			<div class="col-md-12">
				<div class="card">
					<div class="card-body">
						<div class="text-center mb-4">
							<h2 class="text-primary">Welcome <%=userName%></h2>
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
							<%
							ProductServiceImpl prodDao = new ProductServiceImpl();
							List<ProductBean> products = prodDao.getAllProducts();
							
							for (ProductBean product : products) {
							%>
							<div class="col-md-4 mb-4">
								<div class="product-card">
									<div class="card">
										<div class="card-body">
											<div class="text-center">
												<img src="./ShowImage?pid=<%=product.getProdId()%>" 
													class="product-image" alt="Product Image" height="200px">
											</div>
											<h4 class="card-title mt-3"><%=product.getProdName()%></h4>
											<p class="card-text"><%=product.getProdInfo()%></p>
											<div class="row">
												<div class="col-md-6">
													<h5 class="text-success">$<%=product.getProdPrice()%></h5>
												</div>
												<div class="col-md-6">
													<h5 class="text-info">Stock: <%=product.getProdQuantity()%></h5>
												</div>
											</div>
											<div class="text-center mt-3">
												<a href="./AddToCart?pid=<%=product.getProdId()%>&price=<%=product.getProdPrice()%>" 
													class="btn btn-primary btn-lg">Add to Cart</a>
											</div>
										</div>
									</div>
								</div>
							</div>
							<%
							}
							%>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<%@ include file="footer.html"%>
</body>
</html>