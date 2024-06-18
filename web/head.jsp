<%@ page import="com.DM.entity.Teacher" %>
<%@ page import="com.DM.entity.Teacher" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link href="css/bootstrap.min5.3.css" rel="stylesheet">
    <link rel="stylesheet" href="css/styles.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
    <script src="js/bootstrap.bundle.min5.3.js"></script>
    <script src="js/jquery-3.7.1.js"></script>
</head>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container-fluid">
        <a class="navbar-brand" href="index.jsp">网上商城</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item">
                    <a class="nav-link <%= request.getRequestURI().endsWith("index.jsp") ? "active" : "" %>" aria-current="page" href="index.jsp">首页</a>
                </li>

                <li class="nav-item">
                    <a class="nav-link <%= request.getRequestURI().endsWith("all.jsp") ? "active" : "" %>" href="all.jsp"></a>
                </li>

                <li class="nav-item">
                    <a class="nav-link <%= request.getRequestURI().endsWith("about.jsp") ? "active" : "" %>" href="#">关于我们</a>
                </li>
            </ul>

            <ul class="navbar-nav mb-2 mb-lg-0">
                <li class="nav-item dropdown">

                    <a class="nav-link dropdown-toggle <%=request.getRequestURI().endsWith("register.jsp") || request.getRequestURI().endsWith("userInfo.jsp") || request.getRequestURI().endsWith("login.jsp") ? "active" : "" %>" href="#" id="TeacherInfo" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        用户名
                    </a>
                    <ul class="dropdown-menu" aria-labelledby="TeacherInfo">
                        <li><a class="dropdown-item" href="TeacherInfoUpdate">用户信息</a></li>
                        <li><a class="dropdown-item" href="login.jsp">登录</a></li>
                        <li><a class="dropdown-item" href="logout">退出</a></li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
</nav>

<!--  -->
<%
    Teacher teacher = (Teacher) session.getAttribute("teacher");
    String Name = teacher != null ? teacher.getName() : "";
%>
<script>
    $(document).ready(function () {
        var Name = '<%= Name %>'; // 将用户名传递给 JavaScript 变量
        if (Name) {
            $("#TeacherInfo").text(Name); // 更新导航栏中的用户名
            $(".dropdown-menu .dropdown-item:contains('退出')").show(); // 显示退出按钮
            $(".dropdown-menu .dropdown-item:contains('登录')").hide(); // 隐藏登录按钮
        } else {
            $("#TeacherInfo").text("未登录"); // 更新导航栏中的文本为"未登录"
            $(".dropdown-menu .dropdown-item:contains('退出')").hide(); // 隐藏退出按钮
            $(".dropdown-menu .dropdown-item:contains('登录')").show(); // 显示登录按钮
        }
    });

</script>
</html>
