package com.javaex.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.javaex.vo.BlogVo;
import com.javaex.vo.CategoryVo;
import com.javaex.vo.PostVo;
import com.javaex.vo.UserVo;

@Repository
public class JblogDao {

	@Autowired
	private SqlSession sqlSession;

	public int insert(UserVo userVo) {
		return sqlSession.insert("jblog.insert", userVo);			
	}

	public BlogVo select(String id) {
		return sqlSession.selectOne("jblog.select", id);
	}

	public int update(BlogVo blogVo) {
		return sqlSession.update("jblog.update", blogVo);
	}
	public List<CategoryVo> selectAll(String id) {
		return sqlSession.selectList("jblog.selectAll", id);
	}

	public CategoryVo insert(CategoryVo categoryVo) {
		sqlSession.insert("jblog.insertcate", categoryVo);
		int searchcate = categoryVo.getCATENO();
		return sqlSession.selectOne("jblog.searchcate",searchcate);
	}

	public int delete(CategoryVo categoryVo) {
		return sqlSession.delete("jblog.delete",categoryVo);
	}

	public int insertwrite(PostVo postVo) {
		return sqlSession.insert("jblog.insertwrite", postVo);
	}

	public List<CategoryVo> selectlist(String id) {
		return sqlSession.selectList("jblog.selectlist", id);
	}

	public int update(int cateNo) {
		return sqlSession.update("jblog.updateNo", cateNo);
	}

	public PostVo selectpost(String id) {
		return sqlSession.selectOne("jblog.selectpost", id);
	}

	public List<PostVo> selectpostAll(String id) {
		return  sqlSession.selectList("jblog.selectPostList", id);
	}

}
