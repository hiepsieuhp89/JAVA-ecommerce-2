<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page
	import="com.shashi.service.impl.*, com.shashi.service.*,com.shashi.beans.*,java.util.*,javax.servlet.ServletOutputStream,java.io.*"%>
<!DOCTYPE html>
<html>
<head>
<title>Đơn hàng đã giao</title>
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

	if (userType == null || !userType.equals("admin")) {

		response.sendRedirect("login.jsp?message=Truy cập bị từ chối, vui lòng đăng nhập với tư cách quản trị viên!!");

	}

	else if (userName == null || password == null) {

		response.sendRedirect("login.jsp?message=Phiên đăng nhập đã hết hạn, vui lòng đăng nhập lại!!");

	}
	%>

	<jsp:include page="header.jsp" />

	<div class="text-center"
		style="color: green; font-size: 24px; font-weight: bold;">Đơn hàng
		đã giao</div>
	<div class="container-fluid">
		<div class="table-responsive ">
			<table class="table table-hover table-sm">
				<thead
					style="background-color: #2c6c4b; color: white; font-size: 18px;">
					<tr>
						<th>Mã đơn hàng</th>
						<th>Email khách hàng</th>
						<th>Ngày đặt hàng</th>
						<th>Tổng tiền</th>
						<th>Trạng thái</th>
						<th style="text-align: center">Thao tác</th>
					</tr>
				</thead>
				<tbody style="background-color: white; font-size: 16px;">



					<%
					OrderServiceImpl orderDao = new OrderServiceImpl();
					List<OrderBean> orders = new ArrayList<OrderBean>();
					orders = orderDao.getAllShippedOrders();
					for (OrderBean order : orders) {
					%>

					<tr>
						<td><%=order.getOrderId()%></td>
						<td><%=order.getEmail()%></td>
						<td><%=order.getOrderDate()%></td>
						<td><%=order.getAmount()%></td>
						<td><%=order.getStatus()%></td>
						<td>
							<form method="post">
								<button type="submit"
									formaction="./ViewOrderDetails?orderid=<%=order.getOrderId()%>"
									class="btn btn-primary">Xem chi tiết</button>
							</form>
						</td>

					</tr>

					<%
					}
					%>
					<%
					if (orders.size() == 0) {
					%>
					<tr style="background-color: grey; color: white;">
						<td colspan="6" style="text-align: center;">Không có đơn hàng nào</td>

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