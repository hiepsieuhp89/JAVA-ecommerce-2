<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page
	import="com.shashi.service.impl.*, com.shashi.service.*,com.shashi.beans.*,java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<title>Order Details</title>
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
<body style="background-color: #E6F9E6;">

	<%
	/* Checking the user credentials */
	String userName = (String) session.getAttribute("username");
	String password = (String) session.getAttribute("password");

	if (userName == null || password == null) {
		response.sendRedirect("login.jsp?message=Session Expired, Login Again!!");
	}

	OrderService dao = new OrderServiceImpl();
	List<OrderDetails> orders = dao.getAllOrderDetails(userName);
	%>

	<jsp:include page="header.jsp" />

	<div class="container">
		<div class="row">
			<div class="col-md-12">
				<div class="card">
					<div class="card-body">
						<div class="text-center mb-4">
							<h2 class="text-primary">Order Details</h2>
						</div>
						
						<div class="table-responsive">
							<table class="table table-striped table-hover">
								<thead class="thead-dark">
									<tr>
										<th>Picture</th>
										<th>Product Name</th>
										<th>Order ID</th>
										<th>Quantity</th>
										<th>Price</th>
										<th>Order Date</th>
										<th>Status</th>
									</tr>
								</thead>
								<tbody>
									<%
									for (OrderDetails order : orders) {
									%>
									<tr>
										<td>
											<img src="./ShowImage?pid=<%=order.getProductId()%>"
												class="img-thumbnail" style="width: 50px; height: 50px;">
										</td>
										<td><%=order.getProdName()%></td>
										<td><%=order.getOrderId()%></td>
										<td><%=order.getQty()%></td>
										<td>$<%=order.getAmount()%></td>
										<td><%=order.getTime()%></td>
										<td>
											<span class="badge <%=order.getShipped() == 0 ? 'badge-warning' : 'badge-success'%>">
												<%=order.getShipped() == 0 ? "ORDER_PLACED" : "ORDER_SHIPPED"%>
											</span>
										</td>
									</tr>
									<%
									}
									%>
								</tbody>
							</table>
						</div>
						
						<div class="text-center mt-4">
							<a href="userHome.jsp" class="btn btn-secondary btn-lg">Back to Home</a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<jsp:include page="header.jsp" />

	<!-- <script>document.getElementById('mycart').innerHTML='<i data-count="20" class="fa fa-shopping-cart fa-3x icon-white badge" style="background-color:#333;margin:0px;padding:0px; margin-top:5px;"></i>'</script>
 -->
	<div class="text-center"
		style="color: green; font-size: 24px; font-weight: bold;">Order
		Details</div>
	<!-- Start of Product Items List -->
	<div class="container">
		<div class="table-responsive ">
			<table class="table table-hover table-sm">
				<thead
					style="background-color: black; color: white; font-size: 14px; font-weight: bold;">
					<tr>
						<th>Picture</th>
						<th>ProductName</th>
						<th>OrderId</th>
						<th>Quantity</th>
						<th>Price</th>
						<th>Time</th>
						<th>Status</th>
					</tr>
				</thead>
				<tbody
					style="background-color: white; font-size: 15px; font-weight: bold;">
					<%
					for (OrderDetails order : orders) {
					%>

					<tr>
						<td><img src="./ShowImage?pid=<%=order.getProductId()%>"
							style="width: 50px; height: 50px;"></td>
						<td><%=order.getProdName()%></td>
						<td><%=order.getOrderId()%></td>
						<td><%=order.getQty()%></td>
						<td><%=order.getAmount()%></td>
						<td><%=order.getTime()%></td>
						<td class="text-success"><%=order.getShipped() == 0 ? "ORDER_PLACED" : "ORDER_SHIPPED"%></td>
					</tr>

					<%
					}
					%>

				</tbody>
			</table>
		</div>
	</div>
	<!-- ENd of Product Items List -->


	<%@ include file="footer.html"%>
</body>
</html>