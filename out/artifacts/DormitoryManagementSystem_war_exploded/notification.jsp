<%--
  Created by IntelliJ IDEA.
  User: Yanz
  Date: 2024/6/19
  Time: 下午6:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>通知查看</title>
</head>
<body>
<%@include file="sidebar.jsp"%>
<%
    if (session.getAttribute("teacher") == null) {
        // 如果 session 不存在或者教工数据为空，则重定向到 login.jsp 页面
        response.sendRedirect("login.jsp");
    }
%>
<div id="wrapper">
    <!-- Page Content -->
    <div id="page-content-wrapper">
        <div class="container-fluid">
            <div id="notification-container">

            </div>
        </div>
    </div>
</div>
<!-- 底部信息 -->
<%@include file="footer.jsp" %>
<script>
    $(document).ready(function() {
        // 发起 AJAX 请求获取通知数据
        $.ajax({
            type: "POST",
            url: "NotificationDataServlet",
            dataType: "json",
            success: function (data) {
                // 成功获取数据后，更新页面内容
                var notifications = data; // 假设返回的数据是通知对象数组
                var container = $("#notification-container");
                container.empty(); // 清空容器

                // 创建表格元素
                var table = "<table style='width: 100%; border-collapse: collapse;'>" +
                    "<thead>" +
                    "<tr>" +
                    "<th style='border: 1px solid #ddd; padding: 8px;'>Title</th>" +
                    "<th style='border: 1px solid #ddd; padding: 8px;'>Content</th>" +
                    "<th style='border: 1px solid #ddd; padding: 8px;'>Date</th>" +
                    "</tr>" +
                    "</thead>" +
                    "<tbody>";

                // 遍历通知数据，生成表格行并添加到表格中
                for (var i = 0; i < notifications.length; i++) {
                    var notification = notifications[i];
                    table += "<tr>" +
                        "<td style='border: 1px solid #ddd; padding: 8px;'>" + notification.title + "</td>" +
                        "<td style='border: 1px solid #ddd; padding: 8px;'>" + notification.content + "</td>" +
                        "<td style='border: 1px solid #ddd; padding: 8px;'>" + notification.date + "</td>" +
                        "</tr>";
                }

                table += "</tbody></table>";

                // 添加表格到容器
                container.append(table);
            }
        })
    })

</script>

</body>
</html>
