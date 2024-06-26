<%--
  Created by IntelliJ IDEA.
  User: Yanz
  Date: 2024/6/19
  Time: 下午8:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>报修查询</title>
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
            <div id="maintenancerecord-container">

            </div>
            <form action="addMaintenanceRecord" method="post" id="addForm" style="margin: 0 auto">
                <table class="table">
                    <tr>
                        <td></td>
                        <td><h2>维护记录</h2></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td class="right"><label for="dormID">宿舍号：</label> </td>
                        <td><input type="text" name="dormID" id="dormID"> </td>
                        <td></td>
                    </tr>
                    <tr>
                        <td class="right"><label for="content">维护内容：</label> </td>
                        <td><textarea name="content" id="content" rows="5" cols="30"></textarea></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td colspan="2" style="text-align: center">
                            <span id="msg" style="font-size: 12px;color: red"> ${messageModel.msg}</span>
                        </td>
                    </tr>
                    <tr>
                        <td></td>
                        <td>
                            <input type="submit" id="add-Btn" value="提交">
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
    $("#add-Btn").click(function () {
        var dormID = $("#dormID").val(); // 确保获取正确的宿舍号
        var content = $("#content").val(); // 确保获取正确的维护内容

        // 确保宿舍号和维护内容不为空
        if (isEmpty(dormID)){
            $("#msg").html("宿舍号不可为空！");
            return;
        }
        if (isEmpty(content)){
            $("#msg").html("维护内容不可为空！");
            return;
        }
        $("#addForm").submit();
    });

    // 确保 isEmpty 函数的定义正确
    function isEmpty(str){
        return !str || str.trim() === "";
    }

    $(document).ready(function() {
        // 发起 AJAX 请求获取通知数据
        $.ajax({
            type: "POST",
            url: "selectMRByIDServlet?teacherID=<%= teacherID %>",
            dataType: "json",
            success: function (data) {
                // 成功获取数据后，更新页面内容
                var maintenancerecords = data; // 假设返回的数据是通知对象数组
                var container = $("#maintenancerecord-container");
                container.empty(); // 清空容器

                // 创建表格元素
                var table = "<table style='width: 100%; border-collapse: collapse;'>" +
                    "<thead>" +
                    "<tr>" +
                    "<th style='border: 1px solid #ddd; padding: 8px;'>记录编号</th>" +
                    "<th style='border: 1px solid #ddd; padding: 8px;'>宿舍编号</th>" +
                    "<th style='border: 1px solid #ddd; padding: 8px;'>内容</th>" +
                    "<th style='border: 1px solid #ddd; padding: 8px;'>报告日期</th>" +
                    "<th style='border: 1px solid #ddd; padding: 8px;'>维修日期</th>" +
                    "<th style='border: 1px solid #ddd; padding: 8px;'>状态</th>" +
                    "</tr>" +
                    "</thead>" +
                    "<tbody>";

                // 遍历通知数据，生成表格行并添加到表格中
                for (var i = 0; i < maintenancerecords.length; i++) {
                    var record = maintenancerecords[i];
                    table += "<tr>" +
                        "<td style='border: 1px solid #ddd; padding: 8px;'>" + record.recordID + "</td>" +
                        "<td style='border: 1px solid #ddd; padding: 8px;'>" + record.dormID + "</td>" +
                        "<td style='border: 1px solid #ddd; padding: 8px;'>" + record.content + "</td>" +
                        "<td style='border: 1px solid #ddd; padding: 8px;'>" + record.reportDate + "</td>" +
                        "<td style='border: 1px solid #ddd; padding: 8px;'>" + (record.maintenanceDate ? record.maintenanceDate : "") + "</td>" +
                        "<td style='border: 1px solid #ddd; padding: 8px;'>" + record.status + "</td>" +
                        "</tr>";
                }

                table += "</tbody></table>";

                // 添加表格到容器
                container.append(table);
            },
            error: function (xhr, status, error) {
                console.error("AJAX请求出错:", error);
            }
        })
    })

</script>


</body>
</html>
