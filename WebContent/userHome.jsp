<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page
	import="com.shashi.service.impl.*, com.shashi.service.*,com.shashi.beans.*,java.util.*,javax.servlet.ServletOutputStream,java.io.*"%>
<!DOCTYPE html>
<html>
<head>
<title>Trang chủ</title>
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
		style="color: green; font-size: 24px; font-weight: bold;">Danh sách
		sản phẩm</div>
	<div class="container-fluid">
		<div class="row text-center">
			<%
			ProductServiceImpl productDao = new ProductServiceImpl();
			List<ProductBean> products = new ArrayList<ProductBean>();
			String type = request.getParameter("type");
			if (type == null)
				products = productDao.getAllProducts();
			else
				products = productDao.getAllProductsByType(type);
			for (ProductBean product : products) {
			%>
			<div class="col-sm-4" style='height: 350px;'>
				<div class="thumbnail">
					<img src="./ShowImage?pid=<%=product.getProdId()%>" alt="Product"
						style="height: 150px; max-width: 180px;">
					<p class="productname"><%=product.getProdName()%>
						(
						<%=product.getProdId()%>
						)
					</p>
					<p class="productinfo"><%=product.getProdInfo()%></p>
					<p class="price">
						<%=product.getProdPrice()%>
					</p>
					<form method="post">
						<button type="submit" formaction="./AddtoCart?pid=<%=product.getProdId()%>"
							class="btn btn-success">Thêm vào giỏ</button>
					</form>
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