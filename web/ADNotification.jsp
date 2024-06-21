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
<%@include file="ADsidebar.jsp"%>
<%
    if (session.getAttribute("user") == null) {
        // 如果 session 不存在或者管理员数据为空，则重定向到 ADlogin.jsp 页面
        response.sendRedirect("ADlogin.jsp");
    }
%>
<div id="wrapper">
    <!-- Page Content -->
    <div id="page-content-wrapper">
        <div class="container-fluid">
            <div id="notification-container">

            </div>
            <form action="addNotificationServlet" method="post" id="addNotificationForm" style="margin: 20px 0;">
                <table class="table">
                    <tr>
                        <td class="right"><label for="title">标题：</label> </td>
                        <td><input type="text" name="title" id="title"> </td>
                    </tr>
                    <tr>
                        <td class="right"><label for="content">内容：</label> </td>
                        <td><textarea name="content" id="content" rows="5" cols="30"></textarea></td>
                    </tr>
                    <tr>
                        <td class="right"><label for="userID">管理员ID：</label> </td>
                        <td><input type="text" name="userID" id="userID" value="${user.userID}"></td>
                    </tr>
                    <tr>
                        <td colspan="2" style="text-align: center">
                            <span id="msg" style="font-size: 12px;color: red"> ${messageModel.msg}</span>
                        </td>
                    </tr>
                    <tr>
                        <td></td>
                        <td>
                            <input type="submit" id="addNotification-Btn" value="发布">
                        </td>
                    </tr>
                </table>
            </form>
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
                    "<th style='border: 1px solid #ddd; padding: 8px;'>标题</th>" +
                    "<th style='border: 1px solid #ddd; padding: 8px;'>内容</th>" +
                    "<th style='border: 1px solid #ddd; padding: 8px;'>日期</th>" +
                    "<th style='border: 1px solid #ddd; padding: 8px;'>操作</th>" +
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
                        "<td style='border: 1px solid #ddd; padding: 8px;'>" +
                        "<button class='delete-btn' data-notificationid='" + notification.notificationID + "'>删除</button>" +
                        "</td>" +
                        "</tr>";
                }

                table += "</tbody></table>";

                // 添加表格到容器
                container.append(table);

                // 绑定删除按钮点击事件
                $(".delete-btn").click(function() {
                    var notificationID = $(this).data("notificationid");
                    // 发起删除请求
                    $.ajax({
                        type: "POST",
                        url: "deleteNotificationServlet",
                        data: { notificationID: notificationID },
                        success: function(response) {
                            // 成功删除后重新加载通知数据
                            alert("删除成功");
                            location.reload();
                        },
                        error: function(xhr, status, error) {
                            console.error("删除请求出错:", error);
                        }
                    });
                });
            },
            error: function(xhr, status, error) {
                console.error("AJAX请求出错:", error);
            }
        });

        $("#addNotification-Btn").click(function (e) {
            var userID = '<%= userID %>';
            var title = $("#title").val(); // 确保获取正确的标题
            var content = $("#content").val(); // 确保获取正确的内容

            // 确保标题和内容不为空
            if (isEmpty(title)){
                $("#msg").html("标题不可为空！");
                e.preventDefault();
                return;
            }
            if (isEmpty(content)){
                $("#msg").html("内容不可为空！");
                e.preventDefault();
                return;
            }
            $("#addNotificationForm").submit();
        });

        // 确保 isEmpty 函数的定义正确
        function isEmpty(str){
            return !str || str.trim() === "";
        }
    });

</script>

</body>
</html>
