package com.DM.service;

import com.DM.entity.CheckInRecord;
import com.DM.entity.vo.MessageModel;
import com.DM.mapper.CheckInRecordMapper;
import com.DM.util.GetSqlSession;
import org.apache.ibatis.session.SqlSession;

import java.util.List;

public class CheckInRecordService {
    public MessageModel selectCheckInRecordByID(int teacherID) {
        MessageModel messageModel = new MessageModel();
        SqlSession session = GetSqlSession.createSqlSession();
        try {
            CheckInRecordMapper checkInRecordMapper = session.getMapper(CheckInRecordMapper.class);
            List<CheckInRecord> checkInRecordList = checkInRecordMapper.selectRecordByID(teacherID);
            messageModel.setObject(checkInRecordList);
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
