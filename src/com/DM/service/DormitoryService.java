package com.DM.service;

import com.DM.entity.Dormitories;
import com.DM.entity.vo.MessageModel;
import com.DM.mapper.DormitoryMapper;
import com.DM.util.GetSqlSession;
import org.apache.ibatis.session.SqlSession;

import java.util.List;

public class DormitoryService {
    public MessageModel getDormitoryData() {
        MessageModel messageModel = new MessageModel();
        SqlSession session = GetSqlSession.createSqlSession();
        try {
            DormitoryMapper dormitoryMapper = session.getMapper(DormitoryMapper.class);
            List<Dormitories> dormitoryList = dormitoryMapper.findAllDormitory();
            messageModel.setObject(dormitoryList);
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

