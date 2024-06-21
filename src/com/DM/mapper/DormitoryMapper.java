package com.DM.mapper;

import com.DM.entity.Dormitories;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Update;

import java.util.List;

public interface DormitoryMapper {
     List<Dormitories> findAllDormitory();
     int updateDormStatusByRecordID(@Param("recordID") int recordID);
}
