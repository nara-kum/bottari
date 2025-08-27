package com.example.Apicontroller;

import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

	// 초대장 등록
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
		if (invitationVO.getCategoryNo() == 0 || invitationVO.getEventNo() == 0
				|| invitationVO.getCelebrateDate() == null || invitationVO.getCelebrateDate().isBlank()) {
			return JsonResult.fail("필수 항목을 확인해주세요.");
		}

		int cnt = invitationService.exeInvtReg(invitationVO);

		if (cnt > 0) {
			return JsonResult.success(invitationVO);
		}
		return JsonResult.fail("초대장 등록에 실패했습니다.");
	}

	// 이미지 업로드
	@PostMapping("/api/upload")
	public JsonResult upload(@RequestParam("file") MultipartFile file, HttpSession session) {
		System.out.println("InvitationApiController.upload()");

		UserVO authUser = (UserVO) session.getAttribute("authUser");
		if (authUser == null) {
			return JsonResult.fail("로그인이 필요합니다.");
		}
		if (file == null || file.isEmpty()) {
			return JsonResult.fail("파일이 없습니다.");
		}

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
		if (authUser == null) {
			return JsonResult.fail("로그인이 필요합니다.");
		}

		List<InvitationVO> list = invitationService.exeInvtList(authUser.getUserNo());
		if (list == null)
			list = Collections.emptyList();
		return JsonResult.success(list);
	}

	// 초대장 전체보기(불러오기)
	@GetMapping("/api/invtview")
	public JsonResult view(@RequestParam("no") int invitationNo, HttpSession session) {
		UserVO authUser = (UserVO) session.getAttribute("authUser");
		if (authUser == null)
			return JsonResult.fail("로그인이 필요합니다.");

		Map<String, Object> bundle = invitationService.getInvitationViewBundle(invitationNo, authUser.getUserNo());
		
		if (bundle == null) {
			return JsonResult.fail("존재하지 않거나 권한이 없습니다.");
		}
			
		return JsonResult.success(bundle); // { detail:{...}, gifts:[...] }
	}

}
