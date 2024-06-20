<%--
  Created by IntelliJ IDEA.
  User: Yanz
  Date: 2024/6/19
  Time: 下午9:38
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
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
            <div id="checkinrecord-container">

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
            url: "selectCIRByIDServlet?teacherID=<%= teacherID %>",
            dataType: "json",
            success: function (data) {
                // 成功获取数据后，更新页面内容
                var checkinrecords = data; // 假设返回的数据是通知对象数组
                var container = $("#checkinrecord-container");
                container.empty(); // 清空容器

                // 创建表格元素
                var table = "<table style='width: 100%; border-collapse: collapse;'>" +
                    "<thead>" +
                    "<tr>" +
                    "<th style='border: 1px solid #ddd; padding: 8px;'>房间号</th>" +
                    "<th style='border: 1px solid #ddd; padding: 8px;'>入住日期</th>" +
                    "<th style='border: 1px solid #ddd; padding: 8px;'>退宿日期</th>" +
                    "<th style='border: 1px solid #ddd; padding: 8px;'>状态</th>" +
                    "</tr>" +
                    "</thead>" +
                    "<tbody>";

                // 遍历通知数据，生成表格行并添加到表格中
                for (var i = 0; i < checkinrecords.length; i++) {
                    var checkinrecord = checkinrecords[i];
                    var status = (checkinrecord.checkInDate && checkinrecord.checkOutDate) ? "退宿" : "入住";
                    table += "<tr>" +
                        "<td style='border: 1px solid #ddd; padding: 8px;'>" + checkinrecord.dormID + "</td>" +
                        "<td style='border: 1px solid #ddd; padding: 8px;'>" + checkinrecord.checkInDate + "</td>" +
                        "<td style='border: 1px solid #ddd; padding: 8px;'>" + (checkinrecord.checkOutDate ? checkinrecord.checkOutDate : "") + "</td>" +
                        "<td style='border: 1px solid #ddd; padding: 8px;'>" + status + "</td>" +
                        "<div class='col-1'> <button class='CheckOut-btn' data-checkinrecord-dormID='" + checkinrecord.dormID + "'>移出</button> </div>" +
                        "</tr>";
                }

                table += "</tbody></table>";

                // 添加表格到容器
                container.append(table);

                // 为每个 "CheckOut-btn" 按钮添加点击事件处理程序
                $(".CheckOut-btn").click(function() {
                    var dormID = $(this).data("checkinrecord-dormID"); // 获取商品名称
                    var teacherID = '<%= teacherID %>';

                    $.ajax({
                        type: "POST",
                        url: "updateRecordServlet",
                        data: { dormID: dormID, teacherID: teacherID },
                        success: function(response) {
                            // 处理操作成功的情况，可以根据需要更新页面或显示消息
                            console.log("Record updated successfully.");
                        },
                        error: function(xhr, status, error) {
                            // 处理错误情况，例如网络错误或服务器返回的错误消息
                            console.error("Error updating record:", error);
                        }
                    });
                });

            }
        })
    })
</script>
</body>
</html>
