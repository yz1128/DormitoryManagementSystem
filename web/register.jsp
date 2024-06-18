<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>注册页面</title>
    <link rel="stylesheet" href="css/table.css">
</head>
<body style="background-color: #E8E1DF;">
    <%@include file="head.jsp"%>
        <div class="center">
            <form class="form" action="register" method="post" id="registerForm">
                <table class="table">
                    <tr>
                        <td></td>
                        <td><h2>教工注册</h2></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td class="right"><label for="Name">教工号：</label> </td>
                        <td><input type="text" name="TeacherID" id="TeacherID" value="${messageModel.object.Name}"> </td>
                        <td></td>
                    </tr>
                    <tr><!--label 标签的作用是当点击文字也会跳到文本输出框-->
                        <!--for属性与ID属性对应规定 label 绑定到哪个表单元素。-->
                        <td class="right"><label for="Name">姓名：</label> </td>
                        <td><input type="text" name="Name" id="Name" value="${messageModel.object.Name}"> </td>
                        <td></td>
                    </tr>
                    <tr>
                        <td class="right"><label for="Password">密码：</label> </td>
                        <td><input type="password" name="Password" id="Password"> </td>
                        <td></td>
                    </tr>
                    <tr>
                        <td class="right"><label for="ConfirmPassword">确认密码：</label> </td>
                        <td><input type="password" name="ConfirmPassword" id="ConfirmPassword"> </td>
                        <td></td>
                    </tr>
                    <tr>
                        <td class="right"><label for="GenderMale">性别：</label></td>
                        <td>
                            <input type="radio" id="GenderMale" name="Gender" value="Male" checked="checked"><label for="GenderMale">男</label>
                            <input type="radio" id="GenderFemale" name="Gender" value="Female"><label for="GenderFemale">女</label>
                        </td>
                        <td></td>
                    </tr>
                    <tr>
                        <td class="right"><label for="Age">年龄：</label> </td>
                        <td><input type="text" name="Age" id="Age" value="${messageModel.object.Age}"> </td>
                        <td></td>
                    </tr>
                    <tr>
                        <td class="right"><label for="Contact">联系方式：</label> </td>
                        <td><input type="text" name="Contact" id="Contact" value="${messageModel.object.Contact}"> </td>
                        <td></td>
                    </tr>
                    <tr>
                        <td class="right"><label for="Department">所属院系：</label> </td>
                        <td><input type="text" name="Department" id="Department" value="${messageModel.object.Department}"> </td>
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
                            已有账号？<a href="http://localhost:80/Web/login.jsp">立即登录</a>
                        </td>
                    </tr>
                </table>
            </form>
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

                var TeacherID = $("#TeacherID").val();
                var Password = $("#Password").val();
                var ConfirmPassword = $("#ConfirmPassword").val();
                var Name = $("#Name").val();
                var Gender = $("#Gender").val();
                var Age = $("#Age").val();
                var Contact = $("#Contact").val();
                var Department = $("#Department").val();

            if (isEmpty(TeacherID)){
                //如果姓名为空，提示用户（span标签赋值），并且return html()
                $("#msg").html("教工号不可为空！")
                return;
            }
            //判断姓名是否为空
            if (isEmpty(Name)){
                //如果姓名为空，提示用户（span标签赋值），并且return html()
                $("#msg").html("姓名不可为空！")
                return;
            }
            //判断密码是否为空
            if (isEmpty(Password) || isEmpty(ConfirmPassword)){
                //如果姓名为空，提示用户（span标签赋值），并且return html()
                $("#msg").html("密码不可为空！")
                return;
            }
            //判断密码两次输入是否相同
            if (Password !== ConfirmPassword) {
                // 如果两次输入的密码不相同，提示用户密码不相同，并且返回
                $("#msg").html("两次输入的密码不相同！");
                return;
            }

            //判断是否输入地址
            if (isEmpty(Age) ){
                $("#msg").html("年龄不能为空！")
                return;
            }
            //判断手机号是否符合要求
            if (isEmpty(Contact) ){
                //如果联系方式为空，提示联系方式不能为空，返回
                $("#msg").html("联系方式不能为空！")
                return;
            }
            if (isEmpty(Department) ){
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
