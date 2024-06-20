package com.DM.mapper;

import com.DM.entity.CheckInRecord;

import java.util.List;

public interface CheckInRecordMapper {
    List<CheckInRecord> selectRecordByID(int teacherID);
}
