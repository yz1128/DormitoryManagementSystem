package com.DM.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/deleteMaintenanceRecordServlet")
public class DeleteMaintenanceRecordServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // JDBC连接信息（根据实际情况修改）
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/dormitorymanagementsystem?serverTimezone=GMT%2B8";
    private static final String JDBC_USERNAME = "root";
    private static final String JDBC_PASSWORD = "123456";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        // 从请求中获取宿舍ID
        String recordID = request.getParameter("recordID");

        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            // 连接数据库
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD);

            // 准备删除维护记录的SQL语句
            String sql = "DELETE FROM maintenancerecords WHERE RecordID = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, recordID);

            // 执行SQL语句
            int rowsDeleted = stmt.executeUpdate();

            // 处理删除结果
            if (rowsDeleted > 0) {
                response.getWriter().println("维修记录删除成功。");
            } else {
                response.getWriter().println("未找到该维修记录。");
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
