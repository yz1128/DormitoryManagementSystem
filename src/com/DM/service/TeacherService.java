package com.DM.service;

import com.DM.entity.Teacher;
import com.DM.entity.vo.MessageModel;
import com.DM.mapper.TeacherMapper;
import com.DM.util.GetSqlSession;
import com.DM.util.StringUtil;
import org.apache.ibatis.session.SqlSession;

public class TeacherService {
    public MessageModel TeacherLogin(String TeacherID, String Password) {
        MessageModel messageModel = new MessageModel();

        //回显数据
        Teacher t = new Teacher();
        t.setTeacherID(TeacherID);
        t.setPassword(Password);
        messageModel.setObject(t);

        // 1. 参数的非空判断
        if (StringUtil.isEmpty(TeacherID) || StringUtil.isEmpty(Password)) {
            //将状态码、提示信息、回想数据设置到消息模型中，返回消息模型对象
            messageModel.setCode(0);
            messageModel.setMsg("用户姓名和密码不能为空！");
            return messageModel;
        }
        SqlSession session = GetSqlSession.createSqlSession();
        // 2.调用dao层的查询方法，通过用户名查询用户对象
        try {

            TeacherMapper teacherMapper = session.getMapper(TeacherMapper.class);
            Teacher teacher = teacherMapper.queryTeacherByID(TeacherID);
            // 3.判断用户对象是否为空
            if (teacher == null) {
                messageModel.setCode(0);
                messageModel.setMsg("用户不存在！");
                return messageModel;
            }

            // 4.判断数据库中查询到的用户密码与前台传递的密码作比较
            if (!Password.equals(teacher.getPassword())) {
                messageModel.setCode(0);
                messageModel.setMsg("用户密码不正确！");
                return messageModel;
            }
            // 登录成功，将用户信息设置到消息模型中
            messageModel.setObject(teacher);
            messageModel.setCode(1);
            messageModel.setMsg("登录成功！");
        } catch (Exception e) {
            // 发生异常时的处理
            e.printStackTrace();
            messageModel.setCode(0);
            messageModel.setMsg("登录失败，发生异常：" + e.getMessage());
        } finally {
            // 确保SqlSession被关闭
            if (session != null) {
                session.close();
            }
        }
        return messageModel;
    }
    public MessageModel TeacherRegister(String TeacherID, String Password, String Name,String Gender,String Age,String Contact,String Department) {
        MessageModel messageModel = new MessageModel();

        //回显数据
        Teacher t = new Teacher();
        t.setTeacherID(TeacherID);
        t.setPassword(Password);
        t.setName(Name);
        t.setGender(Gender);
        t.setAge(Age);
        t.setContact(Contact);
        t.setDepartment(Department);
        messageModel.setObject(t);

        // 1. 检查输入的必填字段是否为空
        if (StringUtil.isEmpty(TeacherID) || StringUtil.isEmpty(Password) || StringUtil.isEmpty(Name) || StringUtil.isEmpty(Gender) || StringUtil.isEmpty(Age) || StringUtil.isEmpty(Contact) || StringUtil.isEmpty(Department)) {
            messageModel.setCode(0);
            messageModel.setMsg("注册信息不能为空！");
            return messageModel;
        }

        SqlSession session = GetSqlSession.createSqlSession();
        try {
            TeacherMapper teacherMapper = session.getMapper(TeacherMapper.class);
            Teacher existingTeacher = teacherMapper.queryTeacherByID(TeacherID);
            if (existingTeacher != null) {
                messageModel.setCode(0);
                messageModel.setMsg("教工号已被注册！");
                return messageModel;
            }
            int rowsAffected = teacherMapper.insertTeacher(t);
            if (rowsAffected > 0) {
                messageModel.setCode(1);
                messageModel.setMsg("注册成功！");
                session.commit();
            } else {
                messageModel.setCode(0);
                messageModel.setMsg("注册失败，请稍后重试！");
            }
        } catch (Exception e) {
            e.printStackTrace();
            messageModel.setCode(0);
            messageModel.setMsg("注册失败，发生异常：" + e.getMessage());
        } finally {
            session.close();
        }
        return messageModel;
    }
    public MessageModel updatePassword(String TeacherID, String currentPassword, String newPassword1, String newPassword2) {
        MessageModel messageModel = new MessageModel();

        // 回显数据
        Teacher teacher = new Teacher();
        teacher.setTeacherID(TeacherID);
        teacher.setPassword(currentPassword);
        messageModel.setObject(teacher);

        // 1. 参数的非空判断
        if (StringUtil.isEmpty(currentPassword) || StringUtil.isEmpty(newPassword1) || StringUtil.isEmpty(newPassword2)) {
            messageModel.setCode(0);
            messageModel.setMsg("密码不能为空！");
            return messageModel;
        }

        // 2. 调用DAO层的查询方法，通过教师ID查询教师对象
        SqlSession session = GetSqlSession.createSqlSession();
        try {
            TeacherMapper teacherMapper = session.getMapper(TeacherMapper.class);
            Teacher existingTeacher = teacherMapper.queryTeacherByID(TeacherID);

            // 3. 判断数据库中查询到的教师密码与当前密码作比较
            if (!currentPassword.equals(existingTeacher.getPassword())) {
                messageModel.setCode(0);
                messageModel.setMsg("当前密码不正确！");
                return messageModel;
            } else if (!newPassword1.equals(newPassword2)) {
                messageModel.setCode(0);
                messageModel.setMsg("两次输入的新密码不相同！");
                return messageModel;
            }

            // 4. 更新教师密码
            existingTeacher.setPassword(newPassword1);
            int rowsAffected = teacherMapper.updatePassword(existingTeacher);

            if (rowsAffected > 0) {
                messageModel.setCode(1);
                messageModel.setMsg("密码修改成功！");
                session.commit();
            } else {
                messageModel.setCode(0);
                messageModel.setMsg("密码修改失败，请稍后重试！");
            }
        } catch (Exception e) {
            e.printStackTrace();
            messageModel.setCode(0);
            messageModel.setMsg("修改失败，发生异常：" + e.getMessage());
        } finally {
            session.close();
        }
        return messageModel;
    }
}
