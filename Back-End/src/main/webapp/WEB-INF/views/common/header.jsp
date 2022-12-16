<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
<c:if test="${msg != null}">
  <script type="text/javascript">
    alert("${msg}");
  </script>
</c:if>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8" />
    <meta
      name="viewport"
      content="width=device-width, initial-scale=1, shrink-to-fit=no"
    />
    <meta name="description" content="" />
    <meta name="author" content="" />
    <title>Enjoy Trip</title>
    <link
      rel="icon"
      type="image/x-icon"
      href="${root}/assets/logo_color_symbol_2.png"
    />
    <!-- Font Awesome icons (free version)-->
    <script
      src="https://use.fontawesome.com/releases/v6.1.0/js/all.js"
      crossorigin="anonymous"
    ></script>
    <!-- Google fonts-->
    <link
      href="https://fonts.googleapis.com/css?family=Varela+Round"
      rel="stylesheet"
    />
    <link
      href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
      rel="stylesheet"
    />
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link
      href="https://fonts.googleapis.com/css2?family=Gowun+Dodum&display=swap"
      rel="stylesheet"
    />
    <!-- Core theme CSS (includes Bootstrap)-->
    <link href="${root}/assets/css/styles.css" rel="stylesheet" />
  </head>
  <body id="page-top">
    <div class="body-wrap">
      <!-- Navigation-->
      <nav
        class="navbar navbar-expand-lg navbar-light fixed-top bg-light"
        id="mainNav"
      >
        <div class="container px-4 px-lg-5">
          <div>
	          <a class="navbar-brand text-black" href="/"
	            ><img
	              src="${root}/assets/logo_color_symbol_2.png"
	              class="logo"
	              alt=""
	            />
	            Enjoy Trip</a
	          >
          </div>
          <button
            class="navbar-toggler navbar-toggler-right"
            type="button"
            data-bs-toggle="collapse"
            data-bs-target="#navbarResponsive"
            aria-controls="navbarResponsive"
            aria-expanded="false"
            aria-label="Toggle navigation"
          >
            Menu
            <i class="fas fa-bars"></i>
          </button>
          <div class="collapse navbar-collapse" id="navbarResponsive">
            <ul class="navbar-nav ms-auto">
              <%--
              <c:if test="${empty userinfo}">
                --%>
                <li class="nav-item nav-items-user-logout">
                  <a
                    class="nav-link text-black"
                    id="nav-item-login"
                    href=""
                    data-bs-toggle="modal"
                    data-bs-target="#loginModal"
                    >Login</a
                  >
                </li>
                <li class="nav-item nav-items-user-logout">
                  <a
                    class="nav-link text-black"
                    href="#"
                    data-bs-toggle="modal"
                    data-bs-target="#SignUpModal"
                    >Sign-Up</a
                  >
                </li>
                <%--
              </c:if>
              --%> <%--
              <c:if test="${!empty userinfo}">
                --%>
                <li class="nav-item nav-items-user-login">
                  <a
                    class="nav-link text-black"
                    id="nav-item-info"
                    href="#"
                    data-bs-toggle="modal"
                    data-bs-target="#infoModal"
                    >Info</a
                  >
                </li>
                <li class="nav-item nav-items-user-login">
                  <div class="nav-link text-black" id="nav-item-logout">
                    Logout
                  </div>
                </li>
<%--            <li class="nav-item nav-items-user-login">
                  <div class="nav-link text-black" id="nav-item-kakao-logout">
                    <form name="logout" action="${root }/user/kakaologout">
                      <input type="submit" value="logout">
                    </form>
                  </div>
                </li> --%>
                <%--
              </c:if>
              --%>
            </ul>
          </div>
        </div>
      </nav>

