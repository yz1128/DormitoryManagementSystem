<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
  <meta charset="UTF-8">
  <title>NCWU教工宿舍管理系统</title>
</head>
<body style="background-color: #E8E1DF;">
<!-- 导航栏 -->
<%@include file="sidebar.jsp"%>

<div id="wrapper">
  <!-- Page Content -->
  <div id="page-content-wrapper">
    <div class="container-fluid">
      <%@include file="showDorm.jsp"%>
    </div>
  </div>
</div>





<!-- 底部信息 -->
<%@include file="footer.jsp" %>


</body>
</html>

