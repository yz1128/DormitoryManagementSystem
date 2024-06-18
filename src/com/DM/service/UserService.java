package com.DM.service;

import com.DM.entity.User;
import com.DM.entity.vo.MessageModel;
import com.DM.mapper.UserMapper;
import com.DM.util.GetSqlSession;
import com.DM.util.StringUtil;
import org.apache.ibatis.session.SqlSession;

/**
 * 业务逻辑
 */
public class UserService {
    public MessageModel userLogin(String userName, String Password) {
        MessageModel messageModel = new MessageModel();

        //回显数据
        User u = new User();
        u.setUserName(userName);
        u.setUserPassword(Password);
        messageModel.setObject(u);

        // 1. 参数的非空判断
        if (StringUtil.isEmpty(userName) || StringUtil.isEmpty(Password)) {
            //将状态码、提示信息、回想数据设置到消息模型中，返回消息模型对象
            messageModel.setCode(0);
            messageModel.setMsg("用户姓名和密码不能为空！");
            return messageModel;
        }
        SqlSession session = GetSqlSession.createSqlSession();
        // 2.调用dao层的查询方法，通过用户名查询用户对象
        try {

            UserMapper userMapper = session.getMapper(UserMapper.class);
            User user = userMapper.queryUserByName(userName);
            // 3.判断用户对象是否为空
            if (user == null) {
                messageModel.setCode(0);
                messageModel.setMsg("用户不存在！");
                return messageModel;
            }

            // 4.判断数据库中查询到的用户密码与前台传递的密码作比较
            if (!Password.equals(user.getUserPassword())) {
                messageModel.setCode(0);
                messageModel.setMsg("用户密码不正确！");
                return messageModel;
            }
            // 登录成功，将用户信息设置到消息模型中
            messageModel.setObject(user);
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
}

