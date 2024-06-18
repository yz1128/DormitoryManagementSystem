package com.DM.mapper;

import com.DM.entity.Teacher;


public interface TeacherMapper {
    int insertTeacher(Teacher teacher);
    Teacher queryTeacherByID(String TeacherID);

}
