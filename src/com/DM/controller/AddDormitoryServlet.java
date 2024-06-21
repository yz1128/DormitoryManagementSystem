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

@WebServlet("/addDormitoryServlet")
public class AddDormitoryServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // JDBC连接信息（根据实际情况修改）
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/dormitorymanagementsystem?serverTimezone=GMT%2B8";
    private static final String JDBC_USERNAME = "root";
    private static final String JDBC_PASSWORD = "123456";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 从请求中获取宿舍信息
        String dormID = request.getParameter("dormID");
        String buildingNumber = request.getParameter("buildingNumber");
        String floor = request.getParameter("floor");
        String rooms = request.getParameter("rooms");
        String status = request.getParameter("status");

        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            // 连接数据库
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD);

            // 准备插入宿舍信息的SQL语句
            String sql = "INSERT INTO dormitories (DormID, BuildingNumber, Floor, Rooms) VALUES (?, ?, ?, ?)";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, dormID);
            stmt.setString(2, buildingNumber);
            stmt.setInt(3, Integer.parseInt(floor));
            stmt.setInt(4, Integer.parseInt(rooms));

            // 执行SQL语句
            int rowsInserted = stmt.executeUpdate();

            // 处理插入结果

            if (rowsInserted > 0) {
                response.sendRedirect("ADDormitories.jsp");
            } else {
                response.getWriter().println("Failed to add dormitory.");
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
