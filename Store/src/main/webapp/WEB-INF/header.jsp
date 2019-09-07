<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
		<header id="header">
			<nav class="navbar navbar-expand-md navbar-dark bg-dark">
				<div class="container d-flex flex-column flex-md-row justify-content-between">
					<a href="/Store/jackson/index.html">Author</a>
					<a class="navbar-brand d-flex align-items-center" href="indexPage.do">
						<svg class="mr-1" xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="none" stroke="currentColor" 
						stroke-linecap="round" stroke-linejoin="round" stroke-width="2" role="img" viewBox="0 0 24 24" focusable="false">
						<circle cx="12" cy="12" r="10"/>
						<path d="M14.31 8l5.74 9.94M9.69 8h11.48M7.38 12l5.74-9.94M9.69 16L3.95 6.06M14.31 16H2.83m13.79-4l-5.74 9.94"/></svg>
						<strong>Shopping</strong>
					</a>
					<a href="cartPage.do">Cart</a>
					<a href="registerPage.do">Register</a>
					<a id="loginCheck" href="#">Login</a>
					<a href="logout.do">Logout</a></li>
					<div class="nav-item dropdown">
						<a class="nav-link dropdown-toggle" href="" id="dropdown01" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">User</a>
						<div class="dropdown-menu" aria-labelledby="dropdown01">
							<a class="dropdown-item" href="profilePage.do">Profile</a>
							<a class="dropdown-item" href="sellPage.do">Selling</a>
							<a class="dropdown-item" href="mallPage.do">My Mall</a>
							<a class="dropdown-item" href="recipientPage.do">Recipient</a>
							<a class="dropdown-item" href="orderPage.do">Order</a>
						</div>
					</div>
				</div>
			</nav>
		</header>