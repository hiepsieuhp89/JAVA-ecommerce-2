<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page
	import="com.shashi.service.impl.*, com.shashi.beans.*,com.shashi.service.*,java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<title>Payment</title>
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
	double totalAmount = Double.parseDouble(request.getParameter("amount"));
	%>
	
	<div class="container">
		<div class="row justify-content-center">
			<div class="col-md-8">
				<div class="card">
					<div class="card-body">
						<div class="text-center mb-4">
							<h2 class="text-primary">Payment Details</h2>
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
						
						<div class="text-center mb-4">
							<h3 class="text-success">Total Amount: $<%=totalAmount%></h3>
						</div>
						
						<form action="./PaymentSrv" method="post">
							<input type="hidden" name="amount" value="<%=totalAmount%>">
							
							<div class="row">
								<div class="col-md-6">
									<div class="form-group">
										<label for="cardNumber">Card Number</label>
										<input type="text" class="form-control" id="cardNumber" name="cardNumber" 
											placeholder="Enter card number" required>
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<label for="cardName">Card Holder Name</label>
										<input type="text" class="form-control" id="cardName" name="cardName"
											placeholder="Enter card holder name" required>
									</div>
								</div>
							</div>
							
							<div class="row">
								<div class="col-md-4">
									<div class="form-group">
										<label for="expiryMonth">Expiry Month</label>
										<select class="form-control" id="expiryMonth" name="expiryMonth" required>
											<option value="">Month</option>
											<option value="01">01</option>
											<option value="02">02</option>
											<option value="03">03</option>
											<option value="04">04</option>
											<option value="05">05</option>
											<option value="06">06</option>
											<option value="07">07</option>
											<option value="08">08</option>
											<option value="09">09</option>
											<option value="10">10</option>
											<option value="11">11</option>
											<option value="12">12</option>
										</select>
									</div>
								</div>
								<div class="col-md-4">
									<div class="form-group">
										<label for="expiryYear">Expiry Year</label>
										<select class="form-control" id="expiryYear" name="expiryYear" required>
											<option value="">Year</option>
											<%
											int currentYear = java.util.Calendar.getInstance().get(java.util.Calendar.YEAR);
											for(int i = currentYear; i <= currentYear + 10; i++) {
											%>
											<option value="<%=i%>"><%=i%></option>
											<%
											}
											%>
										</select>
									</div>
								</div>
								<div class="col-md-4">
									<div class="form-group">
										<label for="cvv">CVV</label>
										<input type="text" class="form-control" id="cvv" name="cvv"
											placeholder="Enter CVV" required>
									</div>
								</div>
							</div>
							
							<div class="row mt-4">
								<div class="col-md-6 text-center">
									<a href="cartDetails.jsp" class="btn btn-danger btn-lg">Cancel</a>
								</div>
								<div class="col-md-6 text-center">
									<button type="submit" class="btn btn-success btn-lg">Pay Now</button>
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