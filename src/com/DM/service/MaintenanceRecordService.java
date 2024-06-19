package com.DM.service;

import com.DM.entity.MaintenanceRecord;
import com.DM.entity.vo.MessageModel;
import com.DM.mapper.MaintenanceRecordMapper;
import com.DM.util.GetSqlSession;
import org.apache.ibatis.session.SqlSession;

import java.util.List;

public class MaintenanceRecordService {
    public MessageModel selectMaintenanceRecordByID(int teacherID) {
        MessageModel messageModel = new MessageModel();
        SqlSession session = GetSqlSession.createSqlSession();
        try {
            MaintenanceRecordMapper maintenanceRecordMapper = session.getMapper(MaintenanceRecordMapper.class);
            List<MaintenanceRecord> maintenanceRecordList = maintenanceRecordMapper.selectMaintenanceRecordByID(teacherID);
            messageModel.setObject(maintenanceRecordList);
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
