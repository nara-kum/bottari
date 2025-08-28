package com.example.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.vo.CalenderVO;
import com.example.vo.InvitationVO;
import com.example.vo.ProductVO;

@Repository
public class CalenderRepository {
	// field
	@Autowired
	private SqlSession sqlsession;
	// editor

	// method g/s

	// method normal

	// 캘린더 리스트
	public List<CalenderVO> calenderAddList(int user_no) {
		System.out.println("CalenderRepository.addList()");

		List<CalenderVO> calenderList = sqlsession.selectList("calender.selectList", user_no);

		return calenderList;
	}

	// 캘린더 초대장 호출
	public List<InvitationVO> getInvitationList(int event_id) {
		System.out.println("CalenderRepository.getInvitattionList()");

		List<InvitationVO> invitationList = sqlsession.selectList("calender.getInvitationList", event_id);
		
		System.out.println(invitationList);

		return invitationList;
	}

	// 캘린더 펀딩리스트 호출
	public List<ProductVO> getProductList(int event_id) {
		System.out.println("CalenderRepository.getproductList()");
		
		List<ProductVO> productList = sqlsession.selectList("calender.getProductList", event_id);
		
		return productList;
	}

	// 캘린더 이벤트 추가
	public int calenderInsert(CalenderVO calendervo) {
		System.out.println("CalenderRepository.calenderInsert()");
//		System.out.println("CalenderRepository.calendervo" + calendervo);

		int count = sqlsession.insert("calender.insert", calendervo);

		return count;
	}

	// 캘린더 이벤트 수정
	public int calenderUpdate(CalenderVO calendervo) {
		System.out.println("CalenderRepository.calenderUpdate()");

		System.out.println("CalenderRepository.calndervo:" + calendervo);

		int count = sqlsession.update("calender.update", calendervo);

		return count;
	}

	// 캘린더 이벤트 삭제
	public int calenderDelete(CalenderVO calendervo) {
		System.out.println("CalenderRepository.calenderDelte()");
		
		int count = sqlsession.delete("calender.delete", calendervo);
		
		return count;
	}
}
