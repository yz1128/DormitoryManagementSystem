<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
  <meta charset="UTF-8">
  <title>网上商城</title>
  <link href="css/bootstrap.min5.3.css" rel="stylesheet">
  <link rel="stylesheet" href="css/styles.css">
</head>
<body style="background-color: #E8E1DF;">
<!-- 导航栏 -->
<%@include file="head.jsp" %>

<!-- 商品展示 -->
<div class="shop">
  <%-- 轮播图片广告 --%>
  <div id="carouselExampleIndicators" class="carousel slide">
    <div class="carousel-indicators">
      <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
      <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="1" aria-label="Slide 2"></button>
      <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="2" aria-label="Slide 3"></button>
    </div>
    <div class="carousel-inner">
      <div class="carousel-item active">
        <img src="image/misu7Cre.jpg" style="width: 1200px;height: 650px;" class="d-block w-100" alt="...">
      </div>
      <div class="carousel-item">
        <img src="image/su7_1.jpg" style="width: 1200px;height: 650px;" class="d-block w-100" alt="...">
      </div>
      <div class="carousel-item">
        <img src="image/mi14Pro.jpg" style="width: 1200px;height: 650px;" class="d-block w-100" alt="...">
      </div>
    </div>
    <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
      <span class="carousel-control-prev-icon" aria-hidden="true"></span>
      <span class="visually-hidden">Previous</span>
    </button>
    <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
      <span class="carousel-control-next-icon" aria-hidden="true"></span>
      <span class="visually-hidden">Next</span>
    </button>
  </div>
</div>

<!-- 底部信息 -->
<%@include file="footer.jsp" %>


</body>
</html>

