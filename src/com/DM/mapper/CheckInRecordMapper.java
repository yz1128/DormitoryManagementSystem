package com.DM.mapper;

import com.DM.entity.CheckInRecord;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface CheckInRecordMapper {
    List<CheckInRecord> selectRecordByID(int teacherID);
    int updateCheckOutDate(@Param("recordID") int recordID, @Param("checkOutDate") String checkOutDate);
}
