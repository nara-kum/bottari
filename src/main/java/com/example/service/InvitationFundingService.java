// src/main/java/com/example/service/InvitationFundingService.java
package com.example.service;

import java.util.Collections;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.repository.FundingQueryRepository;

@Service
@Transactional(readOnly = true)
public class InvitationFundingService {

	@Autowired
    private FundingQueryRepository fundingQueryRepository;

//    public InvitationFundingService(FundingQueryRepository fundingQueryRepository) {
//        this.fundingQueryRepository = fundingQueryRepository;
//    }

    /** 초대장번호 → 이벤트번호 → 카드목록 */
    public List<Map<String,Object>> getCardsByInvitationPublic(int invitationNo){
        Integer eventNo = fundingQueryRepository.selectEventNoByInvitationNo(invitationNo);
        if (eventNo == null) return Collections.emptyList();
        return getCardsByEventPublic(eventNo);
    }

    /** 이벤트번호로 카드목록 */
    public List<Map<String,Object>> getCardsByEventPublic(int eventNo){
        return fundingQueryRepository.selectGiftsPublicByEvent(eventNo);
    }

    /** 특정 펀딩 한 건 */
    public List<Map<String,Object>> getCardsByFundingPublic(int fundingNo){
        return fundingQueryRepository.selectGiftsPublicByFunding(fundingNo);
    }

    /** 결제 누적 */
    public int getTotalPaid(int fundingNo){
        Integer val = fundingQueryRepository.selectTotalPaidByFunding(fundingNo);
        return val == null ? 0 : val;
    }
}
