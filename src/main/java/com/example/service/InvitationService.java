package com.example.service;

import java.io.OutputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.example.repository.InvitationRepository;
import com.example.vo.InvitationVO;

@Service
public class InvitationService {

	@Autowired
	private InvitationRepository invitationRepository;

	// 초대장 등록
	public int exeInvtReg(InvitationVO invitationVO) {
		System.out.println("InvitationService.exeInvt()");

		int count = invitationRepository.insertInvi(invitationVO);

		return count;

	}

	// 이미지 저장
	public String save(MultipartFile file) {
		System.out.println("InvitationService.save()");

		try {
			String os = System.getProperty("os.name").toLowerCase();
			String baseDir = os.contains("win") ? "C:/javaStudy/upload/" : "/data/upload/";
			Files.createDirectories(Paths.get(baseDir));

			String org = file.getOriginalFilename();
			String ext = "";
			if (org != null && org.lastIndexOf('.') > -1) {
				ext = org.substring(org.lastIndexOf('.'));
			}
			String saveName = System.currentTimeMillis() + "_" + UUID.randomUUID().toString().replace("-", "") + ext;
			Path target = Paths.get(baseDir, saveName);

			try (OutputStream out = Files.newOutputStream(target)) {
				out.write(file.getBytes());
			}
			// WebMvcConfig 의 addResourceHandlers("/upload/**") 와 매칭되는 URL 반환
			return "/upload/" + saveName;
		} catch (Exception e) {
			throw new RuntimeException("파일 저장 실패", e);
		}
	}

	// 초대장 리스트 셀렉트
	public List<InvitationVO> exeInvtList(int userNo) {
		return invitationRepository.selectInvitationList(userNo);
	}

	// 초대장 단건

	public Map<String, Object> getInvitationViewBundle(int invitationNo, int userNo) {
		// 1) 초대장 상세 (userNo로 소유권 검증)
		Map<String, Object> detail = invitationRepository.selectInvitationDetail(Map.of("invitationNo", invitationNo, "userNo", userNo));
		if (detail == null)
			return null;

		// 2) detail에서 eventNo 꺼내 선물 조회
		Integer eventNo = (Integer) detail.get("eventNo"); // mapper에서 AS eventNo 보장
		List<Map<String, Object>> gifts = (eventNo == null) ? List.of()
				: invitationRepository.selectGiftsByEvent(Map.of("userNo", userNo, "eventNo", eventNo));

		// 3) 합쳐서 반환
		Map<String, Object> out = new HashMap<>();
		out.put("detail", detail);
		out.put("gifts", gifts);
		
		return out;
	}

}
