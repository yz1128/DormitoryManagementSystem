package com.DM.mapper;

import com.DM.entity.User;

/**
 * 用户接口类
 */
public interface UserMapper {
    User queryUserByName(String userName);

}
