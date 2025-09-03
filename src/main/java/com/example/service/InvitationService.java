package com.example.service;

import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.example.repository.InvitationRepository;
import com.example.vo.InvitationVO;

@Service
public class InvitationService {

	@Autowired
	private InvitationRepository invitationRepository;
	
	@Value("${file.upload-dir}")                          // 프로필별 업로드 루트 디렉터리 주입
    private String uploadDir;                             // ex) local: C:/javaStudy/upload, prod: /data/upload


	// 초대장 등록
	public int exeInvtReg(InvitationVO invitationVO) {
		System.out.println("InvitationService.exeInvt()");

		int count = invitationRepository.insertInvi(invitationVO);

		return count;

	}

//	// 이미지 저장
//	public String save(MultipartFile file) {
//		System.out.println("InvitationService.save()");
//
//		try {
//			String os = System.getProperty("os.name").toLowerCase();
//			String baseDir = os.contains("win") ? "C:/javaStudy/upload/" : "/data/upload/";
//			Files.createDirectories(Paths.get(baseDir));
//			System.out.println(baseDir);
//
//			String org = file.getOriginalFilename();
//			String ext = "";
//			if (org != null && org.lastIndexOf('.') > -1) {
//				ext = org.substring(org.lastIndexOf('.'));
//			}
//			System.out.println("org :" + org);
//			System.out.println("ext :" + ext);
//			String saveName = System.currentTimeMillis() + "_" + UUID.randomUUID().toString().replace("-", "") + ext;
//			Path target = Paths.get(baseDir, saveName);
//			System.out.println("target :" + target);
//
//			try (OutputStream out = Files.newOutputStream(target)) {
//				out.write(file.getBytes());
//			}
//			// WebMvcConfig 의 addResourceHandlers("/upload/**") 와 매칭되는 URL 반환
//			return "/upload/" + saveName;
//		} catch (Exception e) {
//			throw new RuntimeException("파일 저장 실패", e);
//		}
//	}
	
	// 이미지 저장 (URL 반환) — OS 감지 제거, 프로퍼티 기반으로 저장
    public String save(MultipartFile file) {
        System.out.println("InvitationService.save()");

        try {
            // 0) 유효성 체크
            if (file == null || file.isEmpty()) {         // 빈 파일 방지
                throw new IllegalArgumentException("빈 파일입니다.");
            }

            // 1) 업로드 루트 폴더 보장 (프로필에서 주입된 경로 사용)
            Path root = Paths.get(normalizeDir(uploadDir)); // OS 무관 경로 객체 생성
            Files.createDirectories(root);                 // 폴더 없으면 생성

            // 2) 저장 파일명 생성 (원본 확장자 유지 + UUID)
            String org = file.getOriginalFilename();      // 원본 파일명
            String ext = extractExt(org);                 // 확장자 (.png 등) 추출
            String saveName = System.currentTimeMillis() + "_" 
                              + UUID.randomUUID().toString().replace("-", "") 
                              + ext;                      // 충돌 방지용 파일명

            // 3) 최종 저장 경로 계산 + 경로 탈출 방지
            Path target = root.resolve(saveName).normalize(); // root/saveName
            if (!target.startsWith(root)) {               // ../ 등 경로 탈출 방지
                throw new SecurityException("허용되지 않은 경로입니다.");
            }

            // 4) 실제 저장 (MultipartFile → 파일)
            file.transferTo(target.toFile());             // 심플하고 안전한 저장 방식

            // 5) 브라우저에서 접근 가능한 URL 반환 (/upload/** → WebMvcConfig에서 매핑)
            String encoded = URLEncoder.encode(saveName, StandardCharsets.UTF_8); // 한글/공백 안전
            return "/upload/" + encoded;                  // ex) /upload/550e84...0000.png
        } catch (Exception e) {
            throw new RuntimeException("파일 저장 실패", e); // 공통 예외 포장
        }
    }

    // 확장자 추출 헬퍼 (없으면 빈 문자열)
    private String extractExt(String filename) {
        if (filename == null) return "";
        int idx = filename.lastIndexOf('.');
        return (idx >= 0) ? filename.substring(idx) : "";
    }

    // 디렉터리 경로 정규화 (역슬래시→슬래시, 끝 슬래시 제거)
    private String normalizeDir(String path) {
        String p = path.replace("\\", "/");               // 윈도우 호환
        if (p.endsWith("/")) p = p.substring(0, p.length() - 1);
        return p;
    }

	// 초대장 리스트 셀렉트
	public List<InvitationVO> exeInvtList(int userNo) {
		return invitationRepository.selectInvitationList(userNo);
	}

	public Map<String, Object> getInvitationDetail(int invitationNo, int userNo) {
		return invitationRepository.selectInvitationDetail(Map.of("invitationNo", invitationNo, "userNo", userNo));
	}

	public int updateInvitation(InvitationVO vo) {
		return invitationRepository.updateInvitation(vo);
	}

	public int deleteInvitation(int invitationNo, int userNo) {
		return invitationRepository.deleteInvitation(Map.of("invitationNo", invitationNo, "userNo", userNo));
	}

	// 초대장 단건
	public Map<String, Object> getInvitationViewBundle(int invitationNo, int userNo) {
		// 1) 초대장 상세 (userNo로 소유권 검증)
		Map<String, Object> detail = invitationRepository
				.selectInvitationDetail(Map.of("invitationNo", invitationNo, "userNo", userNo));
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

	// ✅ 공유/공개용: 소유자 제약 없이 '전체 필드' 반환
	public Map<String, Object> getInvitationViewBundleAny(int invitationNo) {
		Map<String, Object> detail = invitationRepository.selectInvitationFullAny(invitationNo);
		if (detail == null || detail.isEmpty())
			return null;

		Map<String, Object> bundle = new HashMap<>();
		bundle.put("detail", detail);
		return bundle;
	}

	/** ✅ 공개: 이벤트별 펀딩 카드 목록 */
	public List<Map<String, Object>> getGiftsPublicByEvent(int eventNo) {
		return invitationRepository.selectGiftsPublicByEvent(eventNo);
	}

}
