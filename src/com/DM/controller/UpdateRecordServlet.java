package com.DM.controller;

import com.DM.entity.vo.MessageModel;
import com.DM.service.CheckInRecordService;
import com.google.gson.Gson;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "updateRecordServlet", value = "/updateRecordServlet")
public class UpdateRecordServlet extends HttpServlet {
    private CheckInRecordService checkInRecordService = new CheckInRecordService();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 设置请求和响应的编码为UTF-8
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html;charset=UTF-8");

        int recordID = Integer.parseInt(req.getParameter("recordID"));
        String checkOutDate = req.getParameter("checkOutDate");

        MessageModel messageModel = checkInRecordService.updateCheckOutDate(recordID, checkOutDate);
        resp.setContentType("application/json");
        resp.getWriter().write(new Gson().toJson(messageModel));
    }
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }
}
