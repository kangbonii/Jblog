package com.javaex.service;

import java.io.BufferedOutputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.javaex.dao.JblogDao;
import com.javaex.vo.BlogVo;
import com.javaex.vo.CategoryVo;
import com.javaex.vo.FileVo;
import com.javaex.vo.PostVo;

@Service
public class JblogService {
	@Autowired
	private JblogDao jblogDao;

	public BlogVo getTitle(String id) {
		// TODO Auto-generated method stub
		System.out.print(id);
		return jblogDao.select(id);
	}
	/*
	 * public int modify(BlogVo blogVo) { return jblogDao.update(blogVo); }
	 */

	public int restore(MultipartFile file, BlogVo blogVo) {

		String savaDir = "/home/bituser/upload";

		// 오리지널 파일명
		String orgName = file.getOriginalFilename();
		System.out.println(orgName);

		// 확장자
		String exName = file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf("."));
		System.out.println(exName);

		// 저장할 파일명
		String saveName = System.currentTimeMillis() + UUID.randomUUID().toString() + exName;
		System.out.println(saveName);

		// 파일패스
		String filePath = savaDir + "/" + saveName;
		System.out.println(filePath);

		// 파일 사이즈
		long fileSize = file.getSize();
		System.out.println(fileSize);

		FileVo fileVo = new FileVo(filePath, orgName, saveName, fileSize);
		System.out.println(fileVo.toString());

		// 서버에 파일복사

		try {
			byte[] fileData = file.getBytes();
			OutputStream out = new FileOutputStream(savaDir + "/" + saveName);
			BufferedOutputStream bout = new BufferedOutputStream(out);

			bout.write(fileData);

			if (bout != null) {
				bout.close();
			}
		} catch (IOException e) {
			e.printStackTrace();
		}

		// filevo DB저장
		blogVo.setLogoFile(saveName);
		
		
		// 화면에 등록한 이미지띄우기
		return jblogDao.update(blogVo);
	}
	

	public List<CategoryVo> getList(String id) {
		return jblogDao.selectAll(id);
	}

	public CategoryVo addcate(CategoryVo categoryVo) {
		return jblogDao.insert(categoryVo);
	}

	public int delete(CategoryVo categoryVo) {
		return jblogDao.delete(categoryVo);
	}

	public int write(PostVo postVo) {
		jblogDao.insertwrite(postVo);
		return jblogDao.update(postVo.getCateNo());
	}

	public List<CategoryVo> readList(String id) {
		return jblogDao.selectlist(id);
	}

	public PostVo getPost(String id) {
		return jblogDao.selectpost(id);
	}

	public List<PostVo> postList(String id) {
		return  jblogDao.selectpostAll(id);
	}


	
	
	
}
