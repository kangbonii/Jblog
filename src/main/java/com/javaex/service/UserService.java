package com.javaex.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.javaex.dao.JblogDao;
import com.javaex.dao.UserDao;
import com.javaex.vo.UserVo;

@Service
public class UserService {

	@Autowired
	private UserDao userDao;
	
	@Autowired
	private JblogDao jblogDao;

	/* 회원가입 */
	public int join(UserVo userVo) {
		int count = userDao.insert(userVo);
		jblogDao.insert(userVo);
		return count;
	}

	public boolean emailCheck(String id) {
		UserVo vo = userDao.select(id);
		// 데이터가 없을때 true--->가입할 수 있음
		if (vo == null) {
			return true;
		} else {
			return false;
		}
	}
	
	
	/* 로그인 */
	public UserVo login(String id, String password) {
		return userDao.select(id, password);
	}
}
