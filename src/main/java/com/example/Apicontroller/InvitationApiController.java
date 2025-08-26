package com.example.Apicontroller;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDate;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.example.service.InvitationService;
import com.example.vo.InvitationVO;
import com.example.vo.UserVO;
import com.javaex.util.JsonResult;

import jakarta.servlet.http.HttpSession;

@RestController
public class InvitationApiController {

    @Autowired
    private InvitationService invitationService;

    /** 초대장 등록 */
    @PostMapping("/api/invtreg")
    public JsonResult invtReg(@RequestBody InvitationVO invitationVO, HttpSession session) {
        System.out.println("InvitationApiController.invtReg()");
        System.out.println(invitationVO);

        UserVO authUser = (UserVO) session.getAttribute("authUser");
        if (authUser == null) {
            return JsonResult.fail("로그인이 필요합니다.");
        }
        invitationVO.setUserNo(authUser.getUserNo());

        // 필수값 검증
        if (invitationVO.getCategoryNo() == 0
                || invitationVO.getEventNo() == 0
                || invitationVO.getCelebrateDate() == null
                || invitationVO.getCelebrateDate().isBlank()) {
            return JsonResult.fail("필수 항목을 확인해주세요.");
        }

        int cnt = invitationService.exeInvtReg(invitationVO);
        if (cnt > 0) {
            return JsonResult.success(invitationVO);
        }
        return JsonResult.fail("초대장 등록에 실패했습니다.");
    }

    /** 내 초대장 목록 */
    @GetMapping("/api/invtlist")
    public JsonResult invtList(HttpSession session) {
        System.out.println("InvitationApiController.invtList()");

        UserVO authUser = (UserVO) session.getAttribute("authUser");
        if (authUser == null) {
            return JsonResult.fail("로그인이 필요합니다.");
        }

        List<InvitationVO> list = invitationService.exeInvtList(authUser.getUserNo());
        if (list == null) list = Collections.emptyList();
        return JsonResult.success(list);
    }

    /**
     * 대표 이미지 업로드 (멀티파트)
     * 반환 url 예: /upload/invitation/2025/09/UUID.jpg  ← WebMvcConfig 매핑과 일치
     */
    @PostMapping("/api/invitation/photo")
    public JsonResult uploadInvitationPhoto(@RequestParam("file") MultipartFile file,
                                            HttpSession session) {
        try {
            UserVO authUser = (UserVO) session.getAttribute("authUser");
            if (authUser == null) {
                return JsonResult.fail("로그인이 필요합니다.");
            }
            if (file == null || file.isEmpty()) {
                return JsonResult.fail("파일이 없습니다.");
            }
            if (file.getSize() > 15L * 1024 * 1024) { // 15MB
                return JsonResult.fail("이미지 크기는 15MB 이내여야 합니다.");
            }
            String contentType = file.getContentType();
            if (contentType == null || !contentType.toLowerCase().startsWith("image/")) {
                return JsonResult.fail("이미지 파일만 업로드 가능합니다.");
            }

            // === WebMvcConfig 과 동일한 루트 사용 (/upload/** -> 실제 폴더) ===
            String osName = System.getProperty("os.name").toLowerCase();
            String root = osName.contains("win")
                          ? "C:/javaStudy/upload"
                          : "/data/upload";

            // /upload/invitation/YYYY/MM/ 경로로 저장
            LocalDate today = LocalDate.now();
            String y = String.format("%04d", today.getYear());
            String m = String.format("%02d", today.getMonthValue());

            Path dir = Paths.get(root, "invitation", y, m);
            Files.createDirectories(dir);

            String original = file.getOriginalFilename();
            String ext = "";
            if (original != null && original.lastIndexOf('.') >= 0) {
                ext = original.substring(original.lastIndexOf('.')); // .jpg/.png...
            }
            String filename = UUID.randomUUID().toString().replace("-", "") + ext;

            Path target = dir.resolve(filename);
            file.transferTo(target.toFile());

            // WebMvcConfig: /upload/** 매핑이므로, 클라이언트에는 아래 URL을 내려줌
            String webUrl = "/upload/invitation/" + y + "/" + m + "/" + filename;

            Map<String, Object> data = new HashMap<>();
            data.put("url", webUrl);
            return JsonResult.success(data);

        } catch (Exception e) {
            e.printStackTrace();
            return JsonResult.fail("이미지 업로드 중 오류가 발생했습니다.");
        }
    }
}
