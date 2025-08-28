package com.example.Apicontroller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.example.service.CalenderService;
import com.example.vo.CalenderVO;
import com.example.vo.InvitationVO;
import com.example.vo.ProductVO;
import com.example.vo.UserVO;

import jakarta.servlet.http.HttpSession;

@RestController
@RequestMapping("api/calender")
public class CalenderApiController {
	// field
	@Autowired
	private CalenderService calenderservice;
	// editor

	// method g/s

	// method normal

	// 이벤트 연결 펀딩 리스트, 초대장 호출
	@RequestMapping(value = "/event-details", method = { RequestMethod.GET, RequestMethod.POST })
	public ResponseEntity<Map<String, Object>> getEventDetails(@RequestParam("event_no") int event_no) {
		System.out.println("CalenderApiController.getEventDetails()");

		Map<String, Object> result = new HashMap<>();

		System.out.println(event_no);

		try {
			// DB에서 가져오기
			List<InvitationVO> invitationList = calenderservice.exegetInvitationList(event_no);
			List<ProductVO> productList = calenderservice.exegetProductList(event_no);

			result.put("success", true);
			result.put("fundingList", productList);
			result.put("invitationList", invitationList);

			System.out.println("invitationList Count:" + invitationList.size());
			for(int i = 0 ; i<invitationList.size() ; i++) {
				System.out.println(invitationList.get(i));
			}
			
			System.out.println("fundingList Count:" + productList.size());

			return ResponseEntity.ok(result);

		} catch (Exception e) {
			System.err.println("에러 발생: " + e.getMessage());
			e.printStackTrace();

			result.put("success", false);
			result.put("error", e.getMessage());

			return ResponseEntity.status(500).body(result);
		}
	}

	// 캘린더 이벤트 등록
	@RequestMapping(value = "/event/insert", method = { RequestMethod.GET, RequestMethod.POST })
	public ResponseEntity<Map<String, Object>> createEvent(CalenderVO calendervo, HttpSession session) {
		System.out.println("CalendarRestController.createEvent()");

		Map<String, Object> result = new HashMap<>();

		try {
			// 로그인 사용자 확인
			UserVO authUser = (UserVO) session.getAttribute("authUser");
			if (authUser == null) {
				result.put("success", false);
				result.put("error", "로그인이 필요합니다.");
				return ResponseEntity.status(401).body(result);
			}

			calendervo.setUser_no(authUser.getUserNo());
			System.out.println("등록할 이벤트: " + calendervo);

			int count = calenderservice.exeInsertCalender(calendervo);

			if (count > 0) {
				int generatedEventNo = calendervo.getEvent_no();
				System.out.println("저장된 이벤트의 아이디:" + generatedEventNo);

				result.put("success", true);
				result.put("message", "이벤트가 성공적으로 등록되었습니다.");
				result.put("event_no", generatedEventNo);
				
			} else {
				result.put("success", false);
				result.put("error", "이벤트 등록에 실패했습니다.");
			}

			return ResponseEntity.ok(result);

		} catch (Exception e) {
			System.err.println("이벤트 등록 중 에러 발생: " + e.getMessage());
			e.printStackTrace();

			result.put("success", false);
			result.put("error", e.getMessage());

			return ResponseEntity.status(500).body(result);
		}
	}

	// 캘린더 이벤트 수정
	@RequestMapping(value = "/event/update", method = { RequestMethod.GET, RequestMethod.POST })
	public ResponseEntity<Map<String, Object>> updateEvent(CalenderVO calenderVO, HttpSession session) {
		System.out.println("CalendarRestController.updateEvent()");

		Map<String, Object> result = new HashMap<>();

		try {
			// 로그인 사용자 확인
			UserVO authUser = (UserVO) session.getAttribute("authUser");
			if (authUser == null) {
				result.put("success", false);
				result.put("error", "로그인이 필요합니다.");
				return ResponseEntity.status(401).body(result);
			}

			System.out.println("수정할 이벤트: " + calenderVO);

			int count = calenderservice.exeUpdateCalender(calenderVO);

			if (count > 0) {
				result.put("success", true);
				result.put("message", "이벤트가 성공적으로 수정되었습니다.");
			} else {
				result.put("success", false);
				result.put("error", "이벤트 수정에 실패했습니다.");
			}

			return ResponseEntity.ok(result);

		} catch (Exception e) {
			System.err.println("이벤트 수정 중 에러 발생: " + e.getMessage());
			e.printStackTrace();

			result.put("success", false);
			result.put("error", e.getMessage());

			return ResponseEntity.status(500).body(result);
		}
	}

	// 캘린더 이벤트 삭제
	@RequestMapping(value = "/event/delete", method = { RequestMethod.GET, RequestMethod.POST })
	public ResponseEntity<Map<String, Object>> deleteEvent(@RequestParam("event_no") int eventNo, HttpSession session) {
		System.out.println("CalendarRestController.deleteEvent() - event_no: " + eventNo);

		Map<String, Object> result = new HashMap<>();

		try {
			// 로그인 사용자 확인
			UserVO authUser = (UserVO) session.getAttribute("authUser");
			if (authUser == null) {
				result.put("success", false);
				result.put("error", "로그인이 필요합니다.");
				return ResponseEntity.status(401).body(result);
			}

			CalenderVO calenderVO = new CalenderVO();
			calenderVO.setEvent_no(eventNo);

			int count = calenderservice.exeDeleteCalender(calenderVO);

			if (count > 0) {
				result.put("success", true);
				result.put("message", "이벤트가 성공적으로 삭제되었습니다.");
			} else {
				result.put("success", false);
				result.put("error", "이벤트 삭제에 실패했습니다.");
			}

			return ResponseEntity.ok(result);

		} catch (Exception e) {
			System.err.println("이벤트 삭제 중 에러 발생: " + e.getMessage());
			e.printStackTrace();

			result.put("success", false);
			result.put("error", e.getMessage());

			return ResponseEntity.status(500).body(result);
		}
	}

}
