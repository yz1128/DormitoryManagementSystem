<%@ page import="com.DM.entity.User" %><%--
  Created by IntelliJ IDEA.
  User: Yanz
  Date: 2024/6/19
  Time: 上午8:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Simple Sidebar - Start Bootstrap Template</title>

    <!-- Latest compiled and minified CSS -->
    <link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">

    <!-- Optional theme -->
    <link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap-theme.min.css">

    <!-- jQuery -->
    <script src="//ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>

    <!-- Latest compiled and minified JavaScript -->
    <script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>

    <!-- Custom CSS -->
    <link href="css/sidebar.css" rel="stylesheet">

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

    <style media="screen">
        /*body { padding-top: 70px; }*/
        #connectLogo {
            height: 60px;
            padding: 15px 0 5px 0;
        }
        #logo {
            height: 60px;
            padding: 5px 0 5px 20px;
        }

        .share-link {
            line-height: 60px;
            padding: 0 1em;
            font-size: 2em;
        }
    </style>

</head>

<body>

<div id="wrapper">
    <% int userID = 0; %>

    <!-- Sidebar -->
    <div id="sidebar-wrapper">
        <ul class="sidebar-nav">
            <li class="sidebar-brand">
                <a href="ADindex.jsp">
                    NCWU宿舍管理系统后台
                </a>
            </li>
            <li>
                <a id="UserInfo" style="color:#ffffff">用户名</a>
                <a id="loginID" href="ADlogin.jsp">点击登录</a>
            </li>
            <li>
                <a href="ADNotification.jsp">通知发布</a>
            </li>
            <li>
                <a href="ADTeacher.jsp">教工管理</a>
            </li>
            <li>
                <a href="ADDormitories.jsp">宿舍管理</a>
            </li>
            <li>
                <a href="ADCheckinrecord.jsp">居住记录</a>
            </li>
            <li>
                <a href="ADMaintenancerecord.jsp">报修管理</a>
            </li>
            <li>
                <a href="#">About</a>
            </li>
            <li>
                <a id="logout" href="logout">退出</a>
            </li>
        </ul>
    </div>
    <!-- /#sidebar-wrapper -->



</div>
<!-- /#wrapper -->

<%
    User user = (User) session.getAttribute("user");
    String userName = user != null ? user.getUserName() : "";
    String userIDStr = "";
    if (user != null) {
        userIDStr = String.valueOf(user.getUserID());
    }

%>
userID = <%= userIDStr %>;
<script>
    $(document).ready(function () {
        var userName = '<%= userName %>'; // 将用户名传递给 JavaScript 变量
        var userID = '<%= userIDStr %>'; // 将userID传递给 JavaScript 变量
        if (userName) {
            $("#UserInfo").text("欢迎，" + userName); // 更新导航栏中的用户名
            $("#logout:contains('退出')").show(); // 显示退出按钮
            $("#loginID:contains('登录')").hide(); // 隐藏登录按钮
        } else {
            $("#UserInfo").text("未登录"); // 更新导航栏中的文本为"未登录"
            $("#logout:contains('退出')").hide(); // 隐藏退出按钮
            $("#loginID:contains('登录')").show(); // 显示登录按钮
        }
    });

</script>
</body>

</html>
