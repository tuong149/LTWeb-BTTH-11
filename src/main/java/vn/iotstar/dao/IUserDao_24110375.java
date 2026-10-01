package vn.iotstar.dao;

import vn.iotstar.entity.User_24110375;

public interface IUserDao_24110375 {
    User_24110375 findByUsername(String username);
    User_24110375 findByEmail(String email);
    void insert(User_24110375 user);
    void update(User_24110375 user);
}

