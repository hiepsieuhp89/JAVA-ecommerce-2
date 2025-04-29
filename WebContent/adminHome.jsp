<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page
	import="com.shashi.service.impl.*, com.shashi.service.*,com.shashi.beans.*,java.util.*,javax.servlet.ServletOutputStream,java.io.*"%>
<!DOCTYPE html>
<html>
<head>
<title>Trang quản trị</title>
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

	<div class="products" style="background-color: #E6F9E6;">

		<div class="tab" align="center">
			<form>
				<button type="submit" formaction="adminViewProduct.jsp">Xem
					sản phẩm</button>
				<br>
				<br>
				<button type="submit" formaction="addProduct.jsp">Thêm
					sản phẩm</button>
				<br>
				<br>
				<button type="submit" formaction="removeProduct.jsp">Xóa
					sản phẩm</button>
				<br>
				<br>
				<button type="submit" formaction="updateProductById.jsp">Cập nhật
					sản phẩm</button>
				<br>
				<br>
			</form>
		</div>
	</div>

	<%@ include file="footer.html"%>
</body>
</html>