package com.DM.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/addNotificationServlet")
public class AddNotificationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // JDBC连接信息（根据实际情况修改）
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/dormitorymanagementsystem?serverTimezone=GMT%2B8";
    private static final String JDBC_USERNAME = "root";
    private static final String JDBC_PASSWORD = "123456";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        // 获取参数
        int userID = Integer.parseInt(request.getParameter("userID"));
        String title = request.getParameter("title");
        String content = request.getParameter("content");

        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            // 连接数据库
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD);

            // 检查是否已存在相同userID和title的通知记录
            boolean notificationExists = checkNotificationExists(conn, userID, title);

            if (notificationExists) {
                // 更新通知记录
                String updateSql = "UPDATE notifications SET Content = ? WHERE UserID = ? AND Title = ?";
                stmt = conn.prepareStatement(updateSql);
                stmt.setString(1, content);
                stmt.setInt(2, userID);
                stmt.setString(3, title);
            } else {
                // 插入新的通知记录
                String insertSql = "INSERT INTO notifications (UserID, Title, Content, Date) VALUES (?, ?, ?, NOW())";
                stmt = conn.prepareStatement(insertSql);
                stmt.setInt(1, userID);
                stmt.setString(2, title);
                stmt.setString(3, content);
            }

            // 执行SQL语句
            int rowsAffected = stmt.executeUpdate();

            // 检查操作是否成功
            if (rowsAffected > 0) {
                response.getWriter().println("通知添加成功。");
                response.sendRedirect("ADNotification.jsp");
            } else {
                response.getWriter().println("通知添加失败。");
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

    // 辅助方法：检查是否已存在相同userID和title的通知记录
    private boolean checkNotificationExists(Connection conn, int userID, String title) throws SQLException {
        String sql = "SELECT COUNT(*) AS count FROM notifications WHERE UserID = ? AND Title = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userID);
            stmt.setString(2, title);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    int count = rs.getInt("count");
                    return count > 0;
                }
            }
        }
        return false;
    }
}
