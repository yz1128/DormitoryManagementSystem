package com.DM.service;

import com.DM.entity.Notification;
import com.DM.entity.vo.MessageModel;
import com.DM.mapper.NotificationMapper;
import com.DM.util.GetSqlSession;
import org.apache.ibatis.session.SqlSession;

import java.util.List;

public class NotificationService {
    public MessageModel getNotificationData() {
        MessageModel messageModel = new MessageModel();
        SqlSession session = GetSqlSession.createSqlSession();
        try {
            NotificationMapper notificationMapper = session.getMapper(NotificationMapper.class);
            List<Notification> notificationList = notificationMapper.findAllNotification();
            messageModel.setObject(notificationList);
            messageModel.setCode(1);
            messageModel.setMsg("查询成功！");
        } catch (Exception e) {
            e.printStackTrace();
            messageModel.setCode(0);
            messageModel.setMsg("搜索失败，发生异常：" + e.getMessage());
        } finally {
            session.close();
        }
        return messageModel;
    }
}
