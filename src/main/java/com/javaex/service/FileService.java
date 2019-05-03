package com.javaex.service;

import java.io.BufferedOutputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.UUID;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.javaex.vo.BlogVo;
import com.javaex.vo.FileVo;

@Service
public class FileService {
	public FileVo restore(MultipartFile file, BlogVo blogVo) {

		String savaDir = "D:\\bitStudy\\upload";

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
		String filePath = savaDir + "\\" + saveName;
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
		return fileVo;
	}
}
