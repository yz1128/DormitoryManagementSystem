<%@ page import="com.DM.entity.Teacher" %><%--
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
    <% int teacherID = 0; %>
    <!-- Sidebar -->
    <div id="sidebar-wrapper">
            <ul class="sidebar-nav">
                <li class="sidebar-brand">
                    <a href="index.jsp">
                        NCWU 教工宿舍管理系统
                    </a>
                </li>
                <li>
                    <a id="TeacherInfo" style="color:#ffffff">用户名</a>
                    <a id="loginID" href="login.jsp">点击登录</a>
                </li>
                <li>
                    <a href="notification.jsp">通知查看</a>
                </li>
                <li>
                    <a href="checkinrecord.jsp">居住记录</a>
                </li>
                <li>
                    <a href="maintenancerecord.jsp">报修查询</a>
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

    Teacher teacher = (Teacher) session.getAttribute("teacher");
    String Name = teacher != null ? teacher.getName() : "";
    String teacherIDStr = teacher != null ? teacher.getTeacherID() : "";
    // 如果teacherIDStr不为空，则尝试将其转换为整数
    if (!teacherIDStr.isEmpty()) {
        teacherID = Integer.parseInt(teacherIDStr);
    }
%>
<script>
    $(document).ready(function () {
        var Name = '<%=Name%>'; // 将用户名传递给 JavaScript 变量
        if (Name) {
            $("#TeacherInfo").text(Name); // 更新导航栏中的用户名
            $("#logout:contains('退出')").show(); // 显示退出按钮
            $("#loginID:contains('登录')").hide(); // 隐藏登录按钮
        } else {
            $("#TeacherInfo").text("未登录"); // 更新导航栏中的文本为"未登录"
            $("#logout:contains('退出')").hide(); // 隐藏退出按钮
            $("#loginID:contains('登录')").show(); // 显示登录按钮
        }
    });

</script>
</body>

</html>
