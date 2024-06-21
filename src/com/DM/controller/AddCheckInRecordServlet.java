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

@WebServlet(name = "addCheckInRecord", value = "/addCheckInRecord")
public class AddCheckInRecordServlet extends HttpServlet {
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
        int teacherID = Integer.parseInt(request.getParameter("teacherID"));
        String dormID = request.getParameter("dormID");

        Connection conn = null;
        PreparedStatement insertStmt = null;
        PreparedStatement updateStmt = null;

        try {
            // 连接数据库
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD);

            // 开始事务
            conn.setAutoCommit(false);

            // 准备插入入住记录的SQL语句
            String insertSql = "INSERT INTO checkinrecords (TeacherID, DormID) VALUES (?, ?)";
            insertStmt = conn.prepareStatement(insertSql);
            insertStmt.setInt(1, teacherID);
            insertStmt.setString(2, dormID);

            // 准备更新宿舍状态的SQL语句
            String updateSql = "UPDATE dormitories SET Status = 'Occupied' WHERE DormID = ?";
            updateStmt = conn.prepareStatement(updateSql);
            updateStmt.setString(1, dormID);

            // 执行插入语句
            int rowsInserted = insertStmt.executeUpdate();

            // 执行更新语句
            int rowsUpdated = updateStmt.executeUpdate();

            // 提交事务
            if (rowsInserted > 0 && rowsUpdated > 0) {
                conn.commit();
                response.getWriter().println("成功添加入住记录或更新宿舍状态。");
            } else {
                conn.rollback();
                response.getWriter().println("未添加入住记录或更新宿舍状态。");
            }

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        } finally {
            // 关闭连接和语句
            try {
                if (insertStmt != null) {
                    insertStmt.close();
                }
                if (updateStmt != null) {
                    updateStmt.close();
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
