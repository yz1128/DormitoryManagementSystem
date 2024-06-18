package com.DM.controller;

import com.DM.entity.Teacher;
import com.DM.entity.vo.MessageModel;
import com.DM.service.TeacherService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/register")
public class registerServlet extends HttpServlet {

    // 实例化UserService对象
    private TeacherService teacherService = new TeacherService();


    /**
     * 用户登录
     *   １.接收客户端的请求（接受参数：姓名、密码）
     *   ２.调用service层的方法，返回消息模型对象
     *   ３.判断消息模型状态码
     *      如果状态码是失败
     *          将消息模型对象设置到request作用域中，请求转发跳转到login.jsp
     *      如果状态码是成功
     *          将消息模型中的用户信息设置到session作用域中，重定向跳转到index．jsp
     *   ４.请求转发跳转到登录页面
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        //1.接收客户端的请求（接受参数：姓名、密码）
        String teacherID = request.getParameter("TeacherID");
        String password = request.getParameter("Password");
        String name = request.getParameter("Name");
        String gender = request.getParameter("Gender");
        String age = request.getParameter("Age");
        String contact = request.getParameter("Contact");
        String department = request.getParameter("Department");


        //２.调用service层的方法，返回消息模型对象
        MessageModel messageModel = teacherService.TeacherRegister(teacherID, password, name, gender, age, contact, department);
        //3.判断消息模型状态码
        if (messageModel.getCode() == 1) {//成功
            //将消息模型中的用户信息设置到session作用域中，重定向跳转到login.jsp
            request.getSession().setAttribute("user", messageModel.getObject());
            response.sendRedirect("login.jsp");
        } else {//失败
            //将消息模型对象设置到request作用域中，请求转发跳转到login.jsp
            request.setAttribute("messageModel", messageModel);
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }

}
