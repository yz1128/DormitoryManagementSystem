package com.DM.mapper;

import com.DM.entity.MaintenanceRecord;

import java.util.List;

public interface MaintenanceRecordMapper {
    List<MaintenanceRecord> selectMaintenanceRecordByID(int teacherID);
}
