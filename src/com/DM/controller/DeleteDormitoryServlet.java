package com.DM.controller;

import com.DM.entity.vo.MessageModel;

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

@WebServlet("/deleteDormitoryServlet")
public class DeleteDormitoryServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // JDBC连接信息（根据实际情况修改）
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/dormitorymanagementsystem?serverTimezone=GMT%2B8";
    private static final String JDBC_USERNAME = "root";
    private static final String JDBC_PASSWORD = "123456";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 从请求中获取宿舍ID
        String dormID = request.getParameter("dormID");

        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            // 连接数据库
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD);

            // 准备删除宿舍的SQL语句
            String sql = "DELETE FROM dormitories WHERE DormID = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, dormID);

            // 执行SQL语句
            int rowsDeleted = stmt.executeUpdate();

            // 处理删除结果
            if (rowsDeleted > 0) {
                MessageModel messageModel = new MessageModel();
                messageModel.setMsg("Dormitory deleted successfully!");
                request.setAttribute("messageModel", messageModel);
            } else {
                MessageModel messageModel = new MessageModel();
                messageModel.setMsg("No dormitory found for the provided DormID.");
                request.setAttribute("messageModel", messageModel);
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

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}
