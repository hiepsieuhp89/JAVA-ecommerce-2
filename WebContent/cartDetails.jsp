<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page
	import="com.shashi.service.impl.*, com.shashi.service.*,com.shashi.beans.*,java.util.*,javax.servlet.ServletOutputStream,java.io.*"%>
<!DOCTYPE html>
<html>
<head>
<title>Cart Details</title>
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
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script>
$(document).ready(function(){
    // Add animation to table rows
    $('tbody tr').each(function(index) {
        $(this).delay(index * 100).queue(function(){
            $(this).addClass('fade-in').dequeue();
        });
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
<body style="background-color: #E6F9E6;">

	<%
	/* Checking the user credentials */
	String userName = (String) session.getAttribute("username");
	String password = (String) session.getAttribute("password");

	if (userName == null || password == null) {

		response.sendRedirect("login.jsp?message=Session Expired, Login Again!!");

	}

	String addS = request.getParameter("add");
	if (addS != null) {

		int add = Integer.parseInt(addS);
		String uid = request.getParameter("uid");
		String pid = request.getParameter("pid");
		int avail = Integer.parseInt(request.getParameter("avail"));
		int cartQty = Integer.parseInt(request.getParameter("qty"));
		CartServiceImpl cart = new CartServiceImpl();

		if (add == 1) {
			//Add Product into the cart
			cartQty += 1;
			if (cartQty <= avail) {
		cart.addProductToCart(uid, pid, 1);
			} else {
		response.sendRedirect("./AddtoCart?pid=" + pid + "&pqty=" + cartQty);
			}
		} else if (add == 0) {
			//Remove Product from the cart
			cart.removeProductFromCart(uid, pid);
		}
	}
	%>



	<jsp:include page="header.jsp" />

	<div class="container">
		<div class="alert alert-info fade-in">
			<h3 class="text-center">Your Shopping Cart</h3>
		</div>

		<div class="table-responsive">
			<table class="table table-hover">
				<thead>
					<tr>
						<th>Picture</th>
						<th>Products</th>
						<th>Price</th>
						<th>Quantity</th>
						<th>Add</th>
						<th>Remove</th>
						<th>Amount</th>
					</tr>
				</thead>
				<tbody>
					<%
					CartServiceImpl cart = new CartServiceImpl();
					List<CartBean> cartItems = new ArrayList<CartBean>();
					cartItems = cart.getAllCartItems(userName);
					double totAmount = 0;
					for (CartBean item : cartItems) {
						String prodId = item.getProdId();
						int prodQuantity = item.getQuantity();
						ProductBean product = new ProductServiceImpl().getProductDetails(prodId);
						double currAmount = product.getProdPrice() * prodQuantity;
						totAmount += currAmount;

						if (prodQuantity > 0) {
					%>
					<tr>
						<td><img src="./ShowImage?pid=<%=product.getProdId()%>"
							class="img-responsive" style="max-width: 50px;"></td>
						<td><%=product.getProdName()%></td>
						<td>Rs <%=product.getProdPrice()%></td>
						<td>
							<form method="post" action="./UpdateToCart" class="form-inline">
								<input type="number" name="pqty" value="<%=prodQuantity%>"
									class="form-control" style="max-width: 70px;" min="0">
								<input type="hidden" name="pid" value="<%=product.getProdId()%>">
								<button type="submit" class="btn btn-primary btn-sm">Update</button>
							</form>
						</td>
						<td>
							<a href="cartDetails.jsp?add=1&uid=<%=userName%>&pid=<%=product.getProdId()%>&avail=<%=product.getProdQuantity()%>&qty=<%=prodQuantity%>"
								class="btn btn-success btn-sm"><i class="fa fa-plus"></i></a>
						</td>
						<td>
							<a href="cartDetails.jsp?add=0&uid=<%=userName%>&pid=<%=product.getProdId()%>&avail=<%=product.getProdQuantity()%>&qty=<%=prodQuantity%>"
								class="btn btn-danger btn-sm"><i class="fa fa-minus"></i></a>
						</td>
						<td>Rs <%=currAmount%></td>
					</tr>
					<%
						}
					}
					%>
					<tr class="info">
						<td colspan="6" class="text-right"><strong>Total Amount to Pay (in Rupees)</strong></td>
						<td><strong>Rs <%=totAmount%></strong></td>
					</tr>
					<%
					if (totAmount != 0) {
					%>
					<tr>
						<td colspan="4"></td>
						<td>
							<form method="post">
								<button formaction="userHome.jsp" class="btn btn-danger">Cancel</button>
							</form>
						</td>
						<td colspan="2">
							<form method="post">
								<button class="btn btn-success" formaction="payment.jsp?amount=<%=totAmount%>">Proceed to Payment</button>
							</form>
						</td>
					</tr>
					<%
					}
					%>
				</tbody>
			</table>
		</div>
	</div>

	<%@ include file="footer.html"%>

</body>
</html>