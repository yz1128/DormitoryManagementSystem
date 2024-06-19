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
<!-- 导航栏 -->
<%@include file="sidebar.jsp"%>

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
<%@include file="footer.jsp" %>\
<!-- TODO(Yanz,2024/6/20 上午12:26): -->完善checkirecords居住记录
<script>
    $(document).ready(function() {
        // 发起 AJAX 请求获取通知数据
        $.ajax({
            type: "POST",
            url: "    ",
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
                    "<th style='border: 1px solid #ddd; padding: 8px;'>Title</th>" +
                    "<th style='border: 1px solid #ddd; padding: 8px;'>Content</th>" +
                    "<th style='border: 1px solid #ddd; padding: 8px;'>Date</th>" +
                    "</tr>" +
                    "</thead>" +
                    "<tbody>";

                // 遍历通知数据，生成表格行并添加到表格中
                for (var i = 0; i < checkinrecords.length; i++) {
                    var checkinrecord = checkinrecords[i];
                    table += "<tr>" +
                        "<td style='border: 1px solid #ddd; padding: 8px;'>" + checkinrecord.title + "</td>" +
                        "<td style='border: 1px solid #ddd; padding: 8px;'>" + checkinrecord.content + "</td>" +
                        "<td style='border: 1px solid #ddd; padding: 8px;'>" + checkinrecord.date + "</td>" +
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
