<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>注册页面</title>
    <link rel="stylesheet" href="css/table.css">
</head>
<body style="background-color: #E8E1DF;">
    <%@include file="sidebar.jsp"%>
    <div id="wrapper">
        <!-- Page Content -->
        <div id="page-content-wrapper">
            <div class="container-fluid">

                <div class="center">
                    <form class="form"  action="register" method="post" id="registerForm">
                        <table class="table">
                            <tr>
                                <td></td>
                                <td><h2>教工注册</h2></td>
                                <td></td>
                            </tr>
                            <tr>
                                <td class="right"><label for="Name">教工号：</label> </td>
                                <td><input type="text" userName="teacherID" id="teacherID" value="${messageModel.object.teacherID}"> </td>
                                <td></td>
                            </tr>
                            <tr><!--label 标签的作用是当点击文字也会跳到文本输出框-->
                                <!--for属性与ID属性对应规定 label 绑定到哪个表单元素。-->
                                <td class="right"><label for="userName">姓名：</label> </td>
                                <td><input type="text" userName="userName" id="userName" value="${messageModel.object.userName}"> </td>
                                <td></td>
                            </tr>
                            <tr>
                                <td class="right"><label for="password">密码：</label> </td>
                                <td><input type="password" userName="password" id="password" value="${messageModel.object.password}"> </td>
                                <td></td>
                            </tr>
                            <tr>
                                <td class="right"><label for="confirmPassword">确认密码：</label> </td>
                                <td><input type="password" userName="confirmPassword" id="confirmPassword" value="${messageModel.object.confirmPassword}"> </td>
                                <td></td>
                            </tr>
                            <tr>
                                <td class="right"><label for="GenderMale">性别：</label></td>
                                <td>
                                    <input type="radio" id="GenderMale" userName="gender" value="Male" checked="checked"><label for="GenderMale">男</label>
                                    <input type="radio" id="GenderFemale" userName="gender" value="Female"><label for="GenderFemale">女</label>
                                </td>
                                <td></td>
                            </tr>
                            <tr>
                                <td class="right"><label for="age">年龄：</label> </td>
                                <td><input type="text" userName="age" id="age" value="${messageModel.object.age}"> </td>
                                <td></td>
                            </tr>
                            <tr>
                                <td class="right"><label for="contact">联系方式：</label> </td>
                                <td><input type="text" userName="contact" id="contact" value="${messageModel.object.contact}"> </td>
                                <td></td>
                            </tr>
                            <tr>
                                <td class="right"><label for="department">所属院系：</label> </td>
                                <td><input type="text" userName="department" id="department" value="${messageModel.object.department}"> </td>
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
                                    <input type="submit" value="注册" id="registerBtn">
                                </td>
                            </tr>
                            <tr>
                                <td></td>
                                <td>
                                    已有账号？<a href="http://localhost:80/DormitoryManagementSystem/login.jsp">立即登录</a>
                                </td>
                            </tr>
                        </table>
                    </form>
                </div>

            </div>
        </div>
    </div>


    <%@include file="footer.jsp"%>
</body>
    <%--引入Jquery的js文件--%>
    <script type="text/javascript" src="js/jquery-3.7.1.js"></script>
    <script type="text/javascript">
        /**
         * 登录表单验证
         *  1.给登录按钮绑定点击时间（通过id选择器绑定）
         *  2.获取用户姓名和密码的值
         *  3.判断姓名是否为空
         *      如果姓名为空，提示用户（span标签赋值），并且return
         *  4.判断密码是否为空
         *      如果密码为空，提示用户（span标签赋值），并且return
         *  5.如果都不为空，则手动提交表单
         */
        $("#registerBtn").click(function(event) {
                event.preventDefault(); // 阻止表单的默认提交行为

                var teacherID = $("#teacherID").val();
                var password = $("#password").val();
                var confirmPassword = $("#confirmPassword").val();
                var userName = $("#userName").val();
                var age = $("#age").val();
                var contact = $("#contact").val();
                var department = $("#department").val();

            if (isEmpty(teacherID)){
                //如果姓名为空，提示用户（span标签赋值），并且return html()
                $("#msg").html("教工号不可为空！")
                return;
            }
            //判断姓名是否为空
            if (isEmpty(userName)){
                //如果姓名为空，提示用户（span标签赋值），并且return html()
                $("#msg").html("姓名不可为空！")
                return;
            }
            //判断密码是否为空
            if (isEmpty(password) || isEmpty(confirmPassword)){
                //如果姓名为空，提示用户（span标签赋值），并且return html()
                $("#msg").html("密码不可为空！")
                return;
            }
            //判断密码两次输入是否相同
            if (password !== confirmPassword) {
                // 如果两次输入的密码不相同，提示用户密码不相同，并且返回
                $("#msg").html("两次输入的密码不相同！");
                return;
            }

            if (isEmpty(age) ){
                $("#msg").html("年龄不能为空！")
                return;
            }
            //判断是否符合要求
            if (isEmpty(contact) ){
                //如果联系方式为空，提示联系方式不能为空，返回
                $("#msg").html("联系方式不能为空！")
                return;
            }
            if (isEmpty(department) ){
                //如果联系方式为空，提示所属院系不能为空，返回
                $("#msg").html("所属院系不能为空！")
                return;
            }
            //如果都不为空，则手动提交表单
            $("#registerForm").submit();
        });
        function isEmpty(str){
            if (str === null || str.trim() === "") {
                return true;
            }
            return false;
        }

    </script>
</html>
