package com.DM.mapper;

import com.DM.entity.CheckInRecord;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface CheckInRecordMapper {
    List<CheckInRecord> selectRecordByID(int teacherID);
    List<CheckInRecord> selectRecord();
    int updateCheckOutDate(@Param("recordID") int recordID, @Param("checkOutDate") String checkOutDate);
    int addCheckInRecord(int teacherID,String dormID);
}
