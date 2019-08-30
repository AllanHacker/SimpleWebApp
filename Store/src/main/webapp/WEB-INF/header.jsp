<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

			<nav class="navbar navbar-expand-md navbar-dark bg-dark">
				<div class="container d-flex justify-content-between">
					<a href="indexPage.do" class="navbar-brand d-flex align-items-center">
						<svg
							xmlns="http://www.w3.org/2000/svg" width="20" height="20"
							fill="none" stroke="currentColor" stroke-linecap="round"
							stroke-linejoin="round" stroke-width="2" aria-hidden="true"
							class="mr-2" viewBox="0 0 24 24" focusable="false">
							<path d="M23 19a2 2 0 0 1-2 2H3a2 2 0 0 1-2-2V8a2 2 0 0 1 2-2h4l2-3h6l2 3h4a2 2 0 0 1 2 2z" />
							<circle cx="12" cy="13" r="4" />
						</svg>
						<strong>Shopping</strong>
					</a>
				</div>
				<div class="collapse navbar-collapse" id="navbarCollapse">
					<ul class="navbar-nav mr-auto">
						<li class="nav-item active"><a class="nav-link" href="cartPage.do">Cart</a></li>
						<li class="nav-item"><a class="nav-link" href="registerPage.do">Register</a></li>
						<li class="nav-item"><a class="nav-link" id="loginCheck" href="#">Login</a></li>
						<li class="nav-item"><a class="nav-link" href="logout.do">Logout</a></li>
						<li class="nav-item dropdown">
							<a class="nav-link dropdown-toggle" href="" id="dropdown01" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">User</a>
							<div class="dropdown-menu" aria-labelledby="dropdown01">
								<a class="dropdown-item" href="profilePage.do">Profile</a>
								<a class="dropdown-item" href="sellPage.do">Selling</a>
								<a class="dropdown-item" href="mallPage.do">My Mall</a>
								<a class="dropdown-item" href="recipientPage.do">Recipient</a>
								<a class="dropdown-item" href="orderPage.do">Order</a>
							</div>
							
						</li>
					</ul>
				</div>
			</nav>
	