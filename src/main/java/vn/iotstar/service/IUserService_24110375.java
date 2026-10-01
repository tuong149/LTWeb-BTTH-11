package vn.iotstar.service;

import vn.iotstar.entity.User_24110375;

public interface IUserService_24110375 {
    User_24110375 login(String username, String password);
    void register(User_24110375 user);
    boolean checkExistUsername(String username);
    boolean checkExistEmail(String email);
}

