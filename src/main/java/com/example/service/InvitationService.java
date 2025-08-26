package com.example.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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

	// 초대장 리스트 셀렉트

    public List<InvitationVO> exeInvtList(int userNo){
        return invitationRepository.selectInvitationList(userNo);
    }
}
