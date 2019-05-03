package com.javaex.dao;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.javaex.vo.UserVo;

@Repository
public class UserDao {

	@Autowired
	private SqlSession sqlSession;
	
	public int insert(UserVo userVo) {
		return sqlSession.insert("user.insert", userVo);	
	}

	public UserVo select(String id) {
		return sqlSession.selectOne("user.selectByEmail", id);
	}

	/* 회원정보 가져오기(id, password) */
	public UserVo select(String id, String password) {
		Map<String, Object> userMap = new HashMap<String, Object>();
		userMap.put("id", id);
		userMap.put("password", password);
		return sqlSession.selectOne("user.select", userMap);
	}

}
