package com.DM.controller;

import com.DM.entity.Teacher;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet(name = "addMaintenanceRecord", value = "/addMaintenanceRecord")
public class AddMaintenanceRecordServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    // JDBC连接信息（根据实际情况修改）
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/dormitorymanagementsystem?serverTimezone=GMT%2B8";
    private static final String JDBC_USERNAME = "root";
    private static final String JDBC_PASSWORD = "123456";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 获取参数
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        String dormID = request.getParameter("dormID");
        String content = request.getParameter("content");

        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            // 连接数据库
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD);

            // 准备SQL语句
            String sql = "INSERT INTO maintenancerecords (DormID,Content) VALUES (?, ?)";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, dormID);
            stmt.setString(2, content);

            // 执行SQL语句
            int rowsAffected = stmt.executeUpdate();

            // 检查插入是否成功
            if (rowsAffected > 0) {
                response.getWriter().println("报修成功");
            } else {
                response.getWriter().println("报修失败");
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
