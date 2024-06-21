package com.DM.controller;

import com.DM.entity.vo.MessageModel;

import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/addTeacherServlet")
public class AddTeacherServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // JDBC连接信息（根据实际情况修改）
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/dormitorymanagementsystem?serverTimezone=GMT%2B8";
    private static final String JDBC_USERNAME = "root";
    private static final String JDBC_PASSWORD = "123456";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        // 从请求中获取教师数据
        String teacherID = request.getParameter("teacherID");
        String password = request.getParameter("password");
        String name = request.getParameter("name");
        String gender = request.getParameter("gender");
        String age = request.getParameter("age");
        String contact = request.getParameter("contact");
        String department = request.getParameter("department");

        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            // 连接数据库
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD);

            // 检查是否已存在相同的teacherID
            String checkSql = "SELECT * FROM teachers WHERE TeacherID = ?";
            stmt = conn.prepareStatement(checkSql);
            stmt.setString(1, teacherID);
            rs = stmt.executeQuery();

            if (rs.next()) {
                // 如果存在相同的teacherID，更新记录
                String updateSql = "UPDATE teachers SET Password = ?, Name = ?, Gender = ?, Age = ?, Contact = ?, Department = ? WHERE TeacherID = ?";
                stmt = conn.prepareStatement(updateSql);
                stmt.setString(1, password);
                stmt.setString(2, name);
                stmt.setString(3, gender);
                stmt.setString(4, age);
                stmt.setString(5, contact);
                stmt.setString(6, department);
                stmt.setString(7, teacherID);
                int rowsUpdated = stmt.executeUpdate();

                // 处理更新结果
                if (rowsUpdated > 0) {
                    response.sendRedirect("ADTeacher.jsp");
                } else {
                    response.getWriter().println("更新教工信息失败。");
                }
            } else {
                // 如果不存在相同的teacherID，插入新记录
                String insertSql = "INSERT INTO teachers (TeacherID, Password, Name, Gender, Age, Contact, Department) VALUES (?, ?, ?, ?, ?, ?, ?)";
                stmt = conn.prepareStatement(insertSql);
                stmt.setString(1, teacherID);
                stmt.setString(2, password);
                stmt.setString(3, name);
                stmt.setString(4, gender);
                stmt.setString(5, age);
                stmt.setString(6, contact);
                stmt.setString(7, department);

                // 执行SQL语句
                int rowsInserted = stmt.executeUpdate();

                // 处理插入结果
                if (rowsInserted > 0) {
                    response.sendRedirect("ADTeacher.jsp");
                } else {
                    response.getWriter().println("添加教工失败。");
                }
            }

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        } finally {
            // 关闭连接和语句
            try {
                if (stmt != null) {
                    stmt.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
