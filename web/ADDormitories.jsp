<%--
  Created by IntelliJ IDEA.
  User: Yanz
  Date: 2024/6/21
  Time: 下午6:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>宿舍管理</title>
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
            <div id="dormitory-container">

            </div>
            <form action="addDormitoryServlet" method="post" id="addDormForm" style="margin: 0 auto">
                <table class="table">
                    <tr>
                        <td></td>
                        <td><h2>添加宿舍</h2></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td class="right"><label for="dormID">宿舍号：</label> </td>
                        <td><input type="text" name="dormID" id="dormID"> </td>
                        <td></td>
                    </tr>
                    <tr>
                        <td class="right"><label for="buildingNumber">楼号：</label> </td>
                        <td><input type="text" name="buildingNumber" id="buildingNumber"> </td>
                        <td></td>
                    </tr>
                    <tr>
                        <td class="right"><label for="floor">楼层：</label> </td>
                        <td><input type="number" name="floor" id="floor"></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td class="right"><label for="rooms">房间号：</label> </td>
                        <td><input type="number" name="rooms" id="rooms"></td>
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
                            <input type="submit" id="addDorm-Btn" value="添加">
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
    $("#addDorm-Btn").click(function (e) {
        var dormID = $("#dormID").val(); // 确保获取正确的宿舍号
        var buildingNumber = $("#buildingNumber").val(); // 确保获取正确的楼号
        var floor = $("#floor").val(); // 确保获取正确的楼层
        var rooms = $("#rooms").val(); // 确保获取正确的房间数

        // 确保宿舍号、楼号、楼层、房间数和状态不为空
        if (isEmpty(dormID)){
            $("#msg").html("宿舍号不可为空！");
            e.preventDefault();
            return;
        }
        if (isEmpty(buildingNumber)){
            $("#msg").html("楼号不可为空！");
            e.preventDefault();
            return;
        }
        if (isEmpty(floor)){
            $("#msg").html("楼层不可为空！");
            e.preventDefault();
            return;
        }
        if (isEmpty(rooms)){
            $("#msg").html("房间号不可为空！");
            e.preventDefault();
            return;
        }
        $("#addDormForm").submit();
    });

    // 确保 isEmpty 函数的定义正确
    function isEmpty(str){
        return !str || str.trim() === "";
    }

    $(document).ready(function() {
        // 发起 AJAX 请求获取宿舍数据
        $.ajax({
            type: "POST",
            url: "dormitoryData",
            dataType: "json",
            success: function (data) {
                // 成功获取数据后，更新页面内容
                var dormitories = data; // 假设返回的数据是宿舍对象数组
                var container = $("#dormitory-container");
                container.empty(); // 清空容器

                // 创建表格元素
                var table = "<table style='width: 100%; border-collapse: collapse;'>" +
                    "<thead>" +
                    "<tr>" +
                    "<th style='border: 1px solid #ddd; padding: 8px;'>宿舍号</th>" +
                    "<th style='border: 1px solid #ddd; padding: 8px;'>楼号</th>" +
                    "<th style='border: 1px solid #ddd; padding: 8px;'>楼层</th>" +
                    "<th style='border: 1px solid #ddd; padding: 8px;'>房间数</th>" +
                    "<th style='border: 1px solid #ddd; padding: 8px;'>状态</th>" +
                    "<th style='border: 1px solid #ddd; padding: 8px;'>操作</th>" +
                    "</tr>" +
                    "</thead>" +
                    "<tbody>";

                // 遍历宿舍数据，生成表格行并添加到表格中
                for (var i = 0; i < dormitories.length; i++) {
                    var dormitory = dormitories[i];
                    table += "<tr>" +
                        "<td style='border: 1px solid #ddd; padding: 8px;'>" + dormitory.dormID + "</td>" +
                        "<td style='border: 1px solid #ddd; padding: 8px;'>" + dormitory.buildingNumber + "</td>" +
                        "<td style='border: 1px solid #ddd; padding: 8px;'>" + dormitory.floor + "</td>" +
                        "<td style='border: 1px solid #ddd; padding: 8px;'>" + dormitory.rooms + "</td>" +
                        "<td style='border: 1px solid #ddd; padding: 8px;'>" + dormitory.status + "</td>" +
                        "<td style='border: 1px solid #ddd; padding: 8px;'>" +
                        "<button class='delete-btn' data-dormid='" + dormitory.dormID + "'>删除</button>" +
                        "</td>" +
                        "</tr>";
                }

                table += "</tbody></table>";

                // 添加表格到容器
                container.append(table);

                // 绑定删除按钮点击事件
                $(".delete-btn").click(function() {
                    var dormID = $(this).data("dormid");
                    // 发起删除请求
                    $.ajax({
                        type: "POST",
                        url: "deleteDormitoryServlet",
                        data: { dormID: dormID },
                        success: function(response) {
                            // 成功删除后重新加载宿舍数据
                            alert("删除成功");
                            location.reload();
                        },
                        error: function(xhr, status, error) {
                            console.error("删除请求出错:", error);
                        }
                    });
                });
            },
            error: function (xhr, status, error) {
                console.error("AJAX请求出错:", error);
            }
        })
    })
</script>

</body>
</html>
