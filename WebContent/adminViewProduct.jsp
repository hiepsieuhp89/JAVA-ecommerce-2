<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page
	import="com.shashi.service.impl.*, com.shashi.service.*,com.shashi.beans.*,java.util.*,javax.servlet.ServletOutputStream,java.io.*"%>
<!DOCTYPE html>
<html>
<head>
<title>View Products</title>
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
        $(this).addClass('fade-in');
        $(this).css('animation-delay', (index * 0.2) + 's');
    });
    
    // Add hover effect to cards
    $('.product-card').hover(
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

	<div class="container">
		<div class="row">
			<div class="col-md-12 text-center mb-4">
				<h2 class="text-success">Product Catalog</h2>
				<p class="text-muted">View and manage all products</p>
			</div>
		</div>

		<div class="row">
			<%
			ProductServiceImpl prodDao = new ProductServiceImpl();
			List<ProductBean> products = new ArrayList<ProductBean>();
			products = prodDao.getAllProducts();
			for (ProductBean product : products) {
			%>
			<div class="col-md-4 mb-4">
				<div class="card product-card">
					<img src="./ShowImage?pid=<%=product.getProdId()%>" 
						class="card-img-top" alt="<%=product.getProdName()%>">
					<div class="card-body">
						<h5 class="card-title"><%=product.getProdName()%></h5>
						<p class="card-text text-muted">
							<%=product.getProdType().toUpperCase()%>
						</p>
						<div class="d-flex justify-content-between align-items-center">
							<h4 class="text-success">Rs <%=product.getProdPrice()%></h4>
							<span class="badge badge-info">
								Stock: <%=product.getProdQuantity()%>
							</span>
						</div>
						<div class="mt-3">
							<form method="post" class="d-inline">
								<button type="submit" formaction="updateProduct.jsp?prodid=<%=product.getProdId()%>"
									class="btn btn-primary btn-sm">
									<i class="glyphicon glyphicon-edit"></i> Update
								</button>
							</form>
							<form method="post" class="d-inline">
								<button type="submit" formaction="./RemoveProductSrv?prodid=<%=product.getProdId()%>"
									class="btn btn-danger btn-sm">
									<i class="glyphicon glyphicon-trash"></i> Remove
								</button>
							</form>
						</div>
					</div>
				</div>
			</div>
			<%
			}
			if (products.size() == 0) {
			%>
			<div class="col-md-12">
				<div class="alert alert-info text-center">
					No products available in the catalog
				</div>
			</div>
			<%
			}
			%>
		</div>
	</div>

	<%@ include file="footer.html"%>
</body>
</html>