<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>宿舍管理系统后台</title>
</head>
<body>
<%@include file="ADsidebar.jsp"%>
<div id="wrapper">
  <!-- Page Content -->
  <div id="page-content-wrapper">
    <div class="container-fluid">
    <%@include file="showDorm.jsp"%>
    </div>
  </div>
</div>

<%@include file="footer.jsp" %>
</body>
</html>
