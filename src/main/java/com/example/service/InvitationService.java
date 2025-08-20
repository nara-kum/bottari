package com.example.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.repository.InvitationRepository;
import com.example.vo.InvitationVO;

@Service
public class InvitationService {
	
	@Autowired
	private InvitationRepository invitationRepository;
	
	public int exeInvt(InvitationVO invitationVO){
		System.out.println("InvitationService.exeInvt()");
		
		int count = invitationRepository.insertInvi(invitationVO);
		
		return count;
		
	}

	
}
		