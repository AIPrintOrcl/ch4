package com.fastcampus.ch4.dao;

import com.fastcampus.ch4.domain.*;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Repository;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;

@Repository
public class UserDaoImpl implements UserDao {
    @Autowired
    SqlSession session;

    private String namespace = "com.fastcampus.ch4.dao.UserMapper.";

    @Override
    public int deleteUser(String id) throws Exception {
        int rowCnt = 0;
        String sql = "DELETE FROM user_info WHERE id= ? ";

        return rowCnt;
    }

    @Override
    public User selectUser(String id) throws Exception {
        User user = null;

        user = session.selectOne( namespace + "selectUser", id );

        String sql = "SELECT * FROM user_info WHERE id= ? ";

        return user;
    }

    // 사용자 정보를 user_info테이블에 저장하는 메서드
    @Override
    public int insertUser(User user) throws Exception {
        int rowCnt = 0;
        String sql = "INSERT INTO user_info VALUES (?,?,?,?,?,?, now()) ";

        return rowCnt;
    }

    @Override
    public int updateUser(User user) throws Exception {
        int rowCnt = 0;

        String sql = "UPDATE user_info " +
                     "SET pwd = ?, name=?, email=?, birth =?, sns=?, reg_date=? " +
                     "WHERE id = ? ";

        return rowCnt;
    }

    @Override
    public int count() throws Exception {
        String sql = "SELECT count(*) FROM user_info ";

        int count=0;

        return count;
    }

    @Override
    public void deleteAll() throws Exception {

            String sql = "DELETE FROM user_info ";
    }
}
