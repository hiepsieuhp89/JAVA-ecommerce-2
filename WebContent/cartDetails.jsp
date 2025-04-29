<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page
	import="com.shashi.service.impl.*, com.shashi.service.*,com.shashi.beans.*,java.util.*,javax.servlet.ServletOutputStream,java.io.*"%>
<!DOCTYPE html>
<html>
<head>
<title>Giỏ hàng</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<link rel="stylesheet" href="css/changes.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
</head>
<body style="background-color: #E6F9E6;">
	<%
	/* Checking the user credentials */
	String userType = (String) session.getAttribute("usertype");
	String userName = (String) session.getAttribute("username");
	String password = (String) session.getAttribute("password");

	if (userType == null || !userType.equals("customer")) {

		response.sendRedirect("login.jsp?message=Truy cập bị từ chối, vui lòng đăng nhập với tư cách khách hàng!!");

	}

	else if (userName == null || password == null) {

		response.sendRedirect("login.jsp?message=Phiên đăng nhập đã hết hạn, vui lòng đăng nhập lại!!");

	}
	%>

	<jsp:include page="header.jsp" />

	<div class="text-center"
		style="color: green; font-size: 24px; font-weight: bold;">Giỏ hàng</div>
	<div class="container-fluid">
		<div class="table-responsive ">
			<table class="table table-hover table-sm">
				<thead
					style="background-color: #2c6c4b; color: white; font-size: 18px;">
					<tr>
						<th>Hình ảnh</th>
						<th>Mã sản phẩm</th>
						<th>Tên</th>
						<th>Loại</th>
						<th>Giá</th>
						<th>Số lượng</th>
						<th>Tổng tiền</th>
						<th style="text-align: center">Thao tác</th>
					</tr>
				</thead>
				<tbody style="background-color: white; font-size: 16px;">



					<%
					CartServiceImpl cartDao = new CartServiceImpl();
					List<CartBean> carts = new ArrayList<CartBean>();
					carts = cartDao.getAllCartItems(userName);
					double total = 0.0;
					for (CartBean cart : carts) {
						ProductBean product = new ProductServiceImpl().getProductDetails(cart.getProductId());
						total += (product.getProdPrice() * cart.getQuantity());
					%>

					<tr>
						<td><img src="./ShowImage?pid=<%=product.getProdId()%>"
							style="width: 50px; height: 50px;"></td>
						<td><%=product.getProdId()%></td>
						<%
						String name = product.getProdName();
						name = name.substring(0, Math.min(name.length(), 25)) + "..";
						%>
						<td><%=name%></td>
						<td><%=product.getProdType().toUpperCase()%></td>
						<td><%=product.getProdPrice()%></td>
						<td><%=cart.getQuantity()%></td>
						<td><%=product.getProdPrice() * cart.getQuantity()%></td>
						<td>
							<form method="post">
								<button type="submit"
									formaction="./RemoveFromCart?cartid=<%=cart.getCartId()%>"
									class="btn btn-danger">Xóa</button>
							</form>
						</td>

					</tr>

					<%
					}
					%>
					<%
					if (carts.size() == 0) {
					%>
					<tr style="background-color: grey; color: white;">
						<td colspan="8" style="text-align: center;">Giỏ hàng trống</td>

					</tr>
					<%
					} else {
					%>
					<tr style="background-color: #2c6c4b; color: white;">
						<td colspan="6" style="text-align: right; font-weight: bold;">Tổng
							cộng:</td>
						<td colspan="2" style="text-align: left; font-weight: bold;"><%=total%></td>
					</tr>
					<%
					}
					%>
				</tbody>
			</table>
		</div>
		<%
		if (carts.size() != 0) {
		%>
		<div class="row">
			<div class="col-md-4 col-md-offset-4">
				<form method="post" action="payment.jsp">
					<button type="submit" class="btn btn-success btn-block">Thanh
						toán</button>
				</form>
			</div>
		</div>
		<%
		}
		%>
	</div>

	<%@ include file="footer.html"%>
</body>
</html>