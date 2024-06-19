package com.DM.controller;

import com.DM.entity.vo.MessageModel;
import com.DM.service.MaintenanceRecordService;
import com.google.gson.Gson;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "selectMRByIDServlet", value = "/selectMRByIDServlet")
public class selectMRByIDServlet extends HttpServlet {
    protected MaintenanceRecordService maintenanceRecordService = new MaintenanceRecordService();
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        String teacherID = request.getParameter("teacherID");
        // 创建一个消息模型对象
        MessageModel messageModel = maintenanceRecordService.selectMaintenanceRecordByID(Integer.parseInt(teacherID));
        // 转换为 JSON 格式
        Gson gson = new Gson();
        String json = gson.toJson(messageModel.getObject());

        // 发送 JSON 数据到前端
        PrintWriter out = response.getWriter();
        out.print(json);
        out.flush();
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
