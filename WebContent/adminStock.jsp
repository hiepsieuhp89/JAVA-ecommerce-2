<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page
	import="com.shashi.service.impl.*, com.shashi.beans.*,com.shashi.service.*,java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<title>Admin Stock</title>
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
        $(this).delay(index * 50).addClass('fade-in');
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
    
    // Add hover effect to table rows
    $('tr').hover(
        function() {
            $(this).css('transform', 'translateX(5px)');
        },
        function() {
            $(this).css('transform', 'translateX(0)');
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
	ProductServiceImpl prodDao = new ProductServiceImpl();
	List<ProductBean> products = prodDao.getAllProducts();
	%>
	
	<div class="container">
		<div class="row">
			<div class="col-md-12">
				<div class="card">
					<div class="card-body">
						<div class="text-center mb-4">
							<h2 class="text-primary">Product Stock</h2>
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
						
						<div class="table-responsive">
							<table class="table table-striped table-hover">
								<thead class="thead-dark">
									<tr>
										<th>Product ID</th>
										<th>Product Name</th>
										<th>Product Type</th>
										<th>Unit Price</th>
										<th>Stock Quantity</th>
										<th>Action</th>
									</tr>
								</thead>
								<tbody>
									<%
									for (ProductBean product : products) {
									%>
									<tr>
										<td><%=product.getProdId()%></td>
										<td><%=product.getProdName()%></td>
										<td><%=product.getProdType()%></td>
										<td>$<%=product.getProdPrice()%></td>
										<td><%=product.getProdQuantity()%></td>
										<td>
											<a href="updateProduct.jsp?prodid=<%=product.getProdId()%>" 
												class="btn btn-primary btn-sm">Update</a>
										</td>
									</tr>
									<%
									}
									%>
								</tbody>
							</table>
						</div>
						
						<div class="text-center mt-4">
							<a href="adminHome.jsp" class="btn btn-secondary btn-lg">Back to Admin Home</a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<%@ include file="footer.html"%>
</body>
</html>