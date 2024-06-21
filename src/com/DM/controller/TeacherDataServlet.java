package com.DM.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.DM.entity.Teacher;
import com.google.gson.Gson;

@WebServlet("/teacherDataServlet")
public class TeacherDataServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // JDBC连接信息（根据实际情况修改）
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/dormitorymanagementsystem?serverTimezone=GMT%2B8";
    private static final String JDBC_USERNAME = "root";
    private static final String JDBC_PASSWORD = "123456";

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }

    private void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        List<Teacher> teachers = new ArrayList<>();

        try {
            // 连接数据库
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD);

            // 准备选择所有教师记录的SQL语句
            String sql = "SELECT * FROM teachers";
            stmt = conn.prepareStatement(sql);

            // 执行SQL语句
            rs = stmt.executeQuery();

            // 处理结果集
            while (rs.next()) {
                Teacher teacher = new Teacher();
                teacher.setTeacherID(rs.getString("TeacherID"));
                teacher.setPassword(rs.getString("Password"));
                teacher.setName(rs.getString("Name"));
                teacher.setGender(rs.getString("Gender"));
                teacher.setAge(rs.getString("Age"));
                teacher.setContact(rs.getString("Contact"));
                teacher.setDepartment(rs.getString("Department"));
                teachers.add(teacher);
            }

            // 将结果转换为JSON格式
            Gson gson = new Gson();
            String json = gson.toJson(teachers);

            // 设置响应内容类型和编码
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");

            // 将JSON结果写入响应
            response.getWriter().write(json);

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        } finally {
            // 关闭连接和语句
            try {
                if (rs != null) {
                    rs.close();
                }
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
