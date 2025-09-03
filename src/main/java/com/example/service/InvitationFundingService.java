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

	private static final org.slf4j.Logger log = org.slf4j.LoggerFactory.getLogger(InvitationFundingService.class);

	public Integer getEventNoOnly(int invitationNo) {
		return fundingQueryRepository.selectEventNoByInvitationNo(invitationNo);
	}
	// 마이펀딩 

    public List<Map<String,Object>> getMyFundingCards(int userNo){
        return fundingQueryRepository.selectMyFundingCards(userNo);
    }

    @Transactional
    public int stopFunding(int userNo, int fundingNo){
        int n = fundingQueryRepository.updateFundingStatusStop(userNo, fundingNo);
        if (n > 0) {
            // 소유자 중단 성공 시, 참여자 결제 전부 cancel
            fundingQueryRepository.cancelAllPaymentsByFunding(fundingNo);
        }
        return n;
    }

    @Transactional
    public int completeFunding(int userNo, int fundingNo){
        return fundingQueryRepository.updateFundingStatusDone(userNo, fundingNo);
    }
	
	// 친구 펀딩 
    public List<Map<String,Object>> getFriendFundingList(int userNo){
        List<Map<String,Object>> list = fundingQueryRepository.selectFriendFundingCards(userNo);
        return list == null ? Collections.emptyList() : list;
    }
    //삭제 
    /** 내가 참여한 펀딩 취소*/
    @Transactional
    public int cancelMyFunding(int userNo, int fundingNo){
        // 필요 시 유효성(존재/상태) 체크 로직 추가 가능
        return fundingQueryRepository.updateMyPaymentsByFunding(userNo, fundingNo);
    }

	/** 초대장번호 → 이벤트번호 → 카드목록 */
	public List<Map<String, Object>> getCardsByInvitationPublic(int invitationNo) {
		Integer eventNo = getEventNoOnly(invitationNo);
		log.info("[INV] invNo={} -> eventNo={}", invitationNo, eventNo);
		if (eventNo == null)
			return java.util.Collections.emptyList();
		List<Map<String, Object>> list = fundingQueryRepository.selectGiftsPublicByEvent(eventNo);
		log.info("[INV] eventNo={} -> cards={}", eventNo, (list == null ? 0 : list.size()));
		return (list == null ? java.util.Collections.emptyList() : list);
	}

	/** 이벤트번호로 카드목록 */
	public List<Map<String, Object>> getCardsByEventPublic(int eventNo) {
		return fundingQueryRepository.selectGiftsPublicByEvent(eventNo);
	}

	/** 특정 펀딩 한 건 */
	public List<Map<String, Object>> getCardsByFundingPublic(int fundingNo) {
		return fundingQueryRepository.selectGiftsPublicByFunding(fundingNo);
	}

	/** 결제 누적 */
	public int getTotalPaid(int fundingNo) {
		Integer val = fundingQueryRepository.selectTotalPaidByFunding(fundingNo);
		return val == null ? 0 : val;
	}
	
	// 총합
	public long getTotalPaidByFundingNo(long fundingNo) {
		Long v = fundingQueryRepository.selectTotalPayByFundingNo(fundingNo);
		return (v == null ? 0L : v);
	}
	
	public List<Map<String,Object>> getParticipantsByFundingNo(long fundingNo){
	    return fundingQueryRepository.selectParticipantsByFundingNo(fundingNo);
	}

	public Integer getFundingOwnerUserNo(long fundingNo){
	    return fundingQueryRepository.selectFundingOwnerUserNo(fundingNo);
	}

}
