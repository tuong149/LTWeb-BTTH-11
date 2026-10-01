package vn.iotstar.service.impl;

import vn.iotstar.dao.IUserDao_24110375;
import vn.iotstar.dao.impl.UserDaoImpl_24110375;
import vn.iotstar.entity.User_24110375;
import vn.iotstar.service.IUserService_24110375;

public class UserServiceImpl_24110375 implements IUserService_24110375 {

    private IUserDao_24110375 userDao = new UserDaoImpl_24110375();

    @Override
    public User_24110375 login(String username, String password) {
        User_24110375 user = userDao.findByUsername(username);
        if (user != null && user.getPassword().equals(password)) {
            return user;
        }
        return null;
    }

    @Override
    public void register(User_24110375 user) {
        userDao.insert(user);
    }

    @Override
    public boolean checkExistUsername(String username) {
        return userDao.findByUsername(username) != null;
    }

    @Override
    public boolean checkExistEmail(String email) {
        return userDao.findByEmail(email) != null;
    }
}

