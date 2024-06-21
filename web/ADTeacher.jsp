<%--
  Created by IntelliJ IDEA.
  User: Yanz
  Date: 2024/6/19
  Time: 下午6:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>教工管理</title>
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
            <div id="teacher-container">

            </div>
            <form action="addTeacherServlet" method="post" id="addTeacherForm" style="margin: 20px 0;">
                <table class="table">
                    <tr>
                        <td class="right"><label for="teacherID">工号：</label> </td>
                        <td><input type="text" name="teacherID" id="teacherID"> </td>
                    </tr>
                    <tr>
                        <td class="right"><label for="password">密码：</label> </td>
                        <td><input type="password" name="password" id="password"> </td>
                    </tr>
                    <tr>
                        <td class="right"><label for="name">姓名：</label> </td>
                        <td><input type="text" name="name" id="name"> </td>
                    </tr>
                    <tr>
                        <td class="right"><label for="gender">性别：</label> </td>
                        <td><input type="text" name="gender" id="gender"> </td>
                    </tr>
                    <tr>
                        <td class="right"><label for="age">年龄：</label> </td>
                        <td><input type="text" name="age" id="age"> </td>
                    </tr>
                    <tr>
                        <td class="right"><label for="contact">联系方式：</label> </td>
                        <td><input type="text" name="contact" id="contact"> </td>
                    </tr>
                    <tr>
                        <td class="right"><label for="department">部门：</label> </td>
                        <td><input type="text" name="department" id="department"> </td>
                    </tr>
                    <tr>
                        <td colspan="2" style="text-align: center">
                            <span id="msg" style="font-size: 12px;color: red"> ${messageModel.msg}</span>
                        </td>
                    </tr>
                    <tr>
                        <td></td>
                        <td>
                            <input type="submit" id="addTeacher-Btn" value="添加">
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
        // 发起 AJAX 请求获取教师数据
        $.ajax({
            type: "POST",
            url: "teacherDataServlet",
            dataType: "json",
            success: function (data) {
                // 成功获取数据后，更新页面内容
                var teachers = data; // 假设返回的数据是教师对象数组
                var container = $("#teacher-container");
                container.empty(); // 清空容器

                // 创建表格元素
                var table = "<table style='width: 100%; border-collapse: collapse;'>" +
                    "<thead>" +
                    "<tr>" +
                    "<th style='border: 1px solid #ddd; padding: 8px;'>工号</th>" +
                    "<th style='border: 1px solid #ddd; padding: 8px;'>姓名</th>" +
                    "<th style='border: 1px solid #ddd; padding: 8px;'>性别</th>" +
                    "<th style='border: 1px solid #ddd; padding: 8px;'>年龄</th>" +
                    "<th style='border: 1px solid #ddd; padding: 8px;'>联系方式</th>" +
                    "<th style='border: 1px solid #ddd; padding: 8px;'>部门</th>" +
                    "<th style='border: 1px solid #ddd; padding: 8px;'>操作</th>" +
                    "</tr>" +
                    "</thead>" +
                    "<tbody>";

                // 遍历教师数据，生成表格行并添加到表格中
                for (var i = 0; i < teachers.length; i++) {
                    var teacher = teachers[i];
                    table += "<tr>" +
                        "<td style='border: 1px solid #ddd; padding: 8px;'>" + teacher.teacherID + "</td>" +
                        "<td style='border: 1px solid #ddd; padding: 8px;'>" + teacher.name + "</td>" +
                        "<td style='border: 1px solid #ddd; padding: 8px;'>" + teacher.gender + "</td>" +
                        "<td style='border: 1px solid #ddd; padding: 8px;'>" + teacher.age + "</td>" +
                        "<td style='border: 1px solid #ddd; padding: 8px;'>" + teacher.contact + "</td>" +
                        "<td style='border: 1px solid #ddd; padding: 8px;'>" + teacher.department + "</td>" +
                        "<td style='border: 1px solid #ddd; padding: 8px;'>" +
                        "<button class='delete-btn' data-teacherid='" + teacher.teacherID + "'>删除</button>" +
                        "</td>" +
                        "</tr>";
                }

                table += "</tbody></table>";

                // 添加表格到容器
                container.append(table);

                // 绑定删除按钮点击事件
                $(".delete-btn").click(function() {
                    var teacherID = $(this).data("teacherid");
                    // 发起删除请求
                    $.ajax({
                        type: "POST",
                        url: "deleteTeacherServlet",
                        data: { teacherID: teacherID },
                        success: function(response) {
                            // 成功删除后重新加载教师数据
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

        $("#addTeacher-Btn").click(function (e) {
            var teacherID = $("#teacherID").val(); // 确保获取正确的工号
            var password = $("#password").val(); // 确保获取正确的密码
            var name = $("#name").val(); // 确保获取正确的姓名
            var gender = $("#gender").val(); // 确保获取正确的性别
            var age = $("#age").val(); // 确保获取正确的年龄
            var contact = $("#contact").val(); // 确保获取正确的联系方式
            var department = $("#department").val(); // 确保获取正确的部门

            // 确保所有字段不为空
            if (isEmpty(teacherID)){
                $("#msg").html("工号不可为空！");
                e.preventDefault();
                return;
            }
            if (isEmpty(password)){
                $("#msg").html("密码不可为空！");
                e.preventDefault();
                return;
            }
            if (isEmpty(name)){
                $("#msg").html("姓名不可为空！");
                e.preventDefault();
                return;
            }
            if (isEmpty(gender)){
                $("#msg").html("性别不可为空！");
                e.preventDefault();
                return;
            }
            if (isEmpty(age)){
                $("#msg").html("年龄不可为空！");
                e.preventDefault();
                return;
            }
            if (isEmpty(contact)){
                $("#msg").html("联系方式不可为空！");
                e.preventDefault();
                return;
            }
            if (isEmpty(department)){
                $("#msg").html("部门不可为空！");
                e.preventDefault();
                return;
            }
            $("#addTeacherForm").submit();
        });

        // 确保 isEmpty 函数的定义正确
        function isEmpty(str){
            return !str || str.trim() === "";
        }
    });

</script>

</body>
</html>
