package com.example.Apicontroller;

import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
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

    // 초대장 등록
    @PostMapping("/api/invtreg")
    public JsonResult invtReg(@RequestBody InvitationVO invitationVO, HttpSession session) {
        System.out.println("InvitationApiController.invtReg()");

        UserVO authUser = (UserVO) session.getAttribute("authUser");
        if (authUser == null) return JsonResult.fail("로그인이 필요합니다.");

        invitationVO.setUserNo(authUser.getUserNo());

        // 필수값 검증
        if (invitationVO.getCategoryNo() == 0 ||
            invitationVO.getEventNo() == 0 ||
            invitationVO.getCelebrateDate() == null ||
            invitationVO.getCelebrateDate().isBlank()) {
            return JsonResult.fail("필수 항목을 확인해주세요.");
        }

        int cnt = invitationService.exeInvtReg(invitationVO);
        return (cnt > 0) ? JsonResult.success(invitationVO)
                         : JsonResult.fail("초대장 등록에 실패했습니다.");
    }

    // 이미지 업로드
    @PostMapping("/api/upload")
    public JsonResult upload(@RequestParam("file") MultipartFile file, HttpSession session) {
        System.out.println("InvitationApiController.upload()");

        UserVO authUser = (UserVO) session.getAttribute("authUser");
        if (authUser == null) return JsonResult.fail("로그인이 필요합니다.");
        if (file == null || file.isEmpty()) return JsonResult.fail("파일이 없습니다.");

        String url = invitationService.save(file);
        Map<String, Object> data = new HashMap<>();
        data.put("url", url);
        return JsonResult.success(data);
    }

    // 내 초대장 목록
    @GetMapping("/api/invtlist")
    public JsonResult invtList(HttpSession session) {
        System.out.println("InvitationApiController.invtList()");

        UserVO authUser = (UserVO) session.getAttribute("authUser");
        if (authUser == null) return JsonResult.fail("로그인이 필요합니다.");

        List<InvitationVO> list = invitationService.exeInvtList(authUser.getUserNo());
        if (list == null) list = Collections.emptyList();
        return JsonResult.success(list);
    }

    // (관리/수정) 상세: 소유자 검증 포함
    @GetMapping("/api/invtdetail")
    public JsonResult detail(@RequestParam("no") int invitationNo, HttpSession session) {
        UserVO auth = (UserVO) session.getAttribute("authUser");
        if (auth == null) return JsonResult.fail("로그인이 필요합니다.");

        Map<String, Object> detail = invitationService.getInvitationDetail(invitationNo, auth.getUserNo());
        if (detail == null) return JsonResult.fail("존재하지 않거나 권한이 없습니다.");
        return JsonResult.success(detail);
    }

    // 초대장 수정 저장 (PUT 대신 POST)
    @PostMapping("/api/invt/update")
    public JsonResult update(@RequestBody InvitationVO vo, HttpSession session) {
        UserVO auth = (UserVO) session.getAttribute("authUser");
        if (auth == null) return JsonResult.fail("로그인이 필요합니다.");
        if (vo.getInvitationNo() == 0) return JsonResult.fail("invitationNo 누락");

        vo.setUserNo(auth.getUserNo());
        int cnt = invitationService.updateInvitation(vo);
        return (cnt > 0) ? JsonResult.success(vo) : JsonResult.fail("수정 실패");
    }

    // 초대장 삭제
    @DeleteMapping("/api/invt/{no}")
    public JsonResult delete(@PathVariable("no") int invitationNo, HttpSession session) {
        UserVO auth = (UserVO) session.getAttribute("authUser");
        if (auth == null) return JsonResult.fail("로그인이 필요합니다.");

        int cnt = invitationService.deleteInvitation(invitationNo, auth.getUserNo());
        return (cnt > 0) ? JsonResult.success(cnt) : JsonResult.fail("삭제 실패");
    }

    // (보기/공유) 초대장 + 펀딩카드(그래프)
    @GetMapping("/api/invtview")
    public JsonResult view(@RequestParam("no") int invitationNo, HttpSession session) {
        UserVO authUser = (UserVO) session.getAttribute("authUser");
        if (authUser == null) return JsonResult.fail("로그인이 필요합니다.");

        Map<String, Object> bundle = invitationService.getInvitationViewBundle(invitationNo, authUser.getUserNo());
        if (bundle == null) return JsonResult.fail("존재하지 않거나 권한이 없습니다.");
        return JsonResult.success(bundle);
    }
}
